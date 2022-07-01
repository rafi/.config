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
alias kpimgsum="kubectl get pods --all-namespaces -o jsonpath=\"{.items[*]['spec.containers', 'spec.initContainers'][*].image}\" | tr -s '[[:space:]]' '\n' | sort | uniq -c | sort -nr"

# List Pod's container names
alias kpcontainernames='kubectl get pod -o jsonpath="{..spec['"'"'containers'"'"','"'"'initContainers'"'"'][*].name}"'

# Show recent Pod termination states
alias kprestarts='kubectl get pod -o=custom-columns=NAME:.metadata.name,RESTARTS:..restartCount,REASON:..reason,EXIT_CODE:..lastState.terminated.exitCode,LAST_RESTART_TIME:..lastState.terminated.finishedAt --sort-by="{..lastState.terminated.finishedAt}"'

# Show non-running Pod list
alias kpnotready='kubectl get pod --no-headers --field-selector=status.phase!=Running'

# List unready Pods
function kphealth() {
	kubectl get pods -A -o json | jq -r '.items[] | select(.status.phase != "Running" or ([ .status.conditions[] | select(.type == "Ready" and .status == "False") ] | length ) == 1 ) | .metadata.namespace + "/" + .metadata.name'
}

# Show human-readble init/containers status for specific Pod
# shellcheck disable=2154
alias kcontainerstatus='kubectl get pod -o go-template --template='"'"'Pod: {{.metadata.name}}{{"\n"}}---{{"\n"}}Containers:{{"\n"}}{{range .status.containerStatuses}}  {{.name}} {{range $key, $state := .state}}  {{$key}}{{if $state.reason}}/{{$state.reason}}{{end}}{{if $state.exitCode}}/{{$state.exitCode}}{{end}}{{end}}{{if lt 0 .restartCount}}  ({{.restartCount}} restarts){{end}}{{"\n"}}{{end}}{{if .status.initContainerStatuses }}Init containers:{{"\n"}}{{range .status.initContainerStatuses}}  {{.name}} {{range $key, $state := .state}}  {{$key}}{{if $state.reason}}/{{$state.reason}}{{end}}{{if $state.exitCode}}/{{$state.exitCode}}{{end}}{{end}}{{if lt 0 .restartCount}}  ({{.restartCount}} restarts){{end}}{{"\n"}}{{end}}{{end}}'"'"

# Use https://github.com/cykerway/complete-alias for bash alias completion
# if [ "$(type -t _complete_alias)" = function ]; then
# 	complete -F _complete_alias kcontainerstatus
# fi

# Describe Pod with interactive selection.
function kpdesc() {
	read -ra tokens < <(
		kubectl get pods --all-namespaces \
			| fzf \
				--header-lines=1 \
				--prompt "$(kubectl config current-context | sed 's/-context$//')> "
	)
	[ ${#tokens} -gt 1 ] &&
		kubectl describe pod --namespace "${tokens[0]}" "${tokens[1]}"
}

# Exec into Pod with interactive selection.
function kexec() {
	read -ra tokens < <(
		kubectl get pods --all-namespaces \
			| fzf \
				--header-lines=1 \
				--prompt "$(kubectl config current-context | sed 's/-context$//')> "
	)
	if [ ${#tokens} -gt 1 ]; then
		# Try bash first, then sh.
		kubectl exec -it --namespace "${tokens[0]}" "${tokens[1]}" -- bash \
			|| kubectl exec -it --namespace "${tokens[0]}" "${tokens[1]}" -- sh
	fi
}

# Live tail preview with fzf and follow log once selected.
# shellcheck disable=2016
function ktail() {
	read -ra tokens < <(
		kubectl get pods --all-namespaces |
			fzf --info=inline --layout=reverse --header-lines=1 --border \
					--prompt "$(kubectl config current-context | sed 's/-context$//')> " \
					--header $'Press CTRL-O to open log in editor\n\n' \
					--bind ctrl-/:toggle-preview \
					--bind 'ctrl-o:execute:${EDITOR:-nvim} <(kubectl logs --namespace {1} {2}) > /dev/tty' \
					--preview-window down,follow \
					--preview 'kubectl logs -f --tail=100 --all-containers --namespace {1} {2}' "$@"
	)
	[ ${#tokens} -gt 1 ] &&
		kubectl logs -f --namespace "${tokens[0]}" "${tokens[1]}"
}

# INGRESS
# ---

# Display in-depth Ingress objects
alias kingress='kubectl get ingress -o custom-columns="NAMESPACE:.metadata.namespace,NAME:.metadata.name,CLASS:.metadata.annotations.kubernetes\.io/ingress\.class,HOSTS:.spec.rules[*].host,PATHS:.spec.rules[*].http.paths[*].path"'

# Display even more robusy Ingress list
alias kingress-wide='kubectl get ingress -o custom-columns="NAMESPACE:.metadata.namespace,NAME:.metadata.name,CLASS:.metadata.annotations.kubernetes\.io/ingress\.class,HOSTS:.spec.rules[*].host,PATHS:.spec.rules[*].http.paths[*].path,SERVICES:.spec.rules[*].http.paths[*].backend.serviceName,PORTS:.spec.rules[*].http.paths[*].backend.servicePort"'

# Wide informative Node list
alias knode='kubectl get node -owide'

# EVENTS
# ---

# Order events by creation timestamp
alias kevents='kubectl get events --sort-by=.metadata.creationTimestamp'

# Show events by specific resource name, use with -A or -n
function kobjevents() {
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

# Show cpu/memory matrix for pods, use with -A or -n
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
