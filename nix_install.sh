#!/bin/bash

set -xe

sudo mkdir -p /nix
sudo chown $USER /nix

sudo mkdir -p /etc/nix
if [ ! -e /etc/nix/nix.conf ]; then
    sudo bash  -c 'echo "build-users-group =" > /etc/nix/nix.conf'
fi

bash <(curl -s https://nixos.org/nix/install)
source ~/.nix-profile/etc/profile.d/nix.sh

for file in .zshrc .bashrc ; do if [ -e "~/$file" ]; then
    echo 'source ~/.nix-profile/etc/profile.d/nix.sh' >> "$file"
fi;

CURL_CA_BUNDLE=$(find /nix -name ca-bundle.crt |tail -n 1) nix-channel --update
