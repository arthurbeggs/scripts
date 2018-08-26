#!/bin/sh

loadkeys br-abnt2
timedatectl set-ntp true

# fdisk -l
# mkfs.ext4 /dev/sd??
# mount /dev/sd??

# Remover

curl -s "https://www.archlinux.org/mirrorlist/?country=BR&protocol=http&protocol=https&ip_version=4&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' > /etc/pacman.d/mirrorlist

pacstrap /mnt base base-devel vim neovim zsh grub

genfstab -U /mnt >> /mnt/etc/fstab

ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen
echo 'pt_BR.UTF-8 UTF-8' >> /etc/locale.gen
locale-gen
echo 'LANG=pt_BR.UTF-8' > /etc/locale.conf
echo 'KEYMAP=br-abnt2' > /etc/vconsole.conf

#...

