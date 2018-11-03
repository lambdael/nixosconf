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
      #../role/nodsjsdev.nix
      ../role/audio.nix
    #  ../role/game.nix
     # ../role/unfree.nix
      #../role/graphic.nix
      ../role/minimal.nix
      ../role/haskelldev.nix
      # ../role/emacs.nix
      ../role/vscode.nix
      ../role/jp106keyboard.nix
      
    ];
      networking.hostName = "iso"; # Define your hostname.
  fonts.fontconfig = {
    enable = true;
    dpi = 180;
    defaultFonts = {
        monospace = [ 
          "Source Code Pro 18"
          "IPAGothic"
          "Baekmuk Dotum"
        ];
        serif = [ 
          "Source Code Pro 18"
          "DejaVu Serif"
          "IPAPMincho"
          "Baekmuk Batang"
        ];
        sansSerif = [
          "Source Code Pro 18"
          "DejaVu Sans"
          "IPAPGothic"
          "Baekmuk Dotum"
        ];
      };

  };     

  nixpkgs.config = {
     allowUnfree = true; #for?: vscode
      # more stuff
    };
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # users.users.lambdael.cryptHomeLuks = "/dev/disk/by-uuid/97335df2-8ae2-4b95-a44f-c91c00627304";
  # fileSystems = {
  #   "/home/lambdaelbak" = {
  #     encrypted.enable = true;
  #     encrypted.label = "lambdael";
  #     encrypted.blkDev = "/dev/disk/by-uuid/97335df2-8ae2-4b95-a44f-c91c00627304";
  #     device = "/dev/mapper/lambdael";
  #     fsType = "ext4";
  #     options =[
  #       "noauto,x-systemd.automount,x-systemd.idle-timeout=10min"
  #       "users"
  #       "nofail"
  #       "nodev"
  #       "nosuid"
  #       "relatime"
  #     ];
      
  #   };
  # };
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


  # boot.initrd.luks.devices = {
  #   "lambdael" = {
  #     device = "/dev/disk/by-uuid/97335df2-8ae2-4b95-a44f-c91c00627304";
  #   };
  # };

    # Enable the xrdp daemon.
  services.xrdp.enable = false;
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
    rxvt_unicode-with-plugins
    fbterm
 #   nerdfonts
    vimHugeX
    lesspipe
    cryptsetup
  # syslinux
  ];
  # nix.binaryCaches = [ "https://cache.nixos.org/" "https://nixcache.reflex-frp.org" ];
  # nix.binaryCachePublicKeys = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?
  services.compton.enable=true;
  # services.compton.blur = true;
  # services.compton.fade = true;
  # services.compton.fadeDelta = 5;
  # services.compton.inactiveOpacity = "0.8";
  # services.compton.shadow = false;
  # programs.vim.defaultEditor = true;
}
