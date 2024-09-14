# Vim functions
# https://github.com/rafi/.config

function v() {
	# shellcheck disable=SC2016
	f="$(fd |
		fzf --multi --header 'Press CTRL-Space to toggle preview mode' \
		--preview="bat --theme=Coldark-Dark --color=always {}" \
		--preview-label="cat" \
		--bind='ctrl-space:transform:[[ $FZF_PREVIEW_LABEL =~ cat ]] \
				&& echo "change-preview(git log -p --stat --color=always \{})+change-preview-label( log )" \
				|| echo "change-preview(bat --theme=Coldark-Dark --color=always \{})+change-preview-label( cat )"'
					)"

	if test -z "$f"; then
		return 1
	fi
	nvim "$f"
}

# Interactively select Vim session with fzf
function vs() {
	local SESSIONS="$XDG_STATE_HOME/nvim/sessions"
	local list
	if test ! -d "$SESSIONS"; then
		echo "No sessions found."
		return 1
	fi
	if hash fd 2> /dev/null; then
		list="$(fd --strip-cwd-prefix -I --type f --base-directory "$SESSIONS" --exec-batch ls -1t)"
	else
		list="$(find "$SESSIONS" -type f -printf '%Ts %f\n' | sort -nr | cut -d' ' -f2-)"
	fi
	echo "$list" |
		sed "s/\.vim$//g;s/%/\//g;s%$HOME%~%g" |
		fzf --no-multi --prompt='Session  ' |
		sed "s%~%$HOME%g;s/\//%/g" |
		xargs -I'{}' "$EDITOR" -c "e $SESSIONS/{}.vim | source %"
}

# Select a profile to launch Neovim with.
# Credits: https://github.com/folke/dot/blob/master/config/fish/conf.d/nvim.fish
function nvims() {
	local profile="$1"

	# Check if the provided profile exists
	if test -n "$profile" -a -d ~/.config/nvim-profiles/"$profile"; then
		shift
	else
		# Use fzf to allow the user to select a profile
		profile="$(command ls ~/.config/nvim-profiles/ | fzf --prompt=" Neovim Profile: " --height=~50% --layout=reverse --exit-0)"
		if test -z "$profile"; then
			return 1
		fi
	fi

	local appname="nvim-profiles/$profile"
	if ! test -d ~/.config/"$appname"; then
		echo "Profile $profile does not exist."
		echo "Use nvims_install to install a new profile."
		return 1
	fi

	export NVIM_APPNAME="$appname"
	nvim "$@"
	unset NVIM_APPNAME
}

# Switch to the Neovim config in this directory
# Credits: https://github.com/folke/dot/blob/master/config/fish/conf.d/nvim.fish
function tmpvim() {
	[ -L ~/.config/nvim-profiles/tmp ] && rm ~/.config/nvim-profiles/tmp
	ln -s "$(realpath .)" ~/.config/nvim-profiles/tmp
	nvims tmp "$@"
}

# Function to install a new Neovim profile from a given Git URL
# Credits: https://github.com/folke/dot/blob/master/config/fish/conf.d/nvim.fish
function nvims_install() {
	local url="$1"
	local profile="$2"
	if test -z "$profile" -o -z "$url"; then
		echo "Usage: nvim_profile_install <url> <profile>"
		return 1
	fi

	local dest="$HOME/.config/nvim-profiles/$profile"
	if test -d "$dest"; then
		echo "Profile $profile already exists"
		return 1
	fi

	git clone "$url".git "$dest"
	nvims "$profile"
}

# vim: set ts=2 sw=2 tw=80 noet :
