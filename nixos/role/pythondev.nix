# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
with pkgs;
let
  my-python-packages = python-packages: with python-packages; [
    pylint
    autopep8
    beautifulsoup4
#    google-api-python-client
    # other python packages you want
  ]; 
  python-with-my-packages = python3.withPackages my-python-packages;
in {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    python-with-my-packages
  ];

}
