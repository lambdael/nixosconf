{
  network.description = "Web server";

  niney =
    { config, pkgs, ... }:
    { services.httpd.enable = true;
      services.httpd.adminAddr = "alice@example.org";
      services.httpd.documentRoot = "${pkgs.valgrind.doc}/share/doc/valgrind/html";
      networking.firewall.allowedTCPPorts = [ 80 ];
    };
  gtyun =
    { config, pkgs, ... }:
  with pkgs;
 {
  imports =
    [ # Include the results of the hardware scan.
      # ./hardware-configuration.nix
      ./machines/common.nix
      ./machines/gtyun.nix
      ./users/users.nix
      # ./machines/gtyun.nix
      # ./machines/niney.nix
    ];
 };
}
