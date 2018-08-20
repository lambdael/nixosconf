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
    #ruby
    #xorg.xrdb
    ((pkgs.callPackage ../packages/nix-home/package.nix) { })
  ];
}
