# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
with pkgs;
 {
  imports =
    [ # Include the results of the hardware scan.
      #./hardware-configuration.nix
      ./machines/common.nix
      #./machines/proct_back.nix
       #./machines/proct.nix
       ./machines/gtyun.nix
      # ./machines/niney.nix
      <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>

      # Provide an initial copy of the NixOS channel so that the user
      # doesn't need to run "nix-channel --update" first.
      <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
    ];
  networking.hostName = "iso"; # Define your hostname.

} 
