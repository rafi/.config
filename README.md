# Rafael Bodill's macOS/Archlinux dotfiles

This is my entire "dotfiles" configuration for all the software I use on macOS
& Archlinux, mostly in the terminal.

I've turned my `~/.config` directory into a Git repository and strive to set
applications write their configuration there if they don't by default. Meaning,
I try to conform to the [XDG standard]. There is one important caveat in doing
so: Secrets can be accidentally committed. I [solve](#protecting-secrets) this
with the clean and smudge filter features of Git attributes.

## Install

There is **no** installation script, but you should create several symlinks:

```sh
# Clone the .config repo
cd ~
git clone --recursive git://github.com/rafi/.config.git

# Symlink few files manually:
cd ~
ln -s .config/ag/ignore .agignore
ln -s .config/bash/bashrc .bashrc
ln -s .config/bash/profile .profile
ln -s .config/ctags/config .ctags
ln -s .config/tmux/config .tmux.conf

# Create cache directories
mkdir -p ~/.cache/vim/{backup,complete,session,swap,tags,undo}
mkdir -p ~/.cache/{aria2,beets,mpd,mpdscribble,mutt,pacaur,rtorrent,subtitles,z}
mkdir -p ~/.cache/ncmpcpp/lyrics
mkdir -p ~/.cache/node/{npm,gyp}

# Create user local shared directories
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/{cargo,composer,fonts,vagrant,tig,mutt,newsbeuter,virtualbox}
mkdir -p ~/.local/share/python/envs
```

## OSX-specific Software

* [launchctl](./launch/)
* [Karabiner](./karabiner/)

## XDG Conformity

Configuration directories are organized neatly by defining
specific environment variables in [bash/exports](./bash/exports) and
aliases in [bash/aliases](./bash/aliases).

There are some programs you'll need to create custom scripts to load the
proper config files: bug-warrior, mpdscribble, mutt, mysql, ncmpc,
ncmpcpp, rtorrent. See examples at [github.com/rafi/.local].

## Protecting Secrets

Using `.gitattributes` filters clean and smudge. Setup custom filters:

```sh
cd ~/.config
git config --local filter.vault.clean "sed -f ~/.config/clean.sed"
git config --local filter.vault.smudge "sed -f ~/.config/smudge.sed"
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
s/{{ GIT_\(PERSONAL\|WORK\)_NAME }}/Joe Shmoe/
s/{{ GIT_PERSONAL_EMAIL }}/name@gmail.com/
s/{{ GIT_WORK_EMAIL }}/name@work.com/
s/{{ GIT_\(PERSONAL\|WORK\)_USER }}/joe/
s/{{ WEATHER_TOKEN }}/token/
s/{{ GITHUB_TOKEN }}/token/
s/{{ HOMEBREW_GITHUB_API_TOKEN }}/token/
s/{{ TMUX_SPOTIFY_API_KEY }}/token/
```

Now whenever you stage files, the `clean.sed` will prevent secrets being
committed. And on checkout, the `smudge.sed` will inject your secrets into
their proper placeholders. _Note_ that `smudge.sed` is ignored from being
committed mistakenly.

[XDG standard]: https://wiki.archlinux.org/index.php/XDG_Base_Directory
[github.com/rafi/.local]: https://github.com/rafi/.local/tree/master/bin
