#!/bin/sh

export PATH="$PATH:$HOME/.nix-profile/bin" # required for Nix
export PATH="$PATH:/usr/local/bin" # required on MacOS/brew
export PATH="$PATH:/usr/local/MacGPG2/bin" # required on MacOS/GPGTools GPGSuite
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export GPG_TTY="$(tty)"

# Uncomment to debug gopass-jsonapi
# export GOPASS_DEBUG_LOG=/tmp/gopass-jsonapi.log

if [ -f ~/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
	source ~/.gpg-agent-info
	export GPG_AGENT_INFO
else
	eval $(gpg-agent --daemon)
fi

export PATH="$PATH:/opt/homebrew/bin:/usr/local/bin"

/opt/homebrew/bin/gopass-jsonapi listen

exit $?
