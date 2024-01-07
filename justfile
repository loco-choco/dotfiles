set positional-arguments

update:
  @echo 'Updating Flake'
  nix update

all system user:
  @echo 'Building Whole System {{system}} With User {{user}}'
  just system {{system}}
  just user {{user}}

system system:
  @echo 'Building System {{system}}'
  sudo nixos-rebuild switch --flake .#{{system}}

user user:
  @echo 'Building User {{user}}'
  nix build .#homeConfigurations.{{user}}.activationPackage
  @echo 'Activating User'
  @sh ./result/activate

clean:
  @echo 'Cleaning System'
  sudo nix-collect-garbage -d
  nix-collect-garbage -d
