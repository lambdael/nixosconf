{ config, pkgs, ... }:

{

  nixpkgs.config = {
      allowUnfree = true;
      # more stuff
    };
  environment.systemPackages = with pkgs; [
    vscode
    
  ];
  services = {
    xserver = {
      videoDrivers = [ "nvidia" ];
    };
  };
}