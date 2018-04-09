{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lxappearance
    adapta-gtk-theme
    lxqt.lxqt-config
    kde-gtk-config

    rxvt_unicode # terminal
    atom #editor
    firefox #browser
    haskellPackages.xmobar #for xmonad
    scrot #screen shot?
    lxqt.pcmanfm-qt #file manager
    supercollider_scel
    chromium
  	nodejs-9_x
    electron
  ];

  environment.shellInit = ''
      export GTK_PATH=$GTK_PATH:${pkgs.adapta-gtk-theme}/lib/gtk-2.0
      export GTK2_RC_FILES=$GTK2_RC_FILES:${pkgs.adapta-gtk-theme}/share/themes/oxygen-gtk/gtk-2.0/gtkrc
    '';
  fonts.fonts = with pkgs; [
    ipafont
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts
    dina-font
    proggyfonts
    anonymousPro
  ];

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      layout = "jp";
      windowManager = {
        xmonad.enable = true;
        xmonad.enableContribAndExtras = true;
        default = "xmonad";
      };
      videoDrivers = [ "mesa" ];


      desktopManager.default = "none";
      desktopManager.xterm.enable = false;
      displayManager.lightdm.enable = true;

        #theme = ./slim-theme;

    };
  };

  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;


}
