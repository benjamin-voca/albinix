nix --extra-experimental-features flakes --extra-experimental-features nix-command build .#nixosConfigurations.ci-host.config.system.build.toplevel

