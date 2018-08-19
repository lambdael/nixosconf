{ config, pkgs, ... }:

let
  secrets = import ../secrets.nix;
in
{
  imports =  [
    ../services/ppp.nix
  ];
  
  networking.domain = "uraba.yashiro";
  networking.nameservers = ["127.0.0.1" "8.8.8.8" ];

  networking.firewall = {
    enable = true;
    allowPing = true;
    trustedInterfaces = [ "enp2s0" "enp3s0" "enp4s0" ];
    checkReversePath = false; # https://github.com/NixOS/nixpkgs/issues/10101
    allowedTCPPorts = [
      #22    # ssh
      #80    # http
      #443   # https
      #2222  # git
    ];
    allowedUDPPorts = [ ];
  };

  networking.nat = {
    enable = true;
    internalIPs = [ "192.168.1.0/24" "192.168.2.0/24" "192.168.3.0/24" ];
    externalInterface = "ppp0";
#    externalInterface = "enp1s0";
  };

   networking = {
      vlans.lan_port = {
        interface = "enp2s0";
        id = 33;
      };
    
      bridges = {
        br0.interfaces = [ "lan_port" "enp3s0" "enp4s0" ];
      };
   };

  networking.interfaces = {
    enp1s0 = {
      useDHCP = false;
    };
    br0 = {
        ipv4.addresses = [{
          address = "192.168.1.1";
          prefixLength = 24;
        }];

    };

    # enp3s0 = {
    #     ipv4.addresses = [{
    #       address = "192.168.2.1";
    #       prefixLength = 24;
    #     }];
    # };
    # enp4s0 = {
    #     ipv4.addresses = [{
    #       address = "192.168.3.1";
    #       prefixLength = 24;
    #     }];
    # };
  };

  # services.hostapd = {
  #   enable = true;
  #   interface = "wlp4s0";
  #   ssid = secrets.hostapd.ssid;
  #   wpaPassphrase = secrets.hostapd.wpaPassphrase;
  #   hwMode = "g";
  #   channel = 10;
  # };
  networking.networkmanager.dynamicHosts.enable = true;
  networking.networkmanager.useDnsmasq = true;
  networking.networkmanager.dynamicHosts.hostsDirs = [/home/lambeael/hosts];
  services.dnsmasq = {
    enable = true;
    resolveLocalQueries = true;
    servers = [ "210.130.0.1"  "8.8.8.8"  ];
    alwaysKeepRunning = false;
    extraConfig = ''
      # domain-needed
      # bogus-priv
      # expand-hosts
      # domain=uraba.yashiro
      # local=/uraba.yashiro/
      interface=enp2s0
      interface=enp3s0
      interface=enp4s0
      bind-interfaces
      dhcp-range=192.168.1.10,192.168.1.254,8m
      dhcp-range=192.168.2.10,192.168.2.254,8m
      dhcp-range=192.168.3.10,192.168.3.254,8m
      # dhcp-host=80:ee:73:cd:d3:7f,192.168.1.5
    '';
  };

  services.ppp = {
    enable = true;
    config.pppoe = {
      interface = "enp1s0";
      username = secrets.pppoe.username;
      password = secrets.pppoe.password;
      pppoe = true;
      extraOptions = ''
        noauth
        defaultroute
        persist
        maxfail 0
        holdoff 5
        lcp-echo-interval 15
        lcp-echo-failure 3
      '';
    };
  };

  # services.miniupnpd = {
  #   enable = false;
  #   externalInterface = "ppp0";
  #   natpmp = true;
  #   internalIPs = [ "wlp4s0" ];
  # };
}
