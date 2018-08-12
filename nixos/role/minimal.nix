{ config, pkgs, ... }:
{  
    # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  time.timeZone = "Asia/Tokyo";
  i18n = {
    consoleFont = "Lat2-Terminus32";
    consoleKeyMap = "jp106";
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      #enabled = "ibus";
      fcitx.engines = with pkgs.fcitx-engines; [
        anthy
      ];
      ibus.engines = with pkgs.ibus-engines; [ 
        anthy
      ];
    };
  };
  environment.systemPackages = with pkgs; [
    #wget
    vim
    nano
    sudo
    gitAndTools.gitFull
    nix-prefetch-git
    bash-completion
    tmux
    # gnupg
    # pass
    htop
    #ruby
    #xorg.xrdb
    ((pkgs.callPackage ../packages/nix-home/package.nix) { })
  ];
}
