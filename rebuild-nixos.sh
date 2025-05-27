#!/usr/bin/env bash

# Script by ChatGPT 
# Expanded from 0atman's rebuild-nixos script: https://gist.github.com/0atman/1a5133b842f929ba4c1e195ee67599d5

set -euo pipefail

# === Configuration ===
FLAKE_PATH="/etc/nixos"
BRANCH="main"
REMOTE="origin"
LOG_DIR="$FLAKE_PATH/logs"
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
LOG_FILE="$LOG_DIR/rebuild-$TIMESTAMP.log"
GEN_COLOR="\e[32m"
ERR_COLOR="\e[31m"
NC="\e[0m" # No color
AUTO_PUSH=true

mkdir -p "$LOG_DIR"
pushd "$FLAKE_PATH" > /dev/null

# === Check for tracked file changes ===
if [[ -z "$(git status --porcelain)" ]]; then
    echo -e "\n${GEN_COLOR}No tracked file changes detected. Exiting.${NC}\n"
    popd > /dev/null
    exit 0
else
    echo -e "\n${GEN_COLOR}Detected changes in tracked files:${NC}"
    git status --porcelain
fi

# === Format with alejandra ===
if ! alejandra . &>/dev/null; then
    echo -e "\n${ERR_COLOR}Alejandra autoformat failed. Retrying with output...${NC}\n"
    alejandra . || (echo -e "${ERR_COLOR}Final formatting failed.${NC}" && exit 2)
fi

# === Show diffs ===
echo -e "\n${GEN_COLOR}Showing changes (git diff):${NC}\n"
git diff --color=always
echo -e "\n${GEN_COLOR}End of git diff output.${NC}\n"

# === NixOS Rebuild ===
echo -e "${GEN_COLOR}Rebuilding NixOS...${NC}\n"
if ! sudo nixos-rebuild switch --flake "$FLAKE_PATH#$1" &> "$LOG_FILE"; then
    echo -e "\n${ERR_COLOR}Rebuild failed. Showing errors:${NC}\n"
    grep --color=auto -Ei "error|failed|panic" "$LOG_FILE" || cat "$LOG_FILE"
    notify-send "❌ NixOS rebuild failed!" "Check $LOG_FILE" || true
    exit 1
fi

# === Metadata for commit ===
current=$(nixos-rebuild list-generations | grep current || echo "Unknown Generation")

gen_num=$(echo "$current" | awk '{print $1}')
date_part=$(echo "$current" | awk '{print $3}')
time_part=$(echo "$current" | awk '{print $4}' | cut -c1-5)
hash_full=$(echo "$current" | awk '{print $5}')
hash_short=${hash_full##*.}
kernel_version=$(echo "$current" | awk '{print $6}')

commit_msg="gen $gen_num @ $date_part $time_part ($hash_short) kernel $kernel_version"

# === Git commit and push ===
echo -e "\n${GEN_COLOR}Committing changes: ${NC}$commit_msg\n"
sudo git add -A
sudo git commit -m "$commit_msg" || echo -e "${ERR_COLOR}Nothing to commit.${NC}"

if [ "$AUTO_PUSH" = true ]; then
    echo -e "\n${GEN_COLOR}Pushing to remote '$REMOTE'...${NC}\n"
    sudo git push "$REMOTE" "$BRANCH" || echo -e "${ERR_COLOR}Push failed.${NC}"
fi

popd > /dev/null

# === Notify OK ===
if command -v notify-send &>/dev/null; then
    notify-send "✅ NixOS Rebuilt OK!" --icon=software-update-available
fi

echo -e "\n${GEN_COLOR}✔️  Done. Log: $LOG_FILE${NC}\n"
