{ config, pkgs, ... }:

{
  imports =  [
    ../lib/cursor.nix
  ];

  environment.systemPackages = with pkgs; [
    lxappearance
    paper-gtk-theme
    paper-icon-theme
    lxqt.lxqt-config
    kde-gtk-config
    fontconfig-ultimate
    # gnome3.adwaita-icon-theme
    taffybar

    spaceFM # file manager

    feh # image viewer
    # rxvt_unicode # terminal
    termite # terminal
    # atom #editor
    # firefox #browser
    haskellPackages.xmobar #for xmonad
    scrot #screen shot?
    lxqt.pcmanfm-qt #file manager
    # supercollider_scel
    chromium
    font-awesome_5
  	# nodejs-9_x
    # electron
  ];

  # environment.shellInit = ''
  #     export GTK_PATH=$GTK_PATH:${pkgs.paper-gtk-theme}/Paper/gtk-2.0
  #     export GTK2_RC_FILES=$GTK2_RC_FILES:${pkgs.paper-gtk-theme}/Paper/gtk-2.0/gtkrc
  #     # export GTK_IM_MODULE=fcitx
  #     # export QT_IM_MODULE=fcitx
  #     # export XMODIFIERS=@im=fcitx

  #   '';
environment.sessionVariables = {
    # XCURSOR_PATH = [
    #   "${config.system.path}/share/icons"
    #   "$HOME/.icons"
    #   "$HOME/.nix-profile/share/icons/"
    # ];
    GTK_DATA_PREFIX = [
      "${config.system.path}"
    ];
};
  fonts = {
    fonts = with pkgs; [
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
      source-code-pro
      hasklig
      font-awesome_4

    ];
  };
  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      windowManager = {
        xmonad.enable = true;
        xmonad.enableContribAndExtras = true;
        default = "xmonad";
      };


      desktopManager.default = "none";
      desktopManager.xterm.enable = false;
      desktopManager.plasma5.enable = false;
      desktopManager.gnome3.enable = false;
      displayManager.lightdm.enable = true;
      # displayManager.lightdm.greeter.package = 
        #theme = ./slim-theme;

    };
  };

  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;



}
