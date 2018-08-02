{ config, pkgs, ... }:
let  vscodeOverlay = self: super: {
    vscode-with-extensions = super.vscode-with-extensions.override {
      vscodeExtensions =
        super.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "vscode-hie-server";
            publisher = "alanz";
            version = "0.0.19";
            sha256 = "0x0cs7c5q90p1ffig2wb5v21z3yj3p2chgpvbnlm4gfsnw7qpfzr";
          }
        ] ++ [
          super.vscode-extensions.bbenoist.Nix
        ];
    };
  };
in
{

  nixpkgs.overlays = [ vscodeOverlay ]; 

  environment.systemPackages = with pkgs; [
    vscode
    
  ];

}