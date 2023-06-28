#!/bin/sh
pushd ~/.dotfiles
NIXPKGS_ALLOW_INSECURE=1 NIXPKGS_ALLOW_UNFREE=1 nix build .#homeConfigurations.locochoco.activationPackage --impure
./result/activate
popd
