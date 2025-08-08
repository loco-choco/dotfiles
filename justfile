set positional-arguments

update:
  @echo 'Updating Flake'
  nix flake update
  git commit -o flake.lock -m "Updated Lock File"

build system:
  @echo 'Building System {{system}}'
  sudo nixos-rebuild switch --flake .#{{system}}

clean:
  @echo 'Cleaning System'
  sudo nix-collect-garbage --delete-older-than 7d

format:
  @echo 'Formating Tree'
  nixfmt */*/*.nix
