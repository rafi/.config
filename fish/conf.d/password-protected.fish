
function brew --wraps=brew
	HOMEBREW_GITHUB_API_TOKEN="$(pass tokens/github)" command brew $argv
end

function just --wraps=just
	HOMEBREW_GITHUB_API_TOKEN="$(pass tokens/github)" command just $argv
end

function make --wraps=make
	HOMEBREW_GITHUB_API_TOKEN="$(pass tokens/github)" command make $argv
end

function docker --wraps=docker
	export $(pass show tokens/all | xargs -L 1)
	command docker $argv
end

function podman --wraps=docker
	export $(pass show tokens/all | xargs -L 1)
	command podman $argv
end

function gits --wraps=gits
	if command -v gits >/dev/null
		export $(pass show tokens/all | xargs -L 1)
		command gits $argv
	end
end

function git-pass --wraps=git
	export $(pass show tokens/all | xargs -L 1)
	command git $argv
end

function flux --wraps=flux
	export $(pass show tokens/all | xargs -L 1)
	command flux $argv
end

function release-please --wraps=release-please
	export $(pass show tokens/all | xargs -L 1)
	command release-please $argv
end
