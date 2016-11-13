#!/usr/bin/env bash

# Prepare cache directories
mkdir -p ~/.cache/vim/{backup,bookmarks,swap,plugins,tags,undo}
mkdir -p ~/.cache/{aria2,beets,mpd,mpdscribble,mutt,pacaur,rtorrent,subtitles,mux,z}
mkdir -p ~/.cache/ncmpcpp/lyrics
mkdir -p ~/.cache/node/{npm,gyp}

# Prepare user local shared directories
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/{composer,fonts,vagrant,mutt,newsbeuter,virtualbox}
mkdir -p ~/.local/lib/{node,python2.7,ruby}
mkdir -p ~/.local/lib/python2.7/virtualenvs
