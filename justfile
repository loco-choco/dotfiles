set positional-arguments

host-name := shell('hostname')

update:
  @echo 'Updating Flake'
  nix flake update
  git commit -o flake.lock -m "Updated Lock File"

build system=host-name:
  @echo 'Building System {{system}}'
  sudo nixos-rebuild switch --flake .#{{system}}

clean:
  @echo 'Cleaning System'
  sudo nix-collect-garbage --delete-older-than 7d

format:
  @echo 'Formating Tree'
  nixfmt */*/*.nix
