## Enable wifi in minimal installer
sudo systemctl start wpa_supplicant
wpa_cli
add_network
set_network 0 ssid "MY_SSID"
set_network 0 psk "PASSWORD"
set_network 0 key_mgmt WPA-PSK
enable_network 0

## Partitioning
# Find your disk and open it wth fdisk
lsblk
sudo fdisk /dev/DISK

# Delete existing partitions using 'd' option
# Create GPT disk label
g
n
1
2048 (default)
+500M
t
1 (EFI System)
n
2
1026048 (default)
<enter> (default)
w

# Check your block devices
lsblk

# Format and label partitions
sudo mkfs.fat -F 32 /dev/DISK1
sudo fatlabel /dev/DISK1 NIXBOOT
sudo mkfs.ext4 /dev/DISK2 -L NIXROOT

# Mount disks
sudo mount /dev/disk/by-label/NIXROOT /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/disk/by-label/NIXBOOT /mnt/boot

# Set up swap
sudo dd if=/dev/zero of=/mnt/.swapfile bs=1G count=24 (use 1.5x RAM, check with 'free -h')
sudo chmod 600 /mnt/.swapfile
sudo mkswap /mnt/.swapfile
sudo swpon /mnt/.swapfile

## Setup config
sudo nixos-generate-config --root /mnt
cd /mnt
sudo vim etc/nixos/configuration.nix
sudo nixos-install

# Set user password
sudo passwd <user>




## Fresh install
Boot from ISO
Mount disks
sudo su
nix-env -iA nixos.git
git clone <repo-url> /mnt/<path>
nixos-install --flake ~/mnt/<path>#<hostname>
reboot
sudo rm /etc/nixos/configuration.nix
