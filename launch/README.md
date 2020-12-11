# OSX User Services

## Install Service

Setup via symlinks, and load with `launchctl`:

```sh
cd ~/Library/LaunchAgents
ln -sfv ~/.config/launch/io.rafi.environment.plist
launchctl load -w io.rafi.environment.plist
```

## Uninstall Service

```sh
launchctl unload -w ~/Library/LaunchAgents/io.rafi.environment.plist
```

## Available Services

- `io.rafi.environment.plist` - My XDG system-wide environment variables

## macOS Service Directories

- `~/Library/LaunchAgents` - Per-user agents provided by the user.
- `/Library/LaunchAgents` - Per-user agents provided by the administrator.
- `/Library/LaunchDaemons` - System wide daemons provided by the administrator.
- `/System/Library/LaunchAgents` - OS X Per-user agents.
- `/System/Library/LaunchDaemons` - OS X System wide daemons.
