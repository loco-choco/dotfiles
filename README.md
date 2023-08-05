### How I made this

https://www.youtube.com/watch?v=Dy3KHMuDNS8 -> To turn my original config into a repository config
https://www.youtube.com/watch?v=mJbQ--iBc1U -> To turn my config into a flake config

Wil T my beloved

### How to use it

Once cloned run:

- To update the lock file: `nix flake update`
- To apply the system config: `sudo nixos-rebuild switch --flake .#MACHINE-NAME`
    - The machine names can be:
        - locopc
        - locotop
- To apply the users config: `nix build .#homeConfigurations.USER.activationPackage`
    - The users can be:
        - locochoco (needs to be run with the flag "impure" and the variables "NIXPKGS_ALLOW_INSECURE=1 NIXPKGS_ALLOW_UNFREE=1")

I recommend creating script files for all of these commands.
