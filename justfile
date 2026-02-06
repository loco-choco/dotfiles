set positional-arguments

host-name := shell('hostname')

build system=host-name:
  @echo 'Building System {{system}}'
  nh os switch --ask -H {{system}} .

update:
  @echo 'Updating lockfile'
  jj new
  nix flake update
  jj commit -m "Updated Lock File {{datetime("%F")}}"

clean:
  @echo 'Cleaning System'
  nh clean all --ask

format:
  @echo 'Formating Tree'
  nixfmt */*/*.nix
