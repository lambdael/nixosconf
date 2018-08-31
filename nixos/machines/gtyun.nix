# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
with pkgs;
 {

     imports =
    [ # Include the results of the hardware scan.
      #../hardware-configuration.nix
      # ../lib/pci-passthrough.nix
      ../role/gui.nix
      #../role/pythondev.nix
      #../role/nodejsdev.nix
     # ../role/audio.nix
     # ../role/unfree.nix
      #../role/graphic.nix
      ../role/minimal.nix
      ../role/haskelldev.nix
      ../role/emacs.nix
      ../role/vscode.nix

    ];
  nixpkgs.config = {
     allowUnfree = true; #for?: vscode
      # more stuff
    };
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


    # Enable the xrdp daemon.
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "xmonad";
  networking.firewall.allowedTCPPorts = [ 3389 ];



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
    stack
    termite
    compton
    sqlite
    # neovim
    # haskellPackages.nvim-hs
    # haskellPackages.nvim-hs-contrib
    # haskellPackages.nvim-hs-ghcid 
    #ruby
    #xorg.xrdb
    nixops
    ((pkgs.callPackage ../packages/nix-home/package.nix) { })
  ];
  nix.binaryCaches = [ "https://cache.nixos.org/" "https://nixcache.reflex-frp.org" ];
  nix.binaryCachePublicKeys = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?
  services.compton.enable=true;
  # services.compton.blur = true;
  services.compton.fade = true;
  services.compton.fadeDelta = 5;
  services.compton.inactiveOpacity = "0.8";
  services.compton.shadow = false;
  # programs.vim.defaultEditor = true;
}
