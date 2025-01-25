# Fish aliases and abbreviations
# github.com/rafi/.config

if not status is-interactive
	exit
end

# Useful general shortcuts
abbr c ' clear'
abbr clear ' clear'
abbr cal 'task cal; or ncal -wC3; or command cal -B1 -A1'

alias update 'brew update && brew outdated'
alias upgrade 'ya pack -u && brew upgrade'
alias outdated 'brew outdated'
alias work 'cd ~/code/work'
alias wiki 'cd ~/code/rafi/*/content/wiki'
# alias start '{ test -f .jig* && jig start .; } ||
# 	{ jig ls | fzf | xargs jig start; }'

abbr -a --position anywhere --function last_history_item -- !!
abbr -a --position anywhere --set-cursor -- -h "-h 2>&1 | bat -pl=help"

if [ $OS_DARWIN ]
	command -q gdircolors; and abbr dircolors gdircolors
	command -q gfind; and abbr find gfind
	command -q gsort; and abbr sort gsort
	command -q gstat; and abbr stat gstat
end

# Lists ---------------------------------------------------- l for list -- {{{

set -l lscmd ls
if command -q eza
	set lscmd "EZA_MIN_LUMINANCE=75 eza --color-scale=all --color-scale-mode=gradient"
	alias lt "$lscmd --icons=always --color=always --header --git --long --all --group-directories-first"
else if command -q lsd
	set lscmd lsd
	alias lt "$lscmd --icon=always --color=always --header --git --long --all --group-directories-first"
else if command -q gls
	set lscmd gls
end
alias ls "$lscmd --color=always --group-directories-first"
alias l  "$lscmd --all --classify --color=always --group-directories-first"
alias ll "$lscmd --all --long --classify --color=always --group-directories-first"
set -u lscmd

abbr lf yazi

# }}}
# Editor ---------------------------------------------------- v for vim -- {{{

# Neo/vim shortcuts, use Neovim by default
if command -q nvim
	abbr v 'nvim (fzf)'
	abbr vi nvim
	abbr vim nvim
	abbr nvi nvim
	abbr suvim sudo -E nvim
	abbr vimpager 'nvim - -c "lua Snacks.terminal.colorize()"'
else
	abbr v 'vim (fzf)'
	abbr vi vim
	abbr suvim sudo -E vim
end
alias ve 'tmux split-window -h "$EDITOR"'
# alias vimdiff='vim -d'

# }}}
# Grepping / Parsing ----------------------------------------------------- {{{

alias grep 'grep --color=auto --exclude-dir=.git'
abbr rga 'rg -uu'

# Use colordiff by default
command -q colordiff; and abbr diff colordiff

# Productive defaults for grep and tree
alias tree 'tree -F --dirsfirst -a -I ".git|.hg|.svn|__pycache__|.mypy_cache|.pytest_cache|*.egg-info|.sass-cache|.DS_Store"'
abbr tree2 'tree -L 2'
abbr tree3 'tree -L 3'

# }}}
# Path ------------------------------------------------------------------- {{{

# Jump to MRU directories
abbr -a cdprev prevd
abbr -a cdnext nextd

# Paste current directory to clipboard
alias cwd 'pwd | tr -d "\r\n" | fish_clipboard_copy'

# Jump to previous directory with --
abbr - 'cd -'

# Easier directory navigation
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr .... 'cd ../../..'
abbr ..... 'cd ../../../..'

# }}}
# Find ----------------------------------------------------- f for find -- {{{
if command -q fd
	# Use https://github.com/sharkdp/fd
	abbr f fd
	abbr fda 'fd -HI'
else
	# Slower
	abbr f 'find . -not -name .git -not -name node_modules'
end

# }}}
# systemctl ------------------------------------------ sc for systemctl -- {{{
if [ $OS_LINUX ]
	abbr sc systemctl
	abbr scu "systemctl --user"
	abbr scs "command systemctl status"
	abbr scl "systemctl --type service --state running"
	abbr sclu "systemctl --user --type service --state running"
	abbr sce "sudo systemctl enable --now"
	abbr scd "sudo systemctl disable --now"
	abbr scr "sudo systemctl restart"
	abbr sco "sudo systemctl stop"
	abbr sca "sudo systemctl start"
	abbr scf "systemctl --failed --all"
end

# }}}
# journalctl ---------------------------------------- j+ for journalctl -- {{{
if [ $OS_LINUX ]
	abbr jb "journalctl -b"
	abbr jf "journalctl --follow"
	abbr jg "journalctl -b --grep"
	abbr ju "journalctl --unit"
end

# }}}
# Git ------------------------------------------------------- g for git -- {{{
# See more in ./functions/git.fish
abbr g   git
abbr ga  git add
abbr gb  git branch
abbr gc  git checkout
abbr gcb git checkout -b
abbr gcd cd "(git rev-parse --show-toplevel)"
abbr gd  git diff
abbr gds git diff --cached
abbr gdt git difftool
abbr gfl 'git fetch --prune && git lg -15'
abbr gf  git fetch --prune
abbr gfa git fetch --all --tags --prune
abbr gap git add -p
abbr gai git add -i
abbr gs  git status -sb
abbr gl  git lg -15
abbr gll git lg
abbr gld git lgd -15

# Promoted git aliases
abbr ck git checkout

# }}}
# Docker ------------------------------------------------- d for docker -- {{{
abbr d docker
abbr dk docker compose
abbr drarm 'docker run --rm -it --platform linux/arm64'
abbr dramd 'docker run --rm -it --platform linux/amd64'
alias dps 'docker ps --format "table {{.Names}}\\t{{.Image}}\\t{{.Status}}\\t{{ .Ports }}\\t{{.RunningFor}}\\t{{.Command}}\\t{{ .ID }}" | cut -c-$(tput cols)'
alias dls 'docker ps -a --format "table {{.Names}}\\t{{.Image}}\\t{{.Status}}\\t{{ .Ports }}\\t{{.RunningFor}}\\t{{.Command}}\\t{{ .ID }}" | cut -c-$(tput cols)'
# alias dim 'docker images --format "table {{.Repository}}\\t{{.Tag}}\\t{{.ID}}\\t{{.Size}}\\t{{.CreatedSince}}" | cut -c-$(tput cols)'
alias dim 'docker images --format "table {{.Repository}}:{{.Tag}}\\t{{.ID}}\\t{{.Size}}\\t{{.CreatedSince}}" | sed -re "s/^(.+):([^ ]*)\ (.+)\$/\1:$(tput setaf 2)\2$(tput sgr0)\3/g"'
alias dih 'docker history --no-trunc --format "{{ .CreatedBy }}"'
alias dip 'docker inspect --format "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}"'
alias dgc 'docker image prune -f'
alias dvc 'docker volume ls -qf dangling=true | xargs docker volume rm'
alias dtop 'docker stats $(docker ps --format="{{.Names}}")'
alias dnet 'docker network ls && echo && docker inspect --format "{{\$e := . }}{{with .NetworkSettings}} {{\$e.Name}}
{{range \$index, \$net := .Networks}}  - {{\$index}}	{{.IPAddress}}
{{end}}{{end}}" $(docker ps -q)'
alias dtag 'docker inspect --format "{{.Name}}
{{range \$index, \$label := .Config.Labels}}  - {{\$index}}={{\$label}}
{{end}}" $(docker ps -q)'

# }}}
# Kubernetes ----------------------------------------- k for kubernetes -- {{{
# See more in conf.d/kubernetes.fish
abbr k kubectl
abbr kc  kubectx
abbr ki  kubectl config-import
abbr kd  kubectl describe
abbr kg  kubectl get
abbr kgy kubectl get -o yaml
abbr ke  kubectl edit
abbr kdp kubectl describe pod
abbr kgp kubectl get pod
abbr kgpy kubectl get pod -o yaml
abbr krr kubectl rollout restart deploy

# }}}
# Virtualization / Emulation --------------------------------------------- {{{
# See: https://github.com/lima-vm/lima
abbr li  lima
abbr lic limactl

# }}}
# Processes -------------------------------------------------------------- {{{
abbr process ps -ax
abbr pst pstree -g 3 -ws

# }}}
# Task ----------------------------------------------------- j for just -- {{{
# See: https://github.com/casey/just
abbr j just
abbr jc just --choose

# }}}
# XDG conformity --------------------------------------------------------- {{{
# See: https://wiki.archlinux.org/index.php/XDG_Base_Directory
alias mysql 'mysql --defaults-extra-file="$XDG_CONFIG_HOME/mysql/config"'
alias gcal 'gcalcli --configFolder "$XDG_CONFIG_HOME/gcalcli"'
alias vercel 'vercel --global-config="$XDG_CONFIG_HOME/vercel"'

# }}}
# Storage ---------------------------------------------------------------- {{{
abbr dut 'du -hsx * | sort -rh | head -10'
abbr duz "du -hsx * | sort -rh | fzf"
abbr dum df -hT -x devtmpfs -x tmpfs
abbr ungzip 'gzip -d'
abbr untar 'tar xvf'

# }}}
# Misc ------------------------------------------------------------------- {{{

abbr ,fontcache 'fc-cache -f -v'
abbr ,fontfind 'fc-list : family style'
abbr ,sniff "sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
abbr ,spell 'aspell -c -l en_US'
abbr ,urlencode 'python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
abbr ,weather "curl -s wttr.in/Kfar-saba | grep -v Follow"
abbr ,statuspages "curl https://status.plaintext.sh/t"
abbr ,ttycast "ttyd -p 8888 bash -c 'tmux new-session -d -s cast \; split-window -d \; attach -t cast'"
abbr ,ttycast-this "tmux split-window \'ttyd -p 8888 bash -c \'tmux a\'\'"
abbr ,lspci "lspci -nn | fzf -0 | awk '{print \$1}' | xargs lspci -v -s"
abbr ,m --set-cursor 'math "%"'

if command -q pcalc
	abbr ,calc pcalc
else
	abbr ,calc 'bc -l'
end

# }}}
# OS Specific Network and Filesystem ------------------------------------- {{{

# IP addresses
alias ips "ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
alias iplocal "ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias ipremote "\dig +short myip.opendns.com @resolver1.opendns.com || \curl https://checkip.amazonaws.com"

if [ $OS_DARWIN ]
	alias netinfo 'networksetup -getinfo "$(networksetup -listallnetworkservices | sed 1d | fzf)"'

	# Show active network interfaces
	alias ifactive "ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

	alias hwmodel 'sysctl -n hw.model'
	alias osversion 'sw_vers -productVersion'
	alias afk 'open -a ScreenSaverEngine'
	alias cleanup "find . -type f -name '*.DS_Store' -ls -delete"

	# Flush Directory Service cache
	alias flush='dscacheutil -flushcache && killall -HUP mDNSResponder'

	# Empty the Trash on all mounted volumes and the main HDD.
	# Also, clear Apple’s System Logs to improve shell startup speed.
	# Finally, clear download history from quarantine. https://mths.be/bum
	alias emptytrash "sudo rm -rfv /Volumes/*/.Trashes; \
		sudo rm -rfv ~/.Trash; \
		sudo rm -rfv /private/var/log/asl/*.asl; \
		sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"
else
	alias netinfo "ip -br -c addr show | fzf --ansi | awk '{print \$1}' | xargs ip -c -h -d -s addr show"

	# Show active network interfaces NEEDS TESTING
	alias ifactive "ip -c link show | grep UP"

	alias hwmodel "sudo dmidecode -s system-product-name"
	alias osversion "cat /etc/os-release | grep PRETTY_NAME | cut -d'=' -f2 | tr -d '\"'"

	# Flush Directory Service cache NEEDS TESTING
	alias flush 'sudo systemd-resolve --flush-caches'

	test command -q i3lock; and alias afk 'i3lock -c 000000'
	or test command -q xscreensaver-command; and alias afk 'xscreensaver-command -lock'
	or test command -q xdg-screensaver; and alias afk 'xdg-screensaver lock'
	or test command -q gnome-screensaver-command; and alias afk 'gnome-screensaver-command --lock'

	if ! test command -q pbcopy
		alias pbcopy fish_clipboard_copy
		alias pbpaste fish_clipboard_paste
	end

	# TODO

end

# }}}

# vim: set fdm=marker ts=2 sw=2 tw=80 noet :
