{ config, pkgs, ... }:
{
  imports =  [
    ../role/gui.nix
  ];
  environment.systemPackages = with pkgs; [
    blender
    inkscape


  ];
}
