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
      ../role/pythondev.nix
      ../role/nodejsdev.nix
     # ../role/audio.nix
     # ../role/unfree.nix
      ../role/graphic.nix
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
    inputMethod = {
      enabled = "ibus";
      fcitx.engines = with pkgs.fcitx-engines; [
        anthy
      ];
      ibus.engines = with pkgs.ibus-engines; [ 
        anthy
      ];
    };
  };
  # programs = {
  #   ibus.enable = true;
  #   ibus.plugins 
  # };
  # Set your time zone.
  #   services.postgresql = {
  #   enable = true;
  #   package = pkgs.postgresql100;
  #   enableTCPIP = true;
  #   # authentication = pkgs.lib.mkOverride 10 ''
  #   #   local all all trust
  #   #   host all all ::1/128 trust
  #   # '';ss
  #   initialScript = pkgs.writeText "backend-initScript" ''
  #     CREATE ROLE lambdael WITH LOGIN PASSWORD 'lambdael' CREATEDB;
  #     CREATE DATABASE testdb;
  #     GRANT ALL PRIVILEGES ON DATABASE testdb TO lambdael;
  #   '';
  # };
  # services.postgresql.enable = true;
  # services.pgmanage.enable = true;
  # services.pgmanage.connections ={
  #    gtyun = "hostaddr=127.0.0.1 port=5432 dbname=postgres ";  
  # };
  time.timeZone = "Asia/Tokyo";

  services.xserver = {
    videoDrivers = [ "mesa" ];
    # videoDrivers = [ "nvidia" ];
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
    bash-completion
    tmux
    # gnupg
    # pass
    htop
    #ruby
    #xorg.xrdb
    ((pkgs.callPackage ../packages/nix-home/package.nix) { })
  ];


}
