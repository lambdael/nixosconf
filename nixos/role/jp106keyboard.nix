{ config, pkgs, ... }:
{    # Select internationalisation properties.
  i18n = {
    consoleFont = "Source Code Pro 32";
    # consoleFont = "Terminess Powerline";
    consoleColors = [ "002b36" "dc322f" "859900" "b58900" "268bd2" "d33682" "2aa198" "eee8d5" "002b36" "cb4b16" "586e75" "657b83" "839496" "6c71c4" "93a1a1" "fdf6e3" ];
    consoleKeyMap = "jp106";
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      # ftcitx does not work in RDP/. 2018
      enabled = "fcitx";
      fcitx.engines = with pkgs.fcitx-engines; [
        anthy mozc
      ];
      # ibus.engines = with pkgs.ibus-engines; [ 
      #   anthy
      # ];
    };
  };
  services.xserver.layout = "jp";

  time.timeZone = "Asia/Tokyo";

}
