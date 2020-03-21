{ config, pkgs, ... }:
let  vscodeOverlay = self: super: {
    vscode-with-extensions = super.vscode-with-extensions.override {
      vscodeExtensions =
        super.vscode-utils.extensionsFromVscodeMarketplace [

          {
            name = "vscode-markdownlint";
            publisher = "DavidAnson";
            version = "0.20.0";
            sha256 = "0ayx785yixva8lak9iaxffcl6yndwf273kqxbpk3j6vxkyxy0594";
          }
          {
            name = "haskero";
            publisher = "Vans";
            version = "1.3.1";
            sha256 = "0j8cn6rb071h8vn7arhqgczvrdqgwprh541ps2q1z2mivk15y1gd";
          }
          {
            name = "Nix";
            publisher = "bbenoist";
            version = "1.0.1";
            sha256 = "0zd0n9f5z1f0ckzfjr38xw2zzmcxg1gjrava7yahg5cvdcw6l35b";
          }
          {
            name = "hoogle-vscode";
            publisher = "jcanero";
            version = "0.0.7";
            sha256 = "0ndapfrv3j82792hws7b3zki76m2s1bfh9dss1xjgcal1aqajka1";
          }
          {
            name = "svg";
            publisher = "jock";
            version = "0.1.2";
            sha256 = "1difxss6742aw1rk9nni28fj01364rpjvk8jxpwdmkz41z5xnh03";
          }
          {
            name = "language-haskell";
            publisher = "justusadam";
            version = "2.5.0";
            sha256 = "10jqj8qw5x6da9l8zhjbra3xcbrwb4cpwc3ygsy29mam5pd8g6b3";
          }
          {
            name = "python";
            publisher = "ms-python";
            version = "2018.8.0";
            sha256 = "1x1wkqbc0d6h5w2m5qczv6gd5j6yrzhwp0c6wk49bhg2l0ibvyx6";
          }
          {
            name = "color-highlight";
            publisher = "naumovs";
            version = "2.3.0";
            sha256 = "1syzf43ws343z911fnhrlbzbx70gdn930q67yqkf6g0mj8lf2za2";
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