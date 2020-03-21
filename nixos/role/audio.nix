{ config, pkgs, ... }:
{


  boot.kernelModules = [ "snd-seq" "snd-rawmidi" ];
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };


  environment.systemPackages = with pkgs; [
    pulseaudioFull
    jack2Full
    qjackctl
    lxqt.pavucontrol-qt
    sox # command line player, fileconverter
    ncpamixer
    lmms # DAW
  #  alsamixer
  ];
}
