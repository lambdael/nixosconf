# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
with pkgs;
{

  environment.systemPackages = with pkgs; [
    wget
    vim
    tmux
    git
    tcpdump
    dnsutils
    
  ];
  imports =
    [ # Include the results of the hardware scan.
    #./hardware-configuration.nix

      # ../lib/pci-passthrough.nix
    ../role/minimal.nix
    ../role/router.nix
    ../role/gui.nix
     # ../role/pythondev.nix
     # ../role/nodejsdev.nix
     # ../role/audio.nix
     # ../role/unfree.nix
     # ../role/graphic.nix
    ../role/vscode.nix
    ];
  nixpkgs.config = {
     allowUnfree = true; #for?: vscode
      # more stuff
    };
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.grub.device = "/dev/sdc"; 
  boot.kernel.sysctl = {
    "net.ipv6.conf.all.forwarding" = true;
    "net.ipv6.conf.enp1s0.accept_ra" = 2;
  };
  services.nix-serve.enable = true;
    # Enable the xrdp daemon.
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "xmonad";
 # networking.firewall.allowedTCPPorts = [ 3389 ];



}
