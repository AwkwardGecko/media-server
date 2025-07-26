#!/usr/bin/env bash
# /etc/nixos/scripts/
set -euo pipefail

mkdir -p ~/.ssh
rm ~/.ssh/id_nixos_readonly*

ssh-keygen -t ed25519 \
  -f ~/.ssh/id_nixos_readonly \
  -C "deploy key for wings" \
  -N ""

gh repo deploy-key add ~/.ssh/id_nixos_readonly.pub \
  --repo AwkwardGecko/media-server \
  --title "nixos-deploy-$(date +%F)" \
  
cd /etc/nixos
git remote -v
# if it shows https://, switch it:
git remote set-url origin git@github.com:AwkwardGecko/media-server.git

ssh -T git@github.com
git ls-remote origin
