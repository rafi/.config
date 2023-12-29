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
- [i3](./i3/config)
- [karabiner](./karabiner/)
- [kitty](./kitty/)
- [launch](./launch/)
- [lf](./lf/)
- [tmux](./tmux/)
- [xorg](./xorg/)
- [skhd](./skhd/skhdrc)
- [yabai](./yabai/yabairc)

... And make sure to check out [github.com/rafi/vim-config]

## Install

----

**DO NOT** install! These are my customized settings that are tailored to my
set-up. If you blindly install it, you won't have a good time.

----

There is **no** installation script, only two symlinks:

```sh
# Clone the .config repo
cd ~
git clone --recursive git@github.com:rafi/.config.git

# Symlink few files manually:
cd ~
ln -s .config/bash/bashrc .bashrc
ln -s .config/bash/profile .profile

# Create cache directories
mkdir -p ~/.cache/{nvim,pacaur,proselint,xpanes,zoxide}
mkdir -p ~/.cache/{aria2,beets,mpd,mpdscribble,mutt,neomutt,rtorrent,subtitles}
mkdir -p ~/.cache/ncmpcpp/lyrics
mkdir -p ~/.cache/node/{npm,gyp}

# Create user local shared directories
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/{cargo,composer,fonts,go,krew,lf,mailbox,mutt,neomutt}
mkdir -p ~/.local/share/{newsbeuter,newsboat,nextword,tig,vagrant}
mkdir -p ~/.local/share/python/{poetry,pyenv}
```

## macOS-specific Software

on macOS, make sure you check these out:

- [launchctl](./launch/)
- [Karabiner](./karabiner/)

https://macos-defaults.com/ --- https://github.com/yannbertrand/macos-defaults

## XDG Conformity

Configuration directories are organized neatly by defining
specific environment variables in [bash/exports] and aliases in [bash/aliases].

Some programs require special aliases to feed the proper config, see "XDG
conformity" in [bash/aliases].

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

Create a `~/.config/.secrets.env` file with the following format:

```sh
export GITHUB_TOKEN="{{ GITHUB_TOKEN }}"
export HOMEBREW_GITHUB_API_TOKEN="{{ HOMEBREW_GITHUB_API_TOKEN }}"
export OPENAI_API_KEY="{{ OPENAI_API_KEY }}"
export DICTIONARY_API_KEY="{{ DICTIONARY_API_KEY }}"
export GITLAB_TOKEN="{{ GITLAB_TOKEN }}"

# And so on…
```

[bash/aliases]: ./bash/aliases
[bash/exports]: ./bash/exports
[github.com/rafi/vim-config]: https://github.com/rafi/vim-config
[XDG standard]: https://wiki.archlinux.org/index.php/XDG_Base_Directory
