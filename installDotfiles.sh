#!/bin/bash

echo "Install my packages"

while read item; do sudo xbps-install -y $item; done < "installed_packages"

echo "Enable used services"

sudo ln -s /etc/sv/NetworkManager /etc/runit/runsvdir/default
sudo ln -s /etc/sv/tlp /etc/runit/runsvdir/default
sudo ln -s /etc/sv/cronie /etc/runit/runsvdir/default
sudo ln -s /etc/sv/elogind /etc/runit/runsvdir/default
sudo ln -s /etc/sv/nginx /etc/runit/runsvdir/default
sudo ln -s /etc/sv/chronyd /etc/runit/runsvdir/default
sudo ln -s /etc/sv/bluetoothd /etc/runit/runsvdir/default
sudo ln -s /etc/sv/udevd /etc/runit/runsvdir/default
sudo ln -s /etc/sv/dbus /etc/runit/runsvdir/default
sudo ln -s /etc/sv/cupsd /etc/runit/runsvdir/default

echo "Copy .config dotfiles"

cp -r alacritty ~/.config/
cp -r bspwm ~/.config/
cp -r dunst ~/.config/
cp -r polybar ~/.config/
cp -r rofi ~/.config/
cp -r sxhkd ~/.config/
cp -r picom.conf ~/.config/

echo "Install nvchad package"
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
nvim +'hi NormalFloat guibg=#1e222a' +PackerSync

echo "Copy nvim config files"
cp -r nvim-lua-custom/custom ~/.config/nvim/lua/

echo "Copy local scripts"

mkdir ~/.local/bin
cp -r local-bin/bin/* ~/.local/bin/
chmod +x ~/.local/bin/*

echo "Prepare .install directory and install packages from it"
mkdir ~/.install
git clone https://github.com/void-linux/void-packages.git ~/.install/void-packages
cd ~/.install/void-packages && ./xbps-src binary-bootstrap

echo "Install rofi-pass"
cd ~
git clone https://github.com/carnager/rofi-pass.git ~/.install/rofi-pass

echo "Install Nerd-Fonts"
git clone --depth=1 https://github.com/ryanoasis/nerd-fonts.git ~/.install/nerd-fonts
/home/$USER/.install/nerd-fonts/install.sh

echo "Install mutt-wizard"
git clone https://github.com/LukeSmithxyz/mutt-wizard ~/.install/mutt-wizard
cd ~/.install/mutt-wizard && sudo make install

echo "Basic setup done!"
