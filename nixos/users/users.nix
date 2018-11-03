{ config, pkgs, ... }:
with pkgs;
 {

  i18n = {
    consoleFont = "Source Code Pro 32";
    # consoleFont = "Terminess Powerline";
    consoleColors = [ "002b36" "dc322f" "859900" "b58900" "268bd2" "d33682" "2aa198" "eee8d5" "002b36" "cb4b16" "586e75" "657b83" "839496" "6c71c4" "93a1a1" "fdf6e3" ];
  };
  nix={
    binaryCaches = [
      https://cache.nixos.org/
      https://lambdael.cachix.org
      https://nixcache.reflex-frp.org
    #	http://192.168.1.1:5000/
    #	ssh://192.168.1.1/
    ];
    binaryCachePublicKeys = [
      "lambdael.cachix.org-1:zzFfq6IdazT/9Ihowd74k+gClvHD239xgdea/7ojv34="
      "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="  ## reflex-frp
    ];
    trustedUsers = [ "root" "lambdael" ];
    allowedUsers = [ "root" "lambdael" ];
  };
  programs.less.enable = true;
  programs.fish.enable = true;
  
  programs.bash.loginShellInit = ''
  
  EDITOR=nvim
  VISUAL=code

  PAGER=less
  XDG_CONFIG_HOME=~/.xmonad/
  '';
  # programs.fish.loginShellInit = ''
  programs.fish.interactiveShellInit = ''
  set -x VISUAL code
  set -x EDITOR nvim
  set -x PAGER less
  set -x ZZZZ w3m
  function shless
    source-highlight-esc.sh $argv[1] | less -R
  end


  function fish_prompt
     /run/current-system/sw/bin/powerline-go   -error $status -shell bare
  end


  '';

  # source-highlight ./myXmonad/hie-wrapper.sh | w3m
  # exFat support
  boot.extraModulePackages = [ config.boot.kernelPackages.exfat-nofuse ];
  # fileSystems."/home/lambdael/usb" =
    # { device = "/dev/disk/by-uuid/6630-6234";
    #   options = [ "noauto" "x-systemd.automount" ];
    #  # fsType = "exFat";
    # };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lambdael = {
    isNormalUser = true;
    createHome = true;
    home = "/home/lambdael";
    description = "lambdael";
    extraGroups = [ "wheel" "audio" "builder"];
    shell = fish;
    openssh.authorizedKeys.keys = [ 
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIAIqSwLLB7QYkvtiIF1UZZp/2g2LUlL3hIDx1D+J8MQ lambdael"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP4uR+KUzPVNfWkynDOmbi1p3Wy0+F8yj3/GyKRmb4l/ lambdael@gtyun"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO4HrbPAWEnfEakKwg0zCT4gwEC1kMkstXpSkd3jznop lambdael@proct"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBm0wk+9rxjSz93IaDpLST3nXRB/y/ldW3nfvLZVpJQ4 lambdael@iso"
     ];
  };
  # boot.initrd.network.ssh.authorizedKeys = [
  #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBm0wk+9rxjSz93IaDpLST3nXRB/y/ldW3nfvLZVpJQ4 lambdael@iso"
  # ];
  users.users.root = {
    openssh.authorizedKeys.keys = [ 
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBm0wk+9rxjSz93IaDpLST3nXRB/y/ldW3nfvLZVpJQ4 lambdael@iso"
    ];
  };
  users.users.mpd = {
    createHome = false;
    extraGroups = [ "mpd" "audio"];
  };
  users.users.nyx = {
    isNormalUser = true;
    createHome = true;
    cryptHomeLuks = "/dev/sdc3";
    home = "/home/nyx";
    description = "nyx temp";
    extraGroups = [ "wheel" "audio" ];
    shell = fish;
    openssh.authorizedKeys.keys = [ 
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIAIqSwLLB7QYkvtiIF1UZZp/2g2LUlL3hIDx1D+J8MQ lambdael"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP4uR+KUzPVNfWkynDOmbi1p3Wy0+F8yj3/GyKRmb4l/ lambdael@gtyun"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO4HrbPAWEnfEakKwg0zCT4gwEC1kMkstXpSkd3jznop lambdael@proct"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBm0wk+9rxjSz93IaDpLST3nXRB/y/ldW3nfvLZVpJQ4 lambdael@iso"
     ];
  };
  security.pam.mount.enable = true;
# security.pam.mount.extraVolumes = [
# ''
# <volume user="USERNAME" fstype="auto" path="/dev/sdaX" mountpoint="/home" options="fsck,noatime" /> 
# ''
# ];

# to create key
#    ssh-keygen -t ed25519


# nix-env -qa 'ncmpc.*'
  environment.systemPackages = with pkgs; [
    ncmpcpp
  # syslinux
  ];

services.mpd={
  enable = true;
  musicDirectory = /share/music;

};

services.fractalart.enable = true;
# https://hackage.haskell.org/package/FractalArt
# FractalArt
# Usage
# These are optional

# It automatically detects your screen resolution.

# | Command | Argument | Description | Default | |--------------|----------|---------------------------------------------|-------------------------------| | -w, --width | Integer | sets width of the generated image | Screen Width | | -h, --height | Integer | sets height of the generated image | Screen Height | | -f, --file | Path | specify filename and path | ~/.fractalart/wallpaper.bmp | | -n, --no-bg | | don't set the wallpaper | |


# FractalArt -f ~/.fractalart/wallpaper00.bmp

}
