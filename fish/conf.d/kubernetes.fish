# Kubernetes helpers
# https://github.com/rafi/.config
# ---
# Formatting output: https://kubernetes.io/docs/reference/kubectl/overview/#formatting-output
# JSONPath support: https://kubernetes.io/docs/reference/kubectl/jsonpath/

# PODS
# ---

# Display Pod workload information
alias kp "kubectl get pods -o custom-columns=':.metadata.namespace,NAME:.metadata.name,STATUS:.status.phase,RESTARTS:.status.containerStatuses[*].restartCount,M_REQUESTS:.spec.containers[*].resources.requests.memory,M_LIMITS:.spec.containers[*].resources.limits.memory,NODE:.spec.nodeName,IP:.status.podIP'"

# Display Pod's images
alias kpi "kubectl get pods -o custom-columns='POD:.metadata.name,IMAGES:.spec..image'"

# Count Pod's total images
alias kpicount "kubectl get pods -A -o jsonpath=\"{.items[*]['spec.containers', 'spec.initContainers'][*].image}\" | tr -s '[[:space:]]' '\n' | sort | uniq -c | sort -nr"

# Show recent Pod termination states
alias kprestarts "kubectl get pod -o=custom-columns=NAME:.metadata.name,RESTARTS:..restartCount,REASON:..reason,EXIT_CODE:..lastState.terminated.exitCode,LAST_RESTART_TIME:..lastState.terminated.finishedAt --sort-by="{..lastState.terminated.finishedAt}""

# Show non-running Pod list
alias kpnotready 'kubectl get pod --no-headers --field-selector=status.phase!=Running'

# Show human-readble init/containers status for each Pod
# shellcheck disable=2154
alias kpc "kubectl get pod -o go-template --template='{{range .items}}{{printf \"\033[48;5;236m:: \033[38;5;4m%-48s \033[38;5;242m%s as %s\033[K\033[0m\n\" .metadata.name .status.phase .status.qosClass}}{{if .status.initContainerStatuses }}{{range .status.initContainerStatuses}}{{printf \"\033[38;5;243m\t|->\033[0m \033[38;5;3m%-31s\\033[0m (init)\" .name}} {{range \$key, \$state := .state}} {{\"\033[38;5;243m\"}}{{if ne \$state.reason \"Completed\"}}{{\"\033[38;5;1m\"}}{{end}}{{\$key}}{{if \$state.reason}}/{{\$state.reason}}{{end}}{{if \$state.exitCode}}/{{\$state.exitCode}}{{end}}{{end}}{{if gt .restartCount 0}} {{\"\033[38;5;174m\"}}({{.restartCount}} restarts){{end}}{{\"\033[0m\n\"}}{{end}}{{end}}{{range .status.containerStatuses}}{{printf \"\033[38;5;243m\t|->\033[0m \033[38;5;2m%-38s\033[0m\" .name}} {{range \$key, \$state := .state}} {{\"\033[38;5;243m\"}}{{if ne \$key \"running\"}}{{\"\033[38;5;1m\"}}{{end}}{{\$key}}{{if \$state.reason}}/{{\$state.reason}}{{end}}{{if \$state.exitCode}}/{{\$state.exitCode}}{{end}}{{end}}{{if gt .restartCount 0}} {{\"\033[38;5;174m\"}}({{.restartCount}} restarts){{end}}{{\"\033[0m\n\"}}{{end}}{{end}}'"

# List unready Pods
function kphealth --description='List non-running and unready Pods'
	kubectl get pods -o json "$argv" \
		| jq -r '.items[] | select(.status.phase != "Running" or ([ .status.conditions[] | select(.type == "Ready" and .status == "False") ] | length ) == 1 ) | .metadata.namespace + "/" + .metadata.name'
end

# Process args and output them. Make -A the default if no namespace is provided.
function _rafi_k8s_filter_args
	argparse --ignore-unknown A n/namespace= -- $argv
	if not set -q _flag_namespace; or test -z $_flag_namespace
		if set -q _flag_A
			set _flag_namespace $_flag_A
		else
			set _flag_namespace -A
		end
	else
		set _flag_namespace -n $_flag_namespace
	end
	set -f kind pods
	if set -q argv[1]; and string match -qr '[^\-]' -- $argv[1]
		set -f kind $argv[1]
		set -f argv $argv[2..-1]
	end
	echo -- $kind $_flag_namespace $argv
end

# [k8s watch] Watch resources.
function kwatch --wraps='kubectl get'
	_rafi_k8s_filter_args "$argv" | xargs kubectl get -w | cut -c-(tput cols)
end

# [k8s get] List resources.
function kget --wraps='kubectl get'
	_rafi_k8s_filter_args $argv | xargs kubectl get | cut -c-(tput cols)
end

# [k8s describe] Describe resource.
function kdesc --wraps='kubectl get'
	_rafi_k8s_filter_args $argv | xargs kubectl describe
end

# [k8s get sort] Select resource with labels, sorted by ascending age.
function kgsort --wraps='kubectl get'
	_rafi_k8s_filter_args $argv | xargs kubectl get \
		--show-labels --sort-by .metadata.creationTimestamp --no-headers |
		fzf --tac
end

function kexec
	set -f args (_rafi_k8s_select_resource)
	if test -n $args
		# Try bash first, then sh.
		kubectl exec -it -n (string split ' ' $args) -- bash \
			|| kubectl exec -it -n (string split ' ' $args) -- sh
	end
end

# Live tail preview with fzf and follow log once selected.
# shellcheck disable=2016
function ktail
	set -f args ( \
		kubectl get pods --all-namespaces |
			fzf --info=inline --layout=reverse --header-lines=1 \
					--prompt "$(kubectl config current-context)> " \
					--header 'Press CTRL-O to open log in editor\n\n' \
					--bind ctrl-/:toggle-preview \
					--bind 'ctrl-o:execute:${EDITOR:-nvim} <(kubectl logs --namespace {1} {2}) > /dev/tty' \
					--preview-window down,follow \
					--preview 'kubectl logs -f --tail=100 --all-containers --namespace {1} {2}' $argv \
	)
	test -n $tokens; and kubectl logs -f --namespace (string split ' ' $args)
end

# Use fzf to select resource and namespace pair.
function _rafi_k8s_select_resource
	set -f kind "pods"
	if set -q argv[1]
		set -f kind $argv[1]
		set -f argv $argv[2..-1]
	end
	kubectl get $kind --all-namespaces $argv \
		| fzf --header-lines=1 --prompt "$(kubectl config current-context)> " \
		| awk '{print $1 " " $2}'
end

# Functions that push commands to the command-line.

function kpdesc --wraps='kubectl describe pod'
	commandline -- "kubectl describe pod -n $(_rafi_k8s_select_resource pod)"
end

function kpdelete --wraps='kubectl delete pod'
	commandline -- "kubectl delete pod -n $(_rafi_k8s_select_resource pod)"
end

function kplog --wraps='kubectl log'
	commandline -- "kubectl logs -f -n $(_rafi_k8s_select_resource pod)"
end

function kpman --wraps='kubectl get pod -o json'
	commandline -- "kubectl get pod -o json -n $(_rafi_k8s_select_resource pod) | fx"
end

function kpip --wraps='kubectl get pod'
	commandline -- "kubectl get pod -o jsonpath='{.status.podIPs[*]}' -n $(_rafi_k8s_select_resource pod) | jq"
end

# SECRETS
# ---

function ksdecode --description='Decode Kubernetes secret key'
	set -f args (_rafi_k8s_select_resource secret)
	if test -z $args
		return
	end

	set -f secret_key ( \
		echo $args | xargs kubectl get secrets \
			-o go-template='{{ range $k, $v := .data }}{{ printf "%s\n" $k }}{{end}}' \
			-n \
		| fzf
	)
	if test -n "$secret_key"
		echo $args | xargs kubectl get secrets \
			-o go-template="{{ index .data \"$secret_key\" | base64decode }}" \
			-n
	end
end

function kube-ca-fingerprint
	kubectl get secret $argv[1] -ojsonpath='{.data.ca\.crt}' \
		| base64 -d \
		| openssl x509 -fingerprint -in /dev/stdin -noout
end

function ksdockerconfig --wraps='kubectl get secret' --description='Decode Docker config secret'
	_rafi_k8s_select_resource secrets \
			--field-selector type=kubernetes.io/dockerconfigjson \
		| xargs kubectl get secret \
			-o go-template='{{index .data ".dockerconfigjson" | base64decode }}' \
			-n \
		| jq
end

# DEPLOYMENTS
# ---
alias krestart '_rafi_k8s_select_resource deployments | xargs kubectl rollout restart deployment -n'

# ROLES
# ---
alias kgroups "kubectl get clusterrolebindings -o go-template='{{range .items}}{{range .subjects}}{{.kind}} @ {{.name}} {{end -}} - {{.metadata.name}} {{\"\n\"}}{{end}}'"

# NODES
# ---

# Wide informative Node list
alias knode 'kubectl get node -owide'

alias ktaints "kubectl get nodes -o=custom-columns='NodeName:.metadata.name,TaintKey:.spec.taints[*].key,TaintValue:.spec.taints[*].value,TaintEffect:.spec.taints[*].effect'"

function kdebug --description='Debug Node'
	kubectl debug -it --image=ubuntu node/"$argv[1]"
end

# INGRESS
# ---

# Display in-depth Ingress objects
alias kingress='kubectl get ingress -o custom-columns="NAMESPACE:.metadata.namespace,NAME:.metadata.name,CLASS:.spec.ingressClassName,HOSTS:.spec.rules[*].host,PATHS:.spec.rules[*].http.paths[*].path"'

# Display even more robusy Ingress list
alias kingress-wide='kubectl get ingress -o custom-columns="NAMESPACE:.metadata.namespace,NAME:.metadata.name,CLASS:.spec.ingressClassName,HOSTS:.spec.rules[*].host,PATHS:.spec.rules[*].http.paths[*].path,SERVICES:.spec.rules[*].http.paths[*].backend.service.name,PORTS:.spec.rules[*].http.paths[*].backend.service.port.*"'

# EVENTS
# ---

# Order events by creation timestamp
alias kevents 'kubectl get events --sort-by=.metadata.creationTimestamp'

# Show events by specific resource name, use with -A or -n
function kobjevents --wraps='kubectl get'
	test -z $argv[1]; and echo "usage: kobjevents <object> [...]"; and return 1
	set -f obj $argv[1]
	# shift
	kubectl get event \
		--field-selector "involvedObject.name=$obj" \
		--sort-by=.metadata.creationTimestamp $argv[2..-1]
end

# METRICS
# ---

# Show cpu/memory matrix for pods, use with -A or -n <namespace>
# FIXME: Columns
function kstats
	set -f COLS "NAME:.metadata.name"
	set -f COLS "$COLS,CPU_REQ(cores):.spec.containers[*].resources.requests.cpu"
	set -f COLS "$COLS,MEMORY_REQ(bytes):.spec.containers[*].resources.requests.memory"
	set -f COLS "$COLS,CPU_LIM(cores):.spec.containers[*].resources.limits.cpu"
	set -f COLS "$COLS,MEMORY_LIM(bytes):.spec.containers[*].resources.limits.memory"

	set -f top (kubectl top pods -A)
	set -f pods "$(kubectl get pods -o custom-columns="$COLS" -A)"

	join -a1 -a2 -o 0,1.2,1.3,2.2,2.3,2.4,2.5, -e '<none>' \
		(echo "$top" | psub) (echo "$pods" | psub) | column -t -s' '
end
