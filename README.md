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
mkdir -p ~/.cache/{aria2,beets,mpd,mpdscribble,npm,pacaur,rtorrent,z}
mkdir -p ~/.cache/ncmpcpp/lyrics

# Prepare user local
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/{composer,vagrant,virtualbox}
mkdir -p ~/.local/lib/{nodejs,python2.7,ruby}
mkdir -p ~/.local/lib/python2.7/virtualenvs
```

XDG Conformity
---
Configuration directories are organized neatly by defining
specific environment variables in [bash/exports](./bash/exports) and
aliases in [bash/aliases](./bash/aliases).

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
```
Now whenever you stage files, the `clean.sed` will prevent secrets being
committed. And on checkout, the `smudge.sed` will inject your secrets into
their proper placeholders. _Note_ that `smudge.sed` is ignored from being
committed mistakenly.
