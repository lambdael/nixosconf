# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
with pkgs;
let

in {
  imports =
    [ # Include the results of the hardware scan.
    #./hardware-configuration.nix
      # ../lib/pci-passthrough.nix
    ../role/minimal.nix
     # ../role/gui.nix
     # ../role/pythondev.nix
     # ../role/nodejsdev.nix
     # ../role/audio.nix
     # ../role/unfree.nix
     # ../role/graphic.nix
      #../role/vscode.nix
    ];
  nixpkgs.config = {
     # allowUnfree = true; #for?: vscode
      # more stuff
    };
  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/sdc"; 
  networking.hostName = "niney"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget


}
