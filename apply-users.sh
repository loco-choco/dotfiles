#!/bin/sh
pushd ~/.dotfiles
nix build .#homeConfigurations.locochoco.activationPackage
./result/activate
popd
