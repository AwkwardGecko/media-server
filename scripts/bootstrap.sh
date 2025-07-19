#!/usr/bin/env bash
#/etc/nixos/scripts/bootstrap.sh
set -euo pipefail
cd /etc/nixos

# --- Step 0: Generate correct hostname -------------------------------------------------
sudo chmod +x /etc/nixos/scripts/*
/etc/nixos/scripts/update-hostname.sh
 
# --- Step 1: create read-only deploy key on GitHub --------------------------------------

SSH_KEY="$HOME/.ssh/id_nixos_wings"

if [[ ! -f $SSH_KEY ]]; then
  echo "[+] Generating deploy key"
  ssh-keygen -t ed25519 -f "$SSH_KEY" -N "" -C "nixos-wings"

  GITHUB_TOKEN=$(tr -d '\n' < /home/wings/.ssh/github-token.txt)
  GITHUB_USER="AwkwardGecko"
  GITHUB_REPO="media-server"

  echo "[+] Uploading deploy key to GitHub"
  curl -s \
       -H "Authorization: token $GITHUB_TOKEN" \
       -H "Accept: application/vnd.github.v3+json" \
       -d @- \
       "https://api.github.com/repos/${GITHUB_USER}/${GITHUB_REPO}/keys" <<EOF
{
  "title": "$(cat hosts/local/host.nix | grep hostName | cut -d'"' -f2)-$(date +%s)",
  "key": "$(cat "${SSH_KEY}.pub")",
  "read_only": true
}
EOF
  unset GITHUB_TOKEN
fi

# --- Step 3: pull/update the flake repo ------------------------------------------------

eval "$(ssh-agent -s)" >/dev/null
ssh-add -q "$SSH_KEY"

git fetch --quiet origin || git clone git@github.com:AwkwardGecko/media-server.git .
git reset --hard origin/main

# --- Step 4: flake-lock update (10 minutes) --------------------------------------------

stamp=/tmp/nix_flake_update.timestamp
if [[ ! -f $stamp || $(( $(date +%s) - $(< $stamp) )) -ge 600 ]]; then
  echo "[+] nix flake update"
  nix flake update
  date +%s > $stamp
fi

# --- Step 5: pure rebuild ---------------------------------------------------------------

sudo nixos-rebuild switch --flake /etc/nixos# --show-trace
echo "[✓] bootstrap finished"
