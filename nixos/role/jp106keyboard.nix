{ config, pkgs, ... }:
{    # Select internationalisation properties.
  i18n = {
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
