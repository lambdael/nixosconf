# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
with pkgs;
 {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #./machines/common.nix
      #./machines/proct_back.nix
       #./machines/proct.nix
       ./machines/gtyun.nix
      # ./machines/niney.nix
      ./users/users.nix
    ];
} 