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
      ../role/gui.nix
      ../role/python.nix
     # ../role/audio.nix
     # ../role/unfree.nix
      ../role/vscode.nix

    ];
  nixpkgs.config = {
     allowUnfree = true; #for?: vscode
      # more stuff
    };
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "gtyun"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus32";
    consoleKeyMap = "jp106";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  services = {
    xserver = {
      videoDrivers = [ "mesa" ];
     # videoDrivers = [ "nvidia" ];
    };
  };
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    #wget
    #vim
    nano
    sudo
    gitAndTools.gitFull
    nix-prefetch-git

    gnupg
    pass
    htop
    #ruby
    #xorg.xrdb
    ((pkgs.callPackage ../packages/nix-home/package.nix) { })
  ];


}
