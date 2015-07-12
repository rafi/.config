Rafi's Workstations Config
---
Workstation software configuration, tested on Archlinux and OSX (using Macports).

Install
---
```sh
# Clone
git clone --recursive git://github.com/rafi/.config.git ~/.config
cd ~/.config

# Symlink 4 files manually:
cd ~
ln -s .config/bash/bashrc .bashrc
ln -s .config/bash/profile .profile
ln -s .config/ctags/config .ctags
ln -s .config/xorg/xinitrc .xinitrc      # Just for Linux
ln -s .config/xorg/xinitrc_osx .xinitrc  # Just for OSX

# Prepare cache directories
mkdir -p ~/.cache/vim/{backup,bookmarks,swap,plugins,tags,undo}
mkdir -p ~/.cache/{aria2,beets,mpd,mpdscribble,npm,pacaur,rtorrent,mux,z}
mkdir -p ~/.cache/ncmpcpp/lyrics

# Prepare user local
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/{composer,vagrant,virtualbox}
mkdir -p ~/.local/lib/{nodejs,python2.7,ruby}
mkdir -p ~/.local/lib/python2.7/virtualenvs
```

## OSX-specific Software
- [launchctl](./launch/)
- [Karabiner](./karabiner/)

XDG Conformity
---
Configuration directories are organized neatly by defining
specific environment variables in [bash/exports](./bash/exports) and
aliases in [bash/aliases](./bash/aliases).
There are some programs you'll need to create custom scripts to load the
proper config files: bug-warrior, mpdscribble, mutt, mysql, ncmpc,
ncmpcpp, rtorrent, tmux. See examples at [rafi/.local/bin].

Protecting Secrets
---
Using `.gitattributes` filters clean and smudge. Setup custom filter:
```sh
cd ~/.config
git config --local filter.vault.clean "sed -f ~/.config/clean.sed"
git config --local filter.vault.smudge "sed -f ~/.config/smudge.sed"
```
The sed script `clean.sed` is [included](./clean.sed).
You have to create `smudge.sed` yourself:
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
```
Now whenever you stage files, the `clean.sed` will prevent secrets being
committed. And on checkout, the `smudge.sed` will inject your secrets into
their proper placeholders. _Note_ that `smudge.sed` is ignored from being
committed mistakenly.

[rafi/.local/bin]: https://github.com/rafi/.local/tree/master/bin
