#!/usr/bin/env bash

# Kubernetes helpers
# https://github.com/rafi/.config
# ---
# Formatting output: https://kubernetes.io/docs/reference/kubectl/overview/#formatting-output
# JSONPath support: https://kubernetes.io/docs/reference/kubectl/jsonpath/

# PODS
# ---

# Display Pod workload information
alias kp='kubectl get pods -o custom-columns=NAME:.metadata.name,STATUS:.status.phase,RESTARTS:.status.containerStatuses[*].restartCount,M_REQUESTS:.spec.containers[*].resources.requests.memory,M_LIMITS:.spec.containers[*].resources.limits.memory,NODE_IP:.status.hostIP,POD_IP:.status.podIP'

# Display Pod's images
alias kpi='kubectl get pods -o custom-columns=POD:.metadata.name,IMAGES:.spec..image'

# Count Pod's total images
alias kpicount="kubectl get pods -A -o jsonpath=\"{.items[*]['spec.containers', 'spec.initContainers'][*].image}\" | tr -s '[[:space:]]' '\n' | sort | uniq -c | sort -nr"

# Show recent Pod termination states
alias kprestarts='kubectl get pod -o=custom-columns=NAME:.metadata.name,RESTARTS:..restartCount,REASON:..reason,EXIT_CODE:..lastState.terminated.exitCode,LAST_RESTART_TIME:..lastState.terminated.finishedAt --sort-by="{..lastState.terminated.finishedAt}"'

# Show non-running Pod list
alias kpnotready='kubectl get pod --no-headers --field-selector=status.phase!=Running'

# List unready Pods
function kphealth() {
	kubectl get pods -o json "$@" \
		| jq -r '.items[] | select(.status.phase != "Running" or ([ .status.conditions[] | select(.type == "Ready" and .status == "False") ] | length ) == 1 ) | .metadata.namespace + "/" + .metadata.name'
}

# Show human-readble init/containers status for each Pod
# shellcheck disable=2154
alias kpc="kubectl get pod -o go-template --template='{{range .items}}{{printf \"\033[48;5;236m:: \033[38;5;4m%-48s \033[38;5;242m%s as %s\033[K\033[0m\n\" .metadata.name .status.phase .status.qosClass}}{{if .status.initContainerStatuses }}{{range .status.initContainerStatuses}}{{printf \"\033[38;5;243m\t|->\033[0m \033[38;5;3m%-31s\\033[0m (init)\" .name}} {{range \$key, \$state := .state}} {{\"\033[38;5;243m\"}}{{if ne \$state.reason \"Completed\"}}{{\"\033[38;5;1m\"}}{{end}}{{\$key}}{{if \$state.reason}}/{{\$state.reason}}{{end}}{{if \$state.exitCode}}/{{\$state.exitCode}}{{end}}{{end}}{{if gt .restartCount 0}} {{\"\033[38;5;174m\"}}({{.restartCount}} restarts){{end}}{{\"\033[0m\n\"}}{{end}}{{end}}{{range .status.containerStatuses}}{{printf \"\033[38;5;243m\t|->\033[0m \033[38;5;2m%-38s\033[0m\" .name}} {{range \$key, \$state := .state}} {{\"\033[38;5;243m\"}}{{if ne \$key \"running\"}}{{\"\033[38;5;1m\"}}{{end}}{{\$key}}{{if \$state.reason}}/{{\$state.reason}}{{end}}{{if \$state.exitCode}}/{{\$state.exitCode}}{{end}}{{end}}{{if gt .restartCount 0}} {{\"\033[38;5;174m\"}}({{.restartCount}} restarts){{end}}{{\"\033[0m\n\"}}{{end}}{{end}}'"

# Use https://github.com/cykerway/complete-alias for bash alias completion
if type _complete_alias &>/dev/null; then
	complete -F _complete_alias kp
	complete -F _complete_alias kpc
	complete -F _complete_alias kpi
	complete -F _complete_alias kprestarts
	complete -F _complete_alias kpnotready
fi

function _rafi_k8s_parse_args() {
	declare -a args; args=()
	if [ "${1:0:1}" != "-" ]; then
		if [ -n "${1}" ]; then
			args+=("${1}")
			shift
		else
			args+=("pods")
		fi
	fi
	if [ "${1:0:1}" == "-" ] || [ -z "${1}" ]; then
		# FIXME: Need to iterate over all args and add -A if args doesn't include
		# -n/-A/--all-namespaces.
		args+=("-A")
	else
		args+=("-n")
	fi
	echo "${args[@]}" "$@"
}

# shellcheck disable=SC2046
kwatch() { kubectl get -w $(_rafi_k8s_parse_args "$@"); }
# shellcheck disable=SC2046
kget() { kubectl get $(_rafi_k8s_parse_args "$@"); }
# shellcheck disable=SC2046
# kdesc() { kubectl describe $(_rafi_k8s_parse_args "$@"); }

# Select resource with labels, sorted by ascending age.
function kgsort() {
	kubectl get $(_rafi_k8s_parse_args "$@") \
		--show-labels --sort-by .metadata.creationTimestamp --no-headers |
		fzf --tac
}

# shellcheck disable=SC2120
function _rafi_k8s_select_pod() {
	local kind="${1:-pods}"
	shift
	kubectl get "$kind" --all-namespaces "$@" \
		| fzf --header-lines=1 --prompt "$(kubectl config current-context)> " \
		| awk '{print $1 " " $2}'
}

# Pod commands with interactive selection.
alias kpdesc='_rafi_k8s_select_pod | xargs kubectl describe pod -n'
alias kpdelete='_rafi_k8s_select_pod | xargs kubectl delete pod -n'
alias kplog='_rafi_k8s_select_pod | xargs kubectl logs -f -n'
alias kpman='_rafi_k8s_select_pod | xargs kubectl get pod -o json -n | fx'
alias kpip='_rafi_k8s_select_pod | xargs kubectl get pod -o jsonpath="{.status.podIPs[*]}" -n | jq'
alias ksdconf="_rafi_k8s_select_pod secrets --field-selector type=kubernetes.io/dockerconfigjson | xargs kubectl get secret -o go-template='{{index .data \".dockerconfigjson\" | base64decode }}' -n | jq"

function kexec() {
	read -ra tokens < <(_rafi_k8s_select_pod)
	if [ ${#tokens} -gt 1 ]; then
		# Try bash first, then sh.
		kubectl exec -it --namespace "${tokens[@]}" -- bash \
			|| kubectl exec -it --namespace "${tokens[@]}" -- sh
	fi
}

# Live tail preview with fzf and follow log once selected.
# shellcheck disable=2016
function ktail() {
	read -ra tokens < <(
		kubectl get pods --all-namespaces |
			fzf --info=inline --layout=reverse --header-lines=1 \
					--prompt "$(kubectl config current-context)> " \
					--header $'Press CTRL-O to open log in editor\n\n' \
					--bind ctrl-/:toggle-preview \
					--bind 'ctrl-o:execute:${EDITOR:-nvim} <(kubectl logs --namespace {1} {2}) > /dev/tty' \
					--preview-window down,follow \
					--preview 'kubectl logs -f --tail=100 --all-containers --namespace {1} {2}' "$@"
	)
	[ ${#tokens} -gt 1 ] && kubectl logs -f --namespace "${tokens[@]}"
}

# NODES
# ---

# Wide informative Node list
alias knode='kubectl get node -owide'

alias ktaints='kubectl get nodes -o=custom-columns=NodeName:.metadata.name,TaintKey:.spec.taints[*].key,TaintValue:.spec.taints[*].value,TaintEffect:.spec.taints[*].effect'

# INGRESS
# ---

# Display in-depth Ingress objects
alias kingress='kubectl get ingress -o custom-columns="NAMESPACE:.metadata.namespace,NAME:.metadata.name,CLASS:.spec.ingressClassName,HOSTS:.spec.rules[*].host,PATHS:.spec.rules[*].http.paths[*].path"'

# Display even more robusy Ingress list
alias kingress-wide='kubectl get ingress -o custom-columns="NAMESPACE:.metadata.namespace,NAME:.metadata.name,CLASS:.spec.ingressClassName,HOSTS:.spec.rules[*].host,PATHS:.spec.rules[*].http.paths[*].path,SERVICES:.spec.rules[*].http.paths[*].backend.serviceName,PORTS:.spec.rules[*].http.paths[*].backend.servicePort"'

# EVENTS
# ---

# Order events by creation timestamp
alias kevents='kubectl get events --sort-by=.metadata.creationTimestamp'

# Show events by specific resource name, use with -A or -n
function kobjevents() {
	[ -z "$1" ] && echo "usage: kobjevents <object> [...]" && return 1
	local obj="${1}"
	shift
	kubectl get event \
		--field-selector "involvedObject.name=${obj}" \
		--sort-by=.metadata.creationTimestamp "$@"
# involvedObject.kind=Pod,
#  --sort-by='.lastTimestamp'
}

# METRICS
# ---

# Show cpu/memory matrix for pods, use with -A or -n <namespace>
function kstats() {
	local COLS="NAME:.metadata.name"
	COLS="$COLS,CPU_REQ(cores):.spec.containers[*].resources.requests.cpu"
	COLS="$COLS,MEMORY_REQ(bytes):.spec.containers[*].resources.requests.memory"
	COLS="$COLS,CPU_LIM(cores):.spec.containers[*].resources.limits.cpu"
	COLS="$COLS,MEMORY_LIM(bytes):.spec.containers[*].resources.limits.memory"

	local top; top="$(kubectl top pods "$@")"
	local pods; pods="$(kubectl get pods -o custom-columns="$COLS" "$@")"

	join -a1 -a2 -o 0,1.2,1.3,2.2,2.3,2.4,2.5, -e '<none>' \
		<(echo "$top") <(echo "$pods") | column -t -s' '
}

#  vim: set ft=sh ts=2 sw=2 tw=80 noet :
