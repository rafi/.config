# Vim functions
# https://github.com/rafi/.config

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

# Interactively select Vim session with fzf
function vs() {
	SESSIONS="$XDG_STATE_HOME/nvim/sessions"
	gfind "$SESSIONS" -type f -printf '%Cs %f\n' \
		| sed "s/\.vim$//g;s/%/\//g;s%$HOME%~%g" \
		| sort -r \
		| awk "{print \$2}" \
		| fzf --no-multi --no-sort \
			--prompt='(Choose session): ' --header=$'────────────\n' \
		| sed "s%~%$HOME%g;s/\//%/g" \
		| xargs -I'{}' "$EDITOR" -S "$SESSIONS/{}.vim"
}

# vim: set ts=2 sw=2 tw=80 noet :
