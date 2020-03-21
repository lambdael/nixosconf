{ config, pkgs, ... }:
{  
  environment.systemPackages = with pkgs; [
    wget
    vim
    
    cryptsetup
    gitAndTools.gitFull
    nix-prefetch-git
    sudo
    
    bash-completion
    haskellPackages.vgrep
    tmux
    # gnupg
    # pass
    htop 
    ranger
    w3m
    screenfetch
    # haskellPackages.illuminate #syntax highlight
    powerline-go
    powerline-fonts
    
    python36Packages.powerline
    sourceHighlight
    highlight
    nixops
    openssl
    iptraf-ng
    tcpdump
    dnsutils # nslookup

    tcptrack
    #ruby
    #xorg.xrdb
    # ((pkgs.callPackage ../packages/hie/package.nix) { })
    # ((pkgs.callPackage ../packages/nix-home/package.nix) { })
  ];
  
    # List services that you want to enable:
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  # Enable the OpenSSH daemon.
  services = {
    openssh = {
      enable = true;
      permitRootLogin = "yes"; # for nixops
      passwordAuthentication = false;
    };
  };
   
  programs.bash.enableCompletion = true;
  programs.nano.syntaxHighlight = true;
}
