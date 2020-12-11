#!/usr/bin/env bash

# Prepare cache directories
mkdir -p ~/.cache/vim/{backup,session,swap,tags,undo}
mkdir -p ~/.cache/{aria2,beets,mpd,mpdscribble,mutt,pacaur,rtorrent,subtitles,z}
mkdir -p ~/.cache/ncmpcpp/lyrics

# Prepare user local shared directories
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/{cargo,composer,fonts,lf,vagrant,tig,mutt,newsbeuter,virtualbox}
mkdir -p ~/.local/share/python/envs
