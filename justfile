set positional-arguments

host-name := shell('hostname')

dry:
  @echo 'Dry testing config'
  nixos-rebuild --sudo dry-run --file system.nix --attr {{host-name}}

boot:
  @echo 'Adding new config as boot entry'
  nixos-rebuild --sudo boot --file system.nix --attr {{host-name}}

switch:
  @echo 'Switching System'
  nixos-rebuild --sudo switch --file system.nix --attr {{host-name}}

update:
  @echo 'Updating npins references'
  npins update
  jj commit -m "Updated Npins References {{datetime("%F")}}" npins/

clean:
  @echo 'Cleaning System'
  sudo nix-collect-garbage

format:
  @echo 'Formating Tree'
  nixfmt */*/*.nix
