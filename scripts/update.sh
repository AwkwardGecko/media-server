#!/usr/bin/env bash
# /etc/nixos/scripts/update.sh
set -euo pipefail

cd /etc/nixos

# ── Git pull ────────────────────────────────────────────────────────────
eval "$(ssh-agent -s)" >/dev/null
ssh-add -q ~/.ssh/id_nixos_readonly
git fetch --quiet origin
git reset --hard origin/main

# ── Throttle nix flake update to once per 10 min ────────────────────────
stamp=/tmp/nix_flake_update.timestamp
if [[ ! -f $stamp || $(( $(date +%s) - $(<"$stamp") )) -ge 600 ]]; then
  echo "[+] nix flake update"
  nix flake update
  date +%s >"$stamp"
else
  echo "[=] nix flake update skipped (run <10 min ago)"
fi

# ── Rebuild ─────────────────────────────────────────────────────────────
  sudo nixos-rebuild switch \
       --upgrade \
       --flake /etc/nixos#wings \
       --show-trace

echo "[✓] System is fucking updated, you brain-dead inbred piss-guzzling tumor-brained"
echo "slack-jawed crusty-ass dogshit-eating baboon-fisting hemorrhoid-eating dumpsterfire dickwart"
