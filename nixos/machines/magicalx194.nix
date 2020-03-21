# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
with pkgs;
 {
    networking.hostName = "magicalx194"; # Define your hostname.
  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      # ftcitx does not work in RDP/. 2018
      enabled = "fcitx";
      fcitx.engines = with pkgs.fcitx-engines; [
        anthy mozc
      ];
      # ibus.engines = with pkgs.ibus-engines; [ 
      #   anthy
      # ];
    };
  };
  services.xserver.layout = "us";

  time.timeZone = "Asia/Tokyo";

     imports =
    [ # Include the results of the hardware scan.
      ../hardware-configuration.nix
      # ../lib/pci-passthrough.nix
      # ../role/game.nix
      #../role/pythondev.nix
      #../role/nodejsdev.nix
     # ../role/audio.nix
     # ../role/unfree.nix
      #../role/graphic.nix
      #../role/gui.nix
      ../role/minimal.nix
      # ../role/haskelldev.nix
      # ../role/emacs.nix
       ../role/vscode.nix
      ../users/users.nix


    ];
  nixpkgs.config = {
     allowUnfree = true; #for?: vscode
      # more stuff
    };
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/share" = {
    device = "/dev/disk/by-uuid/a0ce370b-6008-4c2f-aaa6-79d09ec74604";
    fsType = "ext4";
  };
  fonts.fontconfig = {
    enable = true;
    dpi = 150;
  };     
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


    # Enable the xrdp daemon.
  services.xrdp.enable = false;
  services.xrdp.defaultWindowManager = "xmonad";
  networking.firewall.allowedTCPPorts = [ 3389 ];



  services.xserver = {
    videoDrivers = [ "mesa" ];
    displayManager.job.preStart = ''
    export GDK_SCALE=1
    export QT_AUTO_SCREEN_SCALE_FACTOR=1
    export ELM_SCALE=1.5

    '';
    # xautolock.enable = false;
    # xautolock.time = 10;
    # videoDrivers = [ "nvidia" ];
  };
  
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    # wget
    # vim
    # syslinux
  ];
  # nix.binaryCaches = [ "https://cache.nixos.org/" "https://nixcache.reflex-frp.org" ];
  # nix.binaryCachePublicKeys = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
  # services.compton.enable=false;
  # services.compton.blur = true;
  # services.compton.fade = true;
  # services.compton.fadeDelta = 5;
  # services.compton.inactiveOpacity = "0.8";
  # services.compton.shadow = false;
  # programs.vim.defaultEditor = true;
}
