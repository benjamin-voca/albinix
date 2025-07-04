!#/usr/bin/env bash
alias nix="nix --extra-experimental-features flakes --extra-experimental-features nix-command"
nix build .#nixosConfigurations.ci-host.config.system.build.toplevel

