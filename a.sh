!#/usr/bin/env bash
nix build .#nixosConfigurations.ci-host.config.system.build.toplevel

