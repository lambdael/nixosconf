# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
with pkgs;
let
myHaskellEnv = pkgs.haskell.packages.ghc822.ghcWithPackages
                     (haskellPackages: with haskellPackages; [
                       # libraries
                       #arrows async cgi criterion
                       # tools
                       #cabal-install haskintex
                        apply-refact #(required by hlint-refactor)
                        hlint #(required by hlint-refactor)
                        stylish-haskell #(optional for haskell-mode)
                        hasktags #(optional)
                        hoogle #(optional for haskell-mode and helm-hoogle)
                        #ghc-mod #(optional for completion)

                        intero #(optional for completion)
                        cabal-install

                        xmonad
                        

                     ]);

in {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    myHaskellEnv
    stack 
    
    gnumake
    gcc


  ];

}
