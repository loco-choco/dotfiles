set positional-arguments

host-name := shell('hostname')

build system=host-name:
  @echo 'Building System {{system}}'
  nh os switch -u --ask -H {{system}} .
  git commit -o flake.lock -m "Updated Lock File {{datetime("%F")}}"

clean:
  @echo 'Cleaning System'
  nh clean all --ask

format:
  @echo 'Formating Tree'
  nixfmt */*/*.nix
