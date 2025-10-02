#!/usr/bin/env bash

# Expanded from 0atman's rebuild-nixos script: https://gist.github.com/0atman/1a5133b842f929ba4c1e195ee67599d5

set -euo pipefail


# === Configuration ===
FLAKE_PATH="$HOME/nixos"
BRANCH="main"
REMOTE="origin"
LOG_DIR="$FLAKE_PATH/logs"
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
LOG_FILE="$LOG_DIR/rebuild-$TIMESTAMP.log"
GEN_COLOR="\e[32m"
ERR_COLOR="\e[31m"
NC="\e[0m" # No color
AUTO_PUSH=true
DELETE_OLD=false
FORCE=false
VERBOSE=false
UPDATE=false

usage() {
	echo -e "Usage: $0 [-dfv] <flake-host>\n"
	echo -e "Flags:\n"
	echo -e "-d | delete nixos builds older than 15 days\n"
	echo -e "-f | force program to run\n"
	echo -e "-u | update nix flake\n"
	echo -e "-v | verbose mode\n"
}


while getopts "dfuv" flag; do
	case ${flag} in
		d) DELETE_OLD=true ;;
		f) FORCE=true ;;
		u) UPDATE=true ;;
		v) VERBOSE=true ;;
		*) usage; exit 1 ;;
	esac
done

shift $((OPTIND - 1))

if [ "$VERBOSE" = true ]; then
	set -x
fi


# === Check for hostname ===
if [[ $# -lt 1 ]]; then
  echo -e "${ERR_COLOR}❌ Error: You must provide a flake host name as the first argument.${NC}"
  usage
  exit 1
fi

FLAKE_HOST="$1"

# === Check for Sudo Access ===
echo -e "\n${GEN_COLOR}Requesting sudo access...${NC}"
if sudo -v; then
    echo -e "${GEN_COLOR}✅ Sudo authentication successful.${NC}\n"
else
    echo -e "${ERR_COLOR}❌ Failed to authenticate with sudo. Exiting.${NC}\n"
    exit 1
fi

mkdir -p "$LOG_DIR"
pushd "$FLAKE_PATH" > /dev/null


echo "$FLAKE_PATH"

# === Check for tracked file changes ===
if [[ -z "$(git status --porcelain)" ]]; then
	if [ "$FORCE" = false ]; then 
    	echo -e "\n${GEN_COLOR}No tracked file changes detected. Exiting.${NC}\n"
    	popd > /dev/null
    	exit 0
	fi
	echo -e "\n${GEN_COLOR}No tracked file changes detected. Continuing...${NC}\n"
else
    echo -e "\n${GEN_COLOR}Detected changes in tracked files:${NC}"
    git status --porcelain
fi

# === Format with alejandra ===
if ! sudo alejandra . &>/dev/null; then
    echo -e "\n${ERR_COLOR}Alejandra autoformat failed. Retrying with output...${NC}\n"
    sudo alejandra . || (echo -e "${ERR_COLOR}Final formatting failed.${NC}" && exit 2)
fi

# === Show diffs ===
echo -e "\n${GEN_COLOR}Showing changes (git diff):${NC}\n"
git diff --color=always
echo -e "\n${GEN_COLOR}End of git diff output.${NC}\n"

# === NixOS Rebuild ===
git add -A
echo -e "${GEN_COLOR}Rebuilding NixOS...${NC}\n"
if ! sudo nixos-rebuild switch --flake "$FLAKE_PATH#$FLAKE_HOST" &> "$LOG_FILE"; then
    echo -e "\n${ERR_COLOR}Rebuild failed. Showing errors:${NC}\n"
    grep --color=auto -Ei "error|failed|panic" "$LOG_FILE" || cat "$LOG_FILE"
    notify-send "❌ NixOS rebuild failed!" "Check $LOG_FILE" || true
    exit 1
fi

# === Metadata for commit ===
current=$(nixos-rebuild list-generations | grep 'True' || echo "Unknown Generation")

gen_num=$(echo "$current" | awk '{print $1}')
date_part=$(echo "$current" | awk '{print $2}')
time_part=$(echo "$current" | awk '{print $3}' | cut -c1-5)
nixos_version=$(echo "$current" | awk '{print $4}')
kernel_version=$(echo "$current" | awk '{print $5}')
hash_full=$(echo "$current" | awk '{print $6}')
hash_short=${hash_full##*.}

commit_msg="gen $gen_num @ $date_part $time_part ($hash_short) kernel $kernel_version"

# === Git commit and push ===
echo -e "\n${GEN_COLOR}Committing changes: ${NC}$commit_msg\n"
git commit -m "$commit_msg" || echo -e "${ERR_COLOR}Nothing to commit.${NC}"

if [ "$AUTO_PUSH" = true ]; then
    echo -e "\n${GEN_COLOR}Pushing to remote '$REMOTE'...${NC}\n"
    git push "$REMOTE" "$BRANCH" || echo -e "${ERR_COLOR}Push failed.${NC}"
fi

# === Delete Old Builds ===
if [ "$DELETE_OLD" = true ]; then
	echo -e "\n${GEN_COLOR}Deleting Old Builds... (15d):\n"
	nix-collect-garbage --delete-older-than 15d &> "$LOG_FILE"
fi

popd > /dev/null

# === Notify OK ===
if command -v notify-send &>/dev/null; then
    notify-send "✅ NixOS Rebuilt OK!" --icon=software-update-available
fi

echo -e "\n${GEN_COLOR}✔️  Done. Log: $LOG_FILE${NC}\n"
