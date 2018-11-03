{
  # niney =
  #   { config, pkgs, ... }:
  #   { 
  #     deployment.targetHost = "192.168.2.3";
  #   };
  gtyun =
    { config, pkgs, ... }:
    { 
      deployment.targetHost = "192.168.11.5";
        imports =
      [ # Include the results of the hardware scan.
        ./hwconfs/gtyun/hardware-configuration.nix
      ];
      boot.loader.grub.enable = false;
    };
    
  # niney =
  #   { config, pkgs, ... }:
  #   { deployment.targetEnv = "virtualbox";
  #     deployment.virtualbox.memorySize = 1024; # megabytes
  #     deployment.virtualbox.vcpu = 2; # number of cpus
  #   };

}