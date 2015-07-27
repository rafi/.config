OSX User Services
===

Install Service
---
Setup via symlinks, and load with `launchctl`:
```sh
cd ~/Library/LaunchAgents
ln -sfv ~/.config/launch/org.musicpd.mpd.plist
launchctl load -w org.musicpd.mpd.plist
```

Uninstall Service
---
```sh
launchctl unload -w ~/Library/LaunchAgents/org.musicpd.mpd.plist
```

Available Services
---
- `environment.plist` - XDG system-wide environment variables
- `net.syncthing.syncthing.plist` - [Syncthing]
- `org.macports.gpg-agent.plist` - GPG agent (Installed via Macports)
- `org.musicpd.mpd.plist` - [MPD] (Music Player Daemon)
- `org.notandy.ympd.plist` - [ympd]
- `org.musicpd.mpdscribble.plist` - [mpdscribble]

[Syncthing]: https://syncthing.net/
[MPD]: http://www.musicpd.org/
[mpdscribble]: http://mpd.wikia.com/wiki/Client:Mpdscribble
[ympd]: https://github.com/notandy/ympd
