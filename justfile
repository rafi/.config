# github.com/rafi/.config justfile
# ---

[private]
default:
  @just --list --unsorted

# OS
# ---

# Show system information.
info:
  #!/usr/bin/env bash
  test -n "$KITTY_WINDOW_ID" && echo -n "kitty"
  test -z "$TMUX" && test -z "$KITTY_WINDOW_ID" && echo -n "$TERM_PROGRAM"
  echo -e " $TERM_PROGRAM_VERSION\n"
  echo "SHELL: $SHELL $BASH_VERSION"
  test -n "$TMUX" && echo "TMUX: $(tmux -V | awk '{print $2}') $TMUX"
  echo "TERM: $TERM"
  echo "LANG: $LANG"
  test -n "$COLORTERM" && echo "COLORTERM: $COLORTERM"
  echo -e "\nPATH: $PATH"

# Create brew bundle in this directory.
@bundle:
  mv -v Brewfile.older{,er} || true
  mv -v Brewfile.old{,er} || true
  mv -v Brewfile{,.old} || true
  brew bundle dump

# terminfo:
#   #!/usr/bin/env bash
#   cd "$TERMINFO"
#   curl -LO http://invisible-island.net/datafiles/current/terminfo.src.gz
#   gunzip terminfo.src.gz
#   tic terminfo.src

# Clone machines.git.
setup:
  git clone git@github.com:rafi/machines.git ~/code/rafi/machines
  ls -al ~/code/rafi/machines/bin/setup*sh
  @echo -e 'Jump into ~/code/rafi/machines\nand run a ./bin/ script.'

# Productivity
# ---

# Show calendar.
@cal:
  task cal || ncal -wC3 || \cal

# Show the next calendar events.
cal-next:
  gcalcli \
    --configFolder "$HOME/.config/gcalcli" \
    --nostarted --tsv agenda \
    --nocolor | awk -F $'\t' '$2 != $4 {print $2, $5; exit}'

# UI
# ---

ascii2gif cast:
  agg --theme monokai \
    --theme 232323,A0A0A0,2A2A2A,D370A3,6D9E3F,B58858,6095C5,AC7BDE,3BA275,FFFFFF,686868,FFA7DA,A3D572,EFBD8B,98CBFE,E5B0FF,75DAA9,CFCFCF \
    --font-family PragmataPro --font-size 21 \
    {{ cast }} {{ file_stem(cast) }}.gif

notify message title='':
  #!/usr/bin/env bash
  set -eu
  if [[ "$OSTYPE" == "darwin"* ]]; then
    if hash terminal-notifier 2>/dev/null; then
      terminal-notifier -title '{{ title }}' -message '{{ message }}'
    else
      say '{{ title }}: {{ message }}'
    fi
  else
    /usr/bin/notify-send '{{ title }}' '{{ message }}'
  fi

colors *FLAGS:
  #!/usr/bin/env bash
  printf "\n$(tput bold) reg  bld  und   tput-command-colors$(tput sgr0)\n"
  for i in $(seq 1 7); do
    printf " $(tput setaf $i)Text$(tput sgr0) $(tput bold)$(tput setaf $i)Text"
    printf "$(tput sgr0) $(tput sgr 0 1)$(tput setaf $i)Text$(tput sgr0)"
    printf "  \$(tput setaf $i)\n"
  done
  printf " $(tput bold)Bold$(tput sgr0)            \$(tput bold)\n"
  printf " $(tput sgr 0 1)Underline$(tput sgr0)       \$(tput sgr 0 1)\n"
  printf " Reset           \$(tput sgr0)\n"
  printf '\n\n'
  i=0
  while [ "$i" -le 255 ]; do
    if [ "{{ FLAGS }}" = "-b" ]; then
      printf "\033[38;5;${i}m%s" '█'
    else
      printf "\033[38;5;${i}m%s%03u" '■' $i
    fi
    [ $(((i + 1) % 16)) -eq 0 ] && [ $i -gt 0 ] && printf '\n'
    i=$((i + 1))
  done
  printf '\033[0m\n\n'

# Development
# ---

venv:
  [ -d .venv ] || uv venvbundle dump

http-local:
  #!/usr/bin/env bash
  set -eu
  if hash tailscale 2>/dev/null; then
    tailscale serve .
  if hash ngrok 2>/dev/null; then
    ngrok http 8000
  elif hash python 2>/dev/null; then
    python -m http.server 8000
  elif hash ruby 2>/dev/null; then
    ruby -rwebrick -e 'WEBrick::HTTPServer.new(:Port => 8000, :DocumentRoot => ".").start'
  elif hash php 2>/dev/null && php -v | grep -qm1 'PHP 5\.[45]\.'; then
    php -S 0.0.0.0:8000
  elif hash plackup 2>/dev/null; then
    plackup -MPlack::App::Directory -e 'Plack::App::Directory->new(root => ".")->to_app'
  fi

# Mounts
# ---

rclone-mount remote dest='~/drive':
  rclone mount {{ remote }}: {{ dest }} \
    --no-checksum \
    --use-server-modtime \
    --no-gzip-encoding \
    --no-seek \
    --allow-other \
    --allow-non-empty \
    --cache-read-retries 15 \
    --cache-db-purge \
    --buffer-size 512M \
    --dir-cache-time 500h \
    --timeout 500h \
    --vfs-cache-max-age 500h \
    --vfs-read-ahead 1G \
    --vfs-read-chunk-size 32M \
    --vfs-cache-max-size 25G \
    --cache-dir="$XDG_CACHE_HOME/rclone" \
    --vfs-cache-poll-interval 10s \
    --poll-interval 10s \
    --attr-timeout 20s \
    --vfs-cache-mode full

# Backup & Sync
# ---

# Sync dotfiles but skip newer files on receiver.
sync-dotfiles server *FLAGS:
  cd ~ && rsync -auRhvz {{ FLAGS }} --exclude-from=.config/.rsync_exclude \
    --exclude *.cache \
    --exclude *.log \
    --exclude *.zwc \
    --exclude .zcompdump \
    --exclude asciinema/install-id \
    --exclude configstore \
    --exclude fish/fishd.* \
    --exclude gcalcli/cache \
    --exclude gcloud/logs \
    --exclude github-copilot/versions.json \
    --exclude gnupg \
    --exclude google-chrome \
    --exclude gtk-2.0/gtkfilechooser.ini \
    --exclude lazygit/state.yml \
    --exclude medusa/config.json \
    --exclude mps-youtube \
    --exclude mpv/watch_later \
    --exclude oni2/extensions \
    --exclude raycast/extensions \
    --exclude syncthing \
    --exclude systemd/*/*.wants \
    --exclude systemd/*/dbus-org.gnome.*.service \
    --exclude telepresence/id \
    --exclude tox \
    --exclude virtualbox \
    --exclude weechat/logs \
    --exclude zed/embeddings \
    .config .bashrc .profile .tarsnaprc .netrc .gits.yaml \
    '{{ server }}:'

# Sync machine. Use `--delete` and/or `-n` (dry-run) if needed.
sync server *FLAGS:
  cd ~ && rsync -auRhvz {{ FLAGS }} --exclude-from=.config/.rsync_exclude \
    --exclude upstream-versions \
    box code docs .kube/configs .local/bin .local/state .local/share/atuin \
    .local/share/calibre .local/share/com.vercel.cli .local/share/firenvim \
    .local/share/nvim/site .local/share/terminfo .local/share/timewarrior \
    '{{ server }}:'
  rsync -auhvz {{ FLAGS }} --exclude known_hosts* --exclude tarsnap.key \
    --exclude .sockets --exclude authorized_keys* --exclude current* \
    --exclude google_compute* \
    ~/.ssh '{{ server }}:'

sync-music src='~/music' dest='rafi-desk:media/music':
  #!/usr/bin/env bash
  args=''
  [[ "$OSTYPE" == "darwin"* ]] && args='--iconv=UTF8-MAC,UTF-8'
  rsync -avh --progress --chown=rafi:users "$args" "$src" "$dest"

backup-defaults:
  #!/usr/bin/env bash
  DEST="$HOME/backups/$HOSTNAME"
  defaults read > "$DEST"/all.plist
  defaults read NSGlobalDomain > "$DEST"/global.plist
  defaults read com.apple.universalaccess > "$DEST"/universalaccess.plist
  defaults read com.apple.systempreferences > "$DEST"/systempreferences.plist
  defaults read com.apple.helpviewer > "$DEST"/helpviewer.plist
  defaults read com.apple.driver.AppleBluetoothMultitouch.trackpad > "$DEST"/trackpad.plist
  # defaults read com.apple.BluetoothAudioAgent > "$DEST"/BluetoothAudioAgent.plist
  defaults read /Library/Preferences/com.apple.loginwindow > "$DEST"/loginwindow.plist

# Download backups from box.
sync-box-backups:
  #!/usr/bin/env bash
  DEST="$HOME/backups/box"
  rsync -avP box:.apps/backup/ "$DEST"/apps
  rsync -avP box:.apps/audiobookshelf/metadata/backups/ "$DEST"/scheduled/
  rsync -avP box:.apps/audiobookshelf/config/absdatabase.sqlite "$DEST"/apps/audiobookshelf/
  rsync -avP box:.apps/bazarr/config "$DEST"/apps/bazarr/
  rsync -avP box:.apps/bazarr/db "$DEST"/apps/bazarr/
  rsync -avP box:.apps/bazarr/backup/ "$DEST"/scheduled/
  rsync -avP box:.apps/homarr "$DEST"/apps/
  rsync -avP --exclude='/*/*/' box:.apps/kavita "$DEST"/apps/
  rsync -avP box:.apps/kavita/backups/ "$DEST"/manual/
  rsync -avP --exclude='/*/*/' box:.apps/lidarr "$DEST"/apps/
  rsync -avP box:.apps/lidarr/Backups/ "$DEST"/
  rsync -avP --exclude='/*/*/' box:.apps/navidrome "$DEST"/apps/
  rsync -avP --exclude='/*/*/' box:.apps/prowlarr "$DEST"/apps/
  rsync -avP box:.apps/prowlarr/Backups/ "$DEST"/
  rsync -avP --exclude='/*/*/' box:.apps/radarr "$DEST"/apps/
  rsync -avP box:.apps/radarr/Backups/ "$DEST"/
  rsync -avP --exclude='/*/*/' box:.apps/readarr "$DEST"/apps/
  rsync -avP box:.apps/readarr/Backups/ "$DEST"/
  rsync -avP --exclude='/*/*/' box:.apps/sonarr "$DEST"/apps/
  rsync -avP box:.apps/sonarr/Backups/ "$DEST"/

# Generate a new tarsnap key for this machine.
tarsnap-keygen email:
  tarsnap-keygen \
    --keyfile ~/.ssh/tarsnap.key \
    --user {{ email }} \
    --machine "$(uname -n)"

# List tarsnap archives.
tarsnap-list:
  tarsnap --print-stats -f '*'

# Run tarsnap. Use `--delete` and/or `-n` (dry-run) if needed.
tarsnap *FLAGS:
  #!/usr/bin/env bash
  set -euo pipefail
  ARCHIVE_NAME="$(uname -n)-$(date +%Y-%m-%d)"
  CONFIG=.tarsnap_include
  [ ! -f "$CONFIG" ] && echo "Missing $CONFIG file" 1>&2 && exit 1

  # Read relative directories from config file, allow absolute paths.
  echo "Backup the following directories:"
  readarray -t RELATIVE_DIRS < $CONFIG
  BACKUP_DIRS=()
  for DIR in "${RELATIVE_DIRS[@]}"; do
    if [ ! "$(printf %.1s "$DIR")" = "/" ]; then
      DIR="$HOME/$DIR"
    fi
    echo "  - ${DIR//${HOME}/\~}"
    BACKUP_DIRS+=("${DIR}")
  done

  # Confirm and run.
  echo -e "\nArchive: ${ARCHIVE_NAME}"
  read -rp 'Continue (y/n)? ' choice
  [[ ! $choice =~ ^[Yy]$ ]] && echo 'Aborted.' 2>&1 && exit 1
  tarsnap -c --print-stats --humanize-numbers {{ FLAGS }} \
    -f "${ARCHIVE_NAME}" "${BACKUP_DIRS[@]}" ## >debug.log 2>&1

# EOF
