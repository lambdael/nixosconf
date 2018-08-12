# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
with pkgs;
 {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ./machines/gtyun.nix
      ./machines/niney.nix
    ];


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;



  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.lambdael = {
    isNormalUser = true;
    home = "/home/lambdael";
    description = "lambdael";
    extraGroups = [ "wheel" "audio" ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
