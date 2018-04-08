#!/usr/bin/env sh


sudo cp -r ./nixos/ /etc/


sudo nixos-rebuild switch --show-trace


