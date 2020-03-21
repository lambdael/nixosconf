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
      ../role/audio.nix
     # ../role/unfree.nix
      ../role/graphic.nix
      ../role/minimal.nix
      # ../role/haskelldev.nix
      ../role/emacs.nix
      ../role/vscode.nix
      # ../role/jp106keyboard.nix
      
    ];
  nixpkgs.config = {
     allowUnfree = true; #for?: vscode
      # more stuff
    };
  # Use the systemd-boot EFI boot loader.
  #boot.loader.systemd-boot.enable = true;
  boot.initrd.kernelModules = ["fbcon"];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.extraConfig = "fbcon=rotate:1";
  boot.loader.grub.extraPrepareConfig = "fbcon=rotate:1";
  # boot.loader.grub.extraPrepareConfig = "video=efifb fbcon=rotate:1";
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  # boot.loader.grub.device = "/dev/disk/by-id/7744-C440";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.gfxmodeEfi = "720x1280";
  boot.loader.grub.gfxmodeBios = "720x1280";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  users.users.lambdael.extraGroups = [ "networkmanager" ];

    # Enable the xrdp daemon.
  services.xrdp.enable = false;
  services.xrdp.defaultWindowManager = "xmonad";
  # networking.firewall.allowedTCPPorts = [ 3389 ];
  boot.kernelModules = [

    "joydev"
  ];
  fonts.fontconfig = {
    enable = true;
    dpi = 200;
  };     
  services.actkbd.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  services.xserver = {
    displayManager.sessionCommands = ''
    xrandr --output eDP1 --rotate right
    input set-prop "Goodix Capacitive TouchScreen" --type=float "Coordinate Transformation Matrix" 0 1 0 -1 0 1 0 0 1
   '';
#  displayManager.job.preStart = ''
#    xrandr --output eDP1 --rotate right
#    input set-prop "Goodix Capacitive TouchScreen" --type=float "Coordinate Transformation Matrix" 0 1 0 -1 0 1 0 0 1
 #  '';
    videoDrivers = [ "mesa" ];
    # videoDrivers = [ "nvidia" ];
    xrandrHeads =[ 
      { output = "eDP-1"; 
        primary = true; 
        monitorConfig =
          ''
            Option "Rotate" "right"
        
          '';
      }
    ];
  };
  
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    #wget
    #vim
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
  services.compton.fadeDelta = 3;
  # services.compton.inactiveOpacity = "0.8";
  # services.compton.shadow = false;
  programs.vim.defaultEditor = true;
}
