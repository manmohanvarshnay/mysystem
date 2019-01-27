#!/bin/bash

sudo setenforce 0
sudo systemctl stop firewalld
sudo yum -y update
sudo yum -y install zip unzip wget
sudo yum groupinstall "GNOME Desktop" -y
sudo yum groupinstall "Development Tools" -y
sudo systemctl set-default graphical.target
sudo systemctl start sshd
sudo systemctl enable sshd

######################################################  SET DEFAULT KERNEL   #######################################################################
sudo yum -y install kernel-devel-$(uname -r)
sudo awk -F\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2.cfg
sudo grub2 set-default 0
sudo grub2-mkconfig
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
########################################################  INSTALLATION OF VIRTUALBOX  ###############################################################
sudo wget https://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo -P /etc/yum.repos.d
sudo yum -y update
sudo yum -y install binutils qt gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms
sudo yum -y install VirtualBox-5.6
#######################################################  INSTALL ANY DESK  ##########################################################################
sudo wget https://download.anydesk.com/linux/rhel7/anydesk-2.9.5-1.el7.x86_64.rpm
sudo yum localinstall anydesk-2.9.5-1.el7.x86_64.rpm -y
#######################################################  INSTALL VISUAL STUDIO CODE ################################################################
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo touch /etc/yum.repos.d/vscode.repo
echo [code] >> /etc/yum.repos.d/vscode.repo
echo name=Visual Studio Code >> /etc/yum.repos.d/vscode.repo
echo baseurl=https://packages.microsoft.com/yumrepos/vscode >> /etc/yum.repos.d/vscode.repo
echo enabled=1 >> /etc/yum.repos.d/vscode.repo
echo gpgcheck=1 >> /etc/yum.repos.d/vscode.repo
echo gpgkey=https://packages.microsoft.com/keys/microsoft.asc >> /etc/yum.repos.d/vscode.repo
sudo yum repolist
sudo updatdb
sudo yum install code -y
sudo systemctl start firewalld
######################################################  CLEAN THE CACHE AND SWAP MEMORY  ###########################################################
sync; echo 3 > /proc/sys/vm/drop_caches
swapoff -a && swapon -a
###################################################### SWITCH TO GUI MODE  ##########################################################################
sudo systemctl isolate graphical.target
###################################################### END OF FILE  #################################################################################
