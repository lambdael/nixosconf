# nixosconf


about partition
https://wiki.archlinux.org/index.php/EFI_System_Partition


    # fdisk /dev/sdc
    # mkfs.ext4 -L nixos /dev/sdc3
    # mkfs.ext4 -L home /dev/sdc4
    # mkswap -L swap /dev/sdc2
    # mkfs.fat -F 32 -n EFIBOOT /dev/sdc1
    # mount /dev/sdc3 /mnt
    # mkdir /mnt/boot
    # mount /dev/sdc1 /mnt/boot
    # mkdir /mnt/home
    # mount /dev/sdc4 /mnt/home
    # swapon /dev/sda2
    # nixos-generate-config --root /mnt
    # nano /mnt/etc/nixos/configuration.nix
    # nixos-install
    # passwd user
    # reboot

nix-env -iA nixos.git
git clone https://github.com/lambdael/nixosconf.git
cp -r ./nixos/ /mnt/etc/
