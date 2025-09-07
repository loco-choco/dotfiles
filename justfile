set positional-arguments

host-name := shell('hostname')

build system=host-name:
  @echo 'Building System {{system}}'
  nh os switch -u --ask -H {{system}} .

clean:
  @echo 'Cleaning System'
  nh clean --ask

format:
  @echo 'Formating Tree'
  nixfmt */*/*.nix
