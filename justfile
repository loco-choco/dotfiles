set positional-arguments

host-name := shell('hostname')

dry:
  @echo 'Dry testing config'
  nixos-rebuild --sudo dry-run --file system.nix --log-format internal-json -v |& nom --json

boot:
  @echo 'Adding new config as boot entry'
  nixos-rebuild --sudo boot --file system.nix --log-format internal-json -v |& nom --json

switch:
  @echo 'Switching System'
  nixos-rebuild --sudo switch --file system.nix --log-format internal-json -v |& nom --json

update:
  @echo 'Updating npins references'
  npins update
  jj commit -m "Updated Npins References {{datetime("%F")}}" npins/

clean:
  @echo 'Cleaning System'
  sudo nix-collect-garbage --log-format internal-json -v |& nom --json

format:
  @echo 'Formating Tree'
  nixfmt */*/*.nix
