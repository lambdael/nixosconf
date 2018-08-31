{ config, pkgs, ... }:
{  
  environment.systemPackages = with pkgs; [
    wget
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
    ranger
    w3m
    #ruby
    #xorg.xrdb
    # ((pkgs.callPackage ../packages/hie/package.nix) { })
    # ((pkgs.callPackage ../packages/nix-home/package.nix) { })
  ];
}
