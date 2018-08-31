#!/usr/bin/env sh



nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=nixos/isoimage.nix

mount -o loop -t iso9660 nixos/result/iso/ /mnt/iso
