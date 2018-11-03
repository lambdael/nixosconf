# nixosconf
- nixos 

  https://nixos.org/nixos/manual/
  
  - package
  
    https://nixos.org/nixos/packages.html

  - options
  
    https://nixos.org/nixos/options.html#




about partition
https://wiki.archlinux.org/index.php/EFI_System_Partition


```bash

lsblk -f

fdisk /dev/sdc



mkfs.ext4 -L nixos /dev/sdc3
mkfs.ext4 -L data /dev/sdc4
mkswap -L swap /dev/sdc2
mkfs.fat -F 32 -n EFIBOOT /dev/sdc1
mount /dev/sdc3 /mnt
mkdir /mnt/boot
mount /dev/sdc1 /mnt/boot
mkdir /mnt/data
mount /dev/sdc4 /mnt/data
swapon /dev/sdc2
nixos-generate-config --root /mnt
nano /mnt/etc/nixos/configuration.nix
nixos-install
passwd user
reboot


nix-env -iA nixos.git
git clone https://github.com/lambdael/nixosconf.git
cp -r ./nixos/ /mnt/etc/
```
