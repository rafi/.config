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

- [alacritty](./alacritty/)
- [bash](./bash/)
- [git](./git/)
- [i3](./i3/config)
- [karabiner](./karabiner/)
- [launch](./launch/)
- [lf](./lf/)
- [tmux](./tmux/)
- [xorg](./xorg/)
- [skhd](./skhd/skhdrc)
- [yabai](./yabai/yabairc)

... and make sure to check-out [github.com/rafi/vim-config]!

## Install

There is **no** installation script, only three symlinks:

```sh
# Clone the .config repo
cd ~
git clone --recursive git@github.com:rafi/.config.git

# Symlink few files manually:
cd ~
ln -s .config/bash/bashrc .bashrc
ln -s .config/bash/profile .profile
ln -s .config/tmux/config .tmux.conf

# Create cache directories
mkdir -p ~/.cache/{nvim,pacaur,proselint,xpanes,zoxide}
mkdir -p ~/.cache/{aria2,beets,mpd,mpdscribble,mutt,neomutt,rtorrent,subtitles}
mkdir -p ~/.cache/ncmpcpp/lyrics
mkdir -p ~/.cache/node/{npm,gyp}

# Create user local shared directories
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/{cargo,composer,fonts,go,krew,lf,mailbox,mutt,neomutt}
mkdir -p ~/.local/share/{newsbeuter,newsboat,nextword,tig,vagrant,virtualbox}
mkdir -p ~/.local/share/python/{envs,pyenv}
```

## macOS-specific Software

on macOS, make sure you check these out:

- [launchctl](./launch/)
- [Karabiner](./karabiner/)

## XDG Conformity

Configuration directories are organized neatly by defining
specific environment variables in [bash/exports](./bash/exports) and
aliases in [bash/aliases](./bash/aliases).

Some programs require special help to feed the proper config:

```sh
alias cpan='cpan -j "$XDG_CONFIG_HOME"/cpan/config.pm'
alias gcal='gcalcli --configFolder "$XDG_CONFIG_HOME"/gcalcli'
alias mbsync='mbsync -c "$XDG_CONFIG_HOME"/isync/mbsyncrc'
alias mysql='mysql --defaults-extra-file="$XDG_CONFIG_HOME"/mysql/config'
alias mutt='ESCDELAY=0 neomutt || mutt -F "$XDG_CONFIG_HOME"/mutt/config'
alias ncmpc='ncmpc -f "$XDG_CONFIG_HOME"/ncmpc/config -k "$XDG_CONFIG_HOME"/ncmpc/keys'
alias ncmpcpp='ncmpcpp -c "$XDG_CONFIG_HOME"/ncmpcpp/config'
alias redshift='redshift -c "$XDG_CONFIG_HOME"/redshift/config'
alias rtorrent='rtorrent -n -o import="$XDG_CONFIG_HOME"/rtorrent/config.rc'
alias vercel='vercel --global-config="$XDG_CONFIG_HOME"/vercel'
alias weechat='weechat --dir "$XDG_CONFIG_HOME"/weechat/'
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
s/{{ LASTFM_USER }}/username/
s/{{ LASTFM_TOKEN }}/token/
s/{{ LASTFM_PASS }}/token/
s/{{ SPOTIFY_USER }}/username/
s/{{ SPOTIFY_PASS }}/password/
s/{{ ECHONEST_TOKEN }}/token/
s/{{ JIRA_URL }}/url/
s/{{ JIRA_USER }}/username/
s/{{ JIRA_PASS }}/password/
s/{{ GIT_EMAIL }}/name@gmail.com/
s/{{ GIT_NAME }}/Joe Shmoe/
s/{{ GIT_USER }}/joe/
s/{{ WEATHER_TOKEN }}/token/
s/{{ FORECASTIO_TOKEN }}/token/
s/{{ GITHUB_TOKEN }}/token/
s/{{ HOMEBREW_GITHUB_API_TOKEN }}/token/
s/{{ TMUX_SPOTIFY_API_KEY }}/token/
```

Now whenever you stage files, the `clean.sed` will prevent secrets being
committed. And on checkout, the `smudge.sed` will inject your secrets into
their proper placeholders. _Note_ that `smudge.sed` is ignored from being
committed mistakenly.

[XDG standard]: https://wiki.archlinux.org/index.php/XDG_Base_Directory
[github.com/rafi/vim-config]: https://github.com/rafi/vim-config
