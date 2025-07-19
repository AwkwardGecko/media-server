#!/usr/bin/env bash
# Generates /etc/nixos/hostname.nix if missing or outdated
set -euo pipefail

serial=$(tr -d ' ' < /sys/class/dmi/id/product_serial 2>/dev/null || true)
[[ -z $serial || $serial == Unknown ]] && serial=$(cut -c1-8 /etc/machine-id)
hostname="nixos-${serial: -6}"

mod_dir="/etc/nixos"
mod_file="$mod_dir/hostname.nix"

sudo mkdir -p "$mod_dir"

if [[ ! -f $mod_file ]] || ! grep -q "$hostname" "$mod_file"; then
  echo "Writing host module → $hostname"
  sudo tee "$mod_file" >/dev/null <<EOF
{ ... }: {
  networking.hostName = "${hostname}";
}
EOF
fi
