# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
with pkgs;
let

  externalInterface = "ppp0";
  internalInterfaces = [
    #"br0"
    "enp2s0"
    "enp3s0"
    "enp4s0"
    #"enp3s0.9"
    #"enp3s0.12"
    #"enp3s0.40"
    #"wg0"
    #"tun0"
  ];
  ipxe' = pkgs.ipxe.overrideDerivation (drv: {
    installPhase = ''
      ${drv.installPhase}
      make $makeFlags bin-x86_64-efi/ipxe.efi bin-i386-efi/ipxe.efi
      cp -v bin-x86_64-efi/ipxe.efi $out/x86_64-ipxe.efi
      cp -v bin-i386-efi/ipxe.efi $out/i386-ipxe.efi
    '';
  });
  tftp_root = pkgs.runCommand "tftproot" {} ''
    mkdir -pv $out
    cp -vi ${ipxe'}/undionly.kpxe $out/undionly.kpxe
    cp -vi ${ipxe'}/x86_64-ipxe.efi $out/x86_64-ipxe.efi
    cp -vi ${ipxe'}/i386-ipxe.efi $out/i386-ipxe.efi
  '';
    secrets = import ../secrets.nix;

in {

  environment.systemPackages = with pkgs; [
    wget
    vim
    tmux
    git
    tcpdump
    dnsutils
    nixops
    openssl
  ];
  imports =
    [ # Include the results of the hardware scan.
    #./hardware-configuration.nix
        ../services/ppp.nix

      # ../lib/pci-passthrough.nix
    ../role/minimal.nix
    ../role/gui.nix
     # ../role/pythondev.nix
     # ../role/nodejsdev.nix
     # ../role/audio.nix
     # ../role/unfree.nix
     # ../role/graphic.nix
    ../role/vscode.nix
    ];
  nixpkgs.config = {
     allowUnfree = true; #for?: vscode
      # more stuff
    };
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.grub.device = "/dev/sdc"; 
  boot.kernel.sysctl = {
    "net.ipv6.conf.all.forwarding" = true;
    "net.ipv6.conf.enp1s0.accept_ra" = 2;
  };



  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking = {
    hostName = "proct";
    domain = "tkmy46.lan";
    # hostId = "fa4b7394";
    nameservers = [ 
      #"10.40.33.1"
      "8.8.8.8" ];
    vlans = {
      # lan_port = {
      #   interface = "enp2s0";
      #   id = 33;
      # };
      voip = {
        interface = "enp3s0";
        id = 40;
      };
    };
    bridges = {
      #br0.interfaces = [ "lan_port" "enp3s0" "enp4s0" ];
    };
    interfaces = {
      # ${externalInterface} = {
      #   useDHCP = true;
      # };
      enp1s0 = {
        useDHCP = false;
      };
      enp2s0 = {
        ipv4.addresses = [{
          address = "10.40.33.1";
          prefixLength = 24;
        }];
      };
      enp3s0 = {
        ipv4.addresses = [{
          address = "10.40.33.1";
          prefixLength = 24;
        }];
      };
      enp4s0 = {
        ipv4.addresses = [{
          address = "10.40.33.1";
          prefixLength = 24;
        }];
      };
      voip = {
         ipv4.addresses = [{
           address = "10.40.40.1";
           prefixLength = 24;
         }];
      };
    };
    nat = {
      enable = true;
      externalInterface = "ppp0";
      internalIPs = [ "10.40.33.0/24" ];
      internalInterfaces = [ "enp2s0" "enp3s0" "enp4s0"
      # "voip"  
        # "ovpn-guest" 
        # "br0"
        ];
      forwardPorts = [
        #{ sourcePort = 32400; destination = "10.40.33.20:32400"; proto = "tcp"; }
        #{ sourcePort = 1194; destination = "10.40.33.20:1194"; proto = "udp"; }
      ];
    };
    enableIPv6 = false;
    dhcpcd.persistent = true;
    dhcpcd.extraConfig = ''
      noipv6rs
      interface ${externalInterface}
      ia_na 1
      ia_pd 2/::/60 enp2s0/0/64 enp3s0/0/64 voip/1/64
    '';
  firewall = {
    enable = true;
    allowPing = true;
    trustedInterfaces = [ "enp4s0" "enp2s0" "enp3s0" ];
    checkReversePath = false; # https://github.com/NixOS/nixpkgs/issues/10101
    allowedTCPPorts = [
      22    # ssh
      80    # http
      443   # https
      2222  # git
    ];
    allowedUDPPorts = [ ];
  };

    # light fast VPN
    # wireguard.interfaces = {
    #   wg0 = {
    #     ips = [ "10.40.9.1/24" "fd00::1" ];
    #     listenPort = 51820;
    #     privateKeyFile = "/run/keys/wg0-private";
    #     peers = [
    #       {
    #         publicKey = "mFn9gVTlPTEa+ZplilmKiZ0pYqzzof75IaDiG9q/pko=";
    #         allowedIPs = [ "10.40.9.39/32" "10.39.0.0/24" "2601:98a:4000:9ed0::1/64" "fd00::39/128" ];
    #       }
    #       {
    #         publicKey = "b1mP5d9m041QyP0jbXicP145BOUYwNefUOOqo6XXwF8=";
    #         allowedIPs = [ "10.40.9.2/32" "fd00::2/128" ];
    #       }
    #       {
    #         publicKey = "dCKIaTC40Y5sQqbdsYw1adSgVDmV+1SZMV4DVx1ctSk=";
    #         allowedIPs = [ "10.38.0.0/24" "fd00::38/128" ];
    #       }
    #     ];

    #   };
    # };
  };

    services = {

    ppp = {
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


    #DNS Cache server
    unbound = {
      enable = true;
      interfaces = [ "0.0.0.0" "::" ];
      allowedAccess = [
        "127.0.0.0/8"
        "10.40.33.0/24"
        "10.39.0.0/24"
        "10.40.9.39/32"
        "192.168.11.0/16"
        "2601:98a:4101:bff0::/60"
        "2601:98a:4000:3900::/64"
      ];
      extraConfig = ''
        # server indent level
          logfile: "/home/lambdael/unbound.log"
          log-queries: no
          verbosity: 4
          do-not-query-localhost: no
          local-zone: "tkmy46.lan" nodefault
          domain-insecure: "tkmy46.lan"
        forward-zone:
          name: "tkmy46.lan"
          forward-addr: ::1@5353
#          forward-addr: 192.168.11.1
        stub-zone:
          name: "tkmy46.lan"
          stub-addr: 127.0.0.1@5353
      '';
    };

    #Name server
    nsd = {
      enable = true;
      interfaces = [ "127.0.0.1" "::1" ];
      port = 5353;
      remoteControl.enable = true;
      zones = {"tkmy46.lan.".data = ''
        @ IN SOA ns.tkmy46.lan. proct.tkmy46.lan. (
            2009082401 ; serial
            3600 ; refresh (1 hour)
            1200 ; retry (20 min.)
            1209600 ;                expire (2 weeks)
            900 ; minimum (15 min.)
        )
        N NS ns.tkmy46.lan.
        ns          IN A       10.40.33.1
        proct       IN A       10.40.33.1
        gtyun       IN A       10.40.33.94
        niney       IN A       10.40.33.95
        www         IN CNAME   niney
      '';

      # "33.40.10.in-addr.arpa".data = ''
      #   @ IN SOA ns.tkmy46.lan. proct.tkmy46.lan. (
      #     2015121201  ; serial number
      #     10800   ; Refresh
      #     3600    ; Retry
      #     604800  ; Expire
      #     86400   ; Min TTL
      #   )
      #   ; name servers
      #           IN      NS      ns.tkmy46.lan.
      #   ; PTRs
      #   1      IN      PTR     ns.tkmy46.lan.
      #   94      IN      PTR     gtyun.tkmy46.lan.
      #   95      IN      PTR     niney.tkmy46.lan.
      #         '';
               };
    };
    # asterisk = let
    #   package = (pkgs.callPackage ../asterisk { inherit iksemel;}).asterisk-stable;
    #   iksemel = pkgs.callPackage ../asterisk/iksemel.nix {};
    # in import ./asterisk.nix { asterisk = package; };

    # DARPA Trivial File Transfer Protocol(for pxe)    
    tftpd = {
      enable = true;
      path = tftp_root;
    };

    dhcpd4 = {
      interfaces = [
        # "br0" 
        "enp2s0" "enp3s0" "enp4s0" ];
      enable = true;
      machines = [
        { hostName = "gtyun"; ethernetAddress = "80:ee:73:cd:d3:7f"; ipAddress = "10.40.33.94"; }
        { hostName = "niney"; ethernetAddress = "00:1f:d0:a1:e5:cd"; ipAddress = "10.40.33.95"; }
      ];
      extraConfig = ''
        option arch code 93 = unsigned integer 16;
        option rpiboot code 43 = text;
        subnet 10.40.33.0 netmask 255.255.255.0 {
          option domain-search "tkmy46.lan";
          option subnet-mask 255.255.255.0;
          option broadcast-address 10.40.33.255;
          option routers 10.40.33.1;
          option domain-name-servers 10.40.33.1;
          range 10.40.33.100 10.40.33.200;
          next-server 10.40.33.1;
          if exists user-class and option user-class = "iPXE" {
            filename "http://netboot.tkmy46.lan/boot.php?mac=''${net0/mac}&asset=''${asset:uristring}&version=''${builtin/version}";
          } else {
            if option arch = 00:07 or option arch = 00:09 {
              filename = "x86_64-ipxe.efi";
            } else {
              filename = "undionly.kpxe";
            }
          }
          option rpiboot "Raspberry Pi Boot   ";
        }
      '';
    };
    radvd = { #Router Advertisement Daemon
      enable = false;
      config = ''
        interface br0
        {
           AdvSendAdvert on;
           prefix ::/64
           {
                AdvOnLink on;
                AdvAutonomous on;
           };
        };
        interface voip
        {
           AdvSendAdvert on;
           prefix ::/64
           {
                AdvOnLink on;
                AdvAutonomous on;
           };
        };
      '';
    };
    journald = {
      rateLimitBurst = 0;
      extraConfig = "SystemMaxUse=50M";
    };
    journalbeat = {
      enable = false;
      extraConfig = ''
      journalbeat:
        seek_position: cursor
        cursor_seek_fallback: tail
        write_cursor_state: true
        cursor_flush_period: 5s
        clean_field_names: true
        convert_to_numbers: false
        move_metadata_to_field: journal
        default_type: journal
      output.kafka:
        hosts: ["optina.tkmy46.lan:9092"]
        topic: KAFKA-LOGSTASH-ELASTICSEARCH
      '';
    };
    prometheus.exporters.node = {
      enable = true;
      enabledCollectors = [
        "systemd"
        "tcpstat"
        "conntrack"
        "diskstats"
        "entropy"
        "filefd"
        "filesystem"
        "loadavg"
        "meminfo"
        "netdev"
        "netstat"
        "stat"
        "time"
        "vmstat"
        "logind"
        "interrupts"
        "ksmd"
      ];
    };
    # openvpn = {
    #   servers = {
    #     wedlake = {
    #       config = ''
    #       dev tun
    #       proto udp
    #       port 1194
    #       tun-ipv6
    #       ca /var/lib/openvpn/ca.crt
    #       cert /var/lib/openvpn/crate.wedlake.lan.crt
    #       key /var/lib/openvpn/crate.wedlake.lan.key
    #       dh /var/lib/openvpn/dh2048.pem
    #       server 10.40.12.0 255.255.255.0
    #       server-ipv6 2601:98a:4101:bff2::/64
    #       push "route 10.40.33.0 255.255.255.0"
    #       push "route-ipv6 2000::/3"
    #       push "dhcp-option DNS 10.40.33.20"
    #       duplicate-cn
    #       keepalive 10 120
    #       tls-auth /var/lib/openvpn/ta.key 0
    #       comp-lzo
    #       user openvpn
    #       group root
    #       persist-key
    #       persist-tun
    #       status openvpn-status.log
    #       verb 3
    #       '';
    #     };
    #     guest = {
    #       config = ''
    #       dev ovpn-guest
    #       dev-type tun
    #       proto udp
    #       port 1195
    #       tun-ipv6
    #       ca /var/lib/openvpn/ca.crt
    #       cert /var/lib/openvpn/crate.wedlake.lan.crt
    #       key /var/lib/openvpn/crate.wedlake.lan.key
    #       dh /var/lib/openvpn/dh2048.pem
    #       server 10.40.13.0 255.255.255.0
    #       push "redirect-gateway def1"
    #       push "dhcp-option DNS 8.8.8.8"
    #       duplicate-cn
    #       keepalive 10 120
    #       tls-auth /var/lib/openvpn/ta-guest.key 0
    #       comp-lzo
    #       user openvpn
    #       group root
    #       persist-key
    #       persist-tun
    #       status openvpn-status.log
    #       verb 3
    #       '';
    #     };
    #   };
    # };
  };
  users.extraUsers.openvpn = {
    isNormalUser = true;
    uid = 1003;
  };
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget


}
