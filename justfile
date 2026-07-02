set positional-arguments

host-name := shell('hostname')

apply:
  @echo 'Applying System'
  colmena apply-local --sudo

deploy-systems:
  @echo 'Deploying all systems'
  colmena apply

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
