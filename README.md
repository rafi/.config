Rafi's Workstations Config
---
Workstation software configuration, tested on Archlinux and OSX (using Macports).

Setup
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
# Just for Linux:
ln -s .config/xorg/xinitrc .xinitrc
# Just for OSX:
ln -s .config/xorg/xinitrc_osx .xinitrc

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
