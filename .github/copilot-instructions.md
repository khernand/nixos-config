This project defines a NixOS configuration for a home desktop.
It uses home-manager to manage user-specific configurations.

# Command line
* Updating the project: `sudo nix flake update && sudo nixos-rebuild switch --flake .#nix-desktop`
* Updating home-manager: `home-manager switch --flake .#khernand@nix-desktop`

# Structure
* `flake.nix`: Nix flake definition.
* `configuration.nix`: NixOS system configuration.
* `home/khernand/nix-desktop/default.nix`: home-manager configuration.
* `hosts/nix-desktop.nix`: Base configuration for the desktop where everything is imported.
* `helpers/`: Helper scripts for importing all nix files in a directory.

# Notes
We use the importAll helper to make it easier to manage configurations by splitting them into multiple files.

For example: we import all possible programs we may want to enable in `programs/` and then we enable only the ones we want in `home/khernand/nix-desktop/default.nix`.

Each file will have an option like this:
```nix
  options = {
    my.system.services.audio.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Audio";
    };
  };
```
Which then allows us to import it in `home/khernand/nix-desktop/default.nix` with:

```nix
my.system.services.audio.enable = true;
```

## Structure

* `modules/nixos/`: NixOS specific configurations.
* `modules/nixos/common`: configurations common to all NixOS hosts and automatically imported.
* `modules/nixos/desktop`: configurations for the desktop environment.
* `modules/nixos/programs`: configurations for system programs.
* `modules/nixos/services`: configurations for system services.
* `modules/home-manager/`: home-manager specific configurations.
* `modules/home-manager/common`: configurations common to all users and automatically imported.
* `modules/home-manager/programs`: configurations for user programs.
* `modules/home-manager/services`: configurations for user services.