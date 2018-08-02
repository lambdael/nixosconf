# put this file in /etc/nixos/
# and add 
#   ./pci-passthrough.nix
# to /etc/nixos/configuration.nix in `imports`

{config, pkgs, lib, ... }:

with lib;
let
  cfg = config.pciPassthrough;
in
{
  ###### interface
  options.pciPassthrough = {
    enable = mkEnableOption "PCI Passthrough";

    cpuType = mkOption {
      description = "One of `intel` or `amd`";
      default = "intel";
      type = types.str;
    };

    pciIDs = mkOption {
      description = "Comma-separated list of PCI IDs to pass-through";
      type = types.str;
    };

    libvirtUsers = mkOption {
      description = "Extra users to add to libvirtd (root is already included)";
      type = types.listOf types.str;
      default = [];
    };
  };

  ###### implementation
  config = (mkIf cfg.enable {

    boot.kernelParams = [ "${cfg.cpuType}_iommu=on" ];

    # These modules are required for PCI passthrough, and must come before early modesetting stuff
    boot.kernelModules = [ "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" ];

    boot.extraModprobeConfig ="options vfio-pci ids=${cfg.pciIDs}";

    environment.systemPackages = with pkgs; [
      virtmanager
      qemu
      OVMF
      pciutils
    ];

    virtualisation.libvirtd.enable = true;
    virtualisation.libvirtd.qemuPackage = pkgs.qemu_kvm;

    users.groups.libvirtd.members = [ "root" ] ++ cfg.libvirtUsers;

    virtualisation.libvirtd.qemuVerbatimConfig = ''
      nvram = [
      "${pkgs.OVMF}/FV/OVMF.fd:${pkgs.OVMF}/FV/OVMF_VARS.fd"
      ]
    '';
  });

}