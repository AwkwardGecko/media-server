#!/usr/bin/env bash
# /etc/nixos/hosts/wings/update.sh
set -euo pipefail

###############################################################################
# Become root if needed, preserving args
###############################################################################
SCRIPT="$(readlink -f "${BASH_SOURCE[0]}")"
if [[ $EUID -ne 0 ]]; then
  echo "[+] Re-execing as root"
  exec sudo -E bash "$SCRIPT" "$@"
fi

KEY="/root/.ssh/id_ed25519-nixos"
REPO_DIR="/etc/nixos"
FLAKE="/etc/nixos#wings"
STAMP="/tmp/nix_flake_update.timestamp"

###############################################################################
# 1. Git pull with deploy key
###############################################################################
cd "$REPO_DIR"
eval "$(ssh-agent -s)" >/dev/null
SSH_OPTS="-i $KEY -o IdentitiesOnly=yes"
export GIT_SSH_COMMAND="ssh $SSH_OPTS"
ssh-add -l 2>/dev/null | grep -q "$KEY" || ssh-add -q "$KEY"
git fetch --quiet origin
git reset --hard origin/main


###############################################################################
# 2. nix flake update (max once every 10 min)
###############################################################################
now=$(date +%s)
if [[ ! -f $STAMP || $(( now - $(<"$STAMP") )) -ge 600 ]]; then
  echo "[+] nix flake update"
  nix flake update
  echo "$now" > "$STAMP"
else
  echo "[=] nix flake update skipped (<10 min since last run)"
fi

###############################################################################
# 3. Rebuild
###############################################################################

echo "[+] nixos-rebuild switch"
nixos-rebuild switch --flake "$FLAKE" --show-trace
# bash /etc/nixos/scripts/refresh-plasma.sh


wings@wings-nixos ~/scripts> cat delete-old-files
#~/usr/bin/env bash


sudo du -h --max-depth=1 / | sort -h
sudo du -h --max-depth=1 /nix | sort -h
sudo du -sh /nix/var/log/nix/drvs
sudo rm -rf /nix/var/log/nix/drvs/*

journalctl --disk-usage                 # see the damage
sudo journalctl --vacuum-time=7d        # keep just a week
sudo journalctl --vacuum-size=100M      # and cap it

sudo nix-store --gc --print-roots | \
  while read -r root _; do
    [ -e "$root" ] || sudo rm -f "$root"
  done
sudo nix-store --gc                       # run GC again

sudo nix profile wipe-history --profile /nix/var/nix/profiles/per-user/root --older-than 7d
for u in $(ls /nix/var/nix/profiles/per-user); do
  nix profile wipe-history --profile /nix/var/nix/profiles/per-user/$u --older-than 7d
done

sudo rm -rf /var/cache/nix/*
sudo rm -rf /root/.cache/nix/*


sudo nix-collect-garbage -d --delete-older-than 7d
sudo nix store gc
nix profile wipe-history --older-than 7d
sudo rm -rf ~/.cache/nix
sudo find /nix/var/nix/gcroots/auto -xtype l -delete
sudo nix-store --optimise

nix path-info -rSh /run/current-system   # how big is the closure you actually need
df -h /                                  # see what you reclaimed
