#!/usr/bin/env bash

# Purge a macOS application and all its related files from the mac system. This script will attempt to stop any running processes of the app, remove the app from the Applications folder, and delete related files from the user's Library and home directory. It also offers to search for any remaining files and remove them if the user confirms. Finally, it restarts the macOS preference daemon to ensure all changes take effect.
#
# Author: Pablo Martín Anaquín
# Date: 16-03-2026
# Use:
#   ./mac_app_clean.sh "LM Studio"
# Audit:
#   fs_usage -w -f filesystem "LM Studio"

set -euo pipefail

if [ $# -lt 1 ]; then
  printf 'Usage: %s "App Name"\n' "$0"
  exit 1
fi

APP="$*"
APP_LC="$(printf '%s' "$APP" | tr '[:upper:]' '[:lower:]')"

printf '%s\n' "---------------------------------------"
printf 'Purging application: %s\n' "$APP"
printf '%s\n' "---------------------------------------"

printf '%s\n' "Stopping running processes..."
pkill -f -- "$APP" 2>/dev/null || true

printf '%s\n' "Removing /Applications/$APP.app..."
sudo rm -rf -- "/Applications/$APP.app" 2>/dev/null || true

shopt -s nullglob dotglob

rm_glob() {
  local glob=$1
  for f in $glob; do
    printf '  -> %s\n' "$f"
    rm -rf -- "$f" 2>/dev/null || true
  done
}

printf '%s\n' "Removing user Library files..."
for pattern in \
  "$HOME/Library/Application Support/$APP"* \
  "$HOME/Library/Caches/$APP"* \
  "$HOME/Library/Logs/$APP"* \
  "$HOME/Library/Preferences/"*"$APP"* \
  "$HOME/Library/Saved Application State/"*"$APP"* \
  "$HOME/Library/WebKit/"*"$APP"* \
  "$HOME/Library/HTTPStorages/"*"$APP"* \
  "$HOME/Library/Containers/"*"$APP"* \
  "$HOME/Library/Group Containers/"*"$APP"* \
  "$HOME/Library/LaunchAgents/"*"$APP"* \
  "$HOME/.cache/"*"$APP"* \
  "$HOME/.$APP"*; do
  rm_glob "$pattern"
done

printf '%s\n' "Searching home for leftovers..."
# mapfile -t found < <(find "$HOME" -maxdepth 4 -iname "*$APP_LC*" 2>/dev/null)
found=()
while IFS= read -r f; do
  found+=("$f")
done < <(find "$HOME" -maxdepth 4 -iname "*$APP_LC*" 2>/dev/null)

if [ "${#found[@]}" -gt 0 ]; then
  printf 'Found residual files:\n'
  printf '  %s\n' "${found[@]}"
  printf '\n'
  read -r -p "Remove these files? (y/n): " ans
  if [[ $ans =~ ^[Yy]$ ]]; then
    for f in "${found[@]}"; do
      rm -rf -- "$f" 2>/dev/null || true
    done
  fi
fi

printf '%s\n' "Restarting macOS preference daemon..."
killall cfprefsd 2>/dev/null || true

printf '%s\n' "---------------------------------------"
printf 'Purge completed for: %s\n' "$APP"
printf '%s\n' "---------------------------------------"