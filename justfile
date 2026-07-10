set positional-arguments

host-name := shell('hostname')

switch:
  @echo 'Switching System'
  nh os switch -a -f system.nix

dry:
  @echo 'Dry testing config'
  nh os switch -n -f system.nix

update:
  @echo 'Updating npins references'
  npins update
  jj commit -m "Updated Npins References {{datetime("%F")}}" npins/

clean:
  @echo 'Cleaning System'
  nh clean all --ask

format:
  @echo 'Formating Tree'
  nixfmt */*/*.nix
