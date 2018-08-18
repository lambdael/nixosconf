{ config, pkgs, ... }:
with pkgs;
 {
  nix.binaryCaches = [http://192.168.1.1:5000/];

  fileSystems."/home/lambdael/usb" =
    { device = "/dev/disk/by-uuid/6630-6234";
      options = [ "noauto" "x-systemd.automount" ];
     # fsType = "exFat";
    };

  # List services that you want to enable:
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.bash.enableCompletion = true;

  # Enable the OpenSSH daemon.
  services = {
    openssh = {
      enable = true;
      #permitRootLogin = "without-password";
      passwordAuthentication = true;
    };
  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;
 
  # exFat support
  boot.extraModulePackages = [ config.boot.kernelPackages.exfat-nofuse ];

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus32";
    consoleKeyMap = "jp106";
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "fcitx";
      fcitx.engines = with pkgs.fcitx-engines; [
        anthy
      ];
      ibus.engines = with pkgs.ibus-engines; [ 
        anthy
      ];
    };
  };
  time.timeZone = "Asia/Tokyo";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.lambdael = {
    isNormalUser = true;
    home = "/home/lambdael";
    description = "lambdael";
    extraGroups = [ "wheel" "audio" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIAIqSwLLB7QYkvtiIF1UZZp/2g2LUlL3hIDx1D+J8MQ lambdael" ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?
}