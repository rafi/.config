# Rafael Bodill's macOS/Archlinux dotfiles

This is my entire "dotfiles" configuration for all the software I use on macOS
& Archlinux, mostly in the terminal.

I've turned my `~/.config` directory into a Git repository and strive to set
applications write their configuration there if they don't by default. Meaning,
I try to conform to the [XDG standard]. There is one important caveat in doing
so: Secrets can be accidentally committed. I [solve](#protecting-secrets) this
with the clean and smudge filter features of Git attributes.

## Features

The most interesting configs:

- [bash](./bash/)
- [git](./git/)
- [fish](./fish/)
- [i3](./i3/config)
- [karabiner](./karabiner/)
- [kitty](./kitty/)
- [launch](./launch/)
- [lf](./lf/)
- [lsd](./lsd/)
- [tmux](./tmux/)
- [xorg](./xorg/)
- [skhd](./skhd/skhdrc)
- [starship](./starship/)
- [yabai](./yabai/yabairc)
- [yazi](./yazi/)
- [zsh](./zsh/)

... And make sure to check out [github.com/rafi/vim-config]

## Install

:::danger
**DO NOT** install! These are my customized settings that are tailored to my
set-up. If you blindly install it, you won't have a good time.
:::

See [`justfile`](./justfile) for the available commands.

## macOS-specific Software

on macOS, make sure you check these out:

- [launchctl](./launch/)
- [Karabiner](./karabiner/)

macOS defaults:

- [macos-defaults.com](https://macos-defaults.com/)
- [github.com/yannbertrand/macos-defaults](https://github.com/yannbertrand/macos-defaults)

## XDG Conformity

Configuration directories are organized neatly by defining
specific environment variables in [bash/exports] and aliases in [bash/aliases].

Some programs require special aliases to feed the proper config, see "XDG
conformity" in [bash/aliases].

## Software Configuration Included

### Fish

Recommended plugins:

```txt
jorgebucaran/fisher
jorgebucaran/autopair.fish
franciscolourenco/done
patrickf1/fzf.fish
```

## Protecting Secrets

Using `.gitattributes` filters clean and smudge. Setup custom filters:

```sh
cd ~/.config
git config --local filter.vault.clean 'sed -f ~/.config/clean.sed'
git config --local filter.vault.smudge 'sed -f ~/.config/smudge.sed'
```

The sed script `clean.sed` is [included](./clean.sed).
However, you have to create the `smudge.sed` script yourself, for example:

```sh
cat > ~/.config/smudge.sed
s/{{ \(DIANA\|ARIA2\)_TOKEN }}/secret/
s/{{ LASTFM_TOKEN }}/token/
s/{{ LASTFM_PASS }}/password/
s/{{ GIT_NAME }}/Joe Shmoe/
s/{{ GIT_EMAIL }}/name@gmail.com ; personal/
s/{{ GIT_WORK_EMAIL }}/name@gmail.com ; work/
s/{{ JIRA_URL }}/url/
s/{{ JIRA_USER }}/username/
s/{{ JIRA_PASS }}/password/
s/{{ FORECASTIO_TOKEN }}/token/
s/{{ GITHUB_TOKEN }}/token/
s/{{ HOMEBREW_GITHUB_API_TOKEN }}/token/
s/{{ GITLAB_TOKEN }}/token/
s/{{ OPENAI_API_KEY }}/token/
s/{{ DICTIONARY_API_KEY }}/key/
s/{{ TMUX_SPOTIFY_API_KEY }}/token/
```

Now whenever you stage files, the `clean.sed` will prevent secrets being
committed. And on checkout, the `smudge.sed` will inject your secrets into
their proper placeholders. _Note_ that `smudge.sed` is ignored from being
committed mistakenly.

Copy `.env.example` to `~/.config/.env` and fill in your secrets:

```sh
HOMEBREW_GITHUB_API_TOKEN=
GITLAB_TOKEN=
OPENAI_API_KEY=
DICTIONARY_API_KEY=

# And so on…
```

For maximum portability, refrain from using quotes or 'export' commands.

[bash/aliases]: ./bash/aliases
[bash/exports]: ./bash/exports
[github.com/rafi/vim-config]: https://github.com/rafi/vim-config
[XDG standard]: https://wiki.archlinux.org/index.php/XDG_Base_Directory
