{
  # niney =
  #   { config, pkgs, ... }:
  #   { deployment.targetHost = "192.168.2.3";
  #   };
  #   {
  niney =
    { config, pkgs, ... }:
    { deployment.targetEnv = "virtualbox";
      deployment.virtualbox.memorySize = 1024; # megabytes
      deployment.virtualbox.vcpu = 2; # number of cpus
    };

}