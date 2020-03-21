{ config, pkgs, ... }:

{
  imports =  [
    ../role/gui.nix
    ../role/audio.nix
  ];
  
  environment.systemPackages = with pkgs; [
    steam
  ];
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;
}
