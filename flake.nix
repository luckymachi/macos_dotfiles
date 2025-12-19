# SPDX-FileCopyrightText: 2023 Jade Lovelace
#
# SPDX-License-Identifier: CC0-1.0
{
  description = "Basic usage of flakey-profile";

  inputs = {
    flakey-profile.url = "github:lf-/flakey-profile";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    zjstatus = {
      url = "github:dj95/zjstatus";
    };
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , flakey-profile
    , zjstatus
    ,
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      # Any extra arguments to mkProfile are forwarded directly to pkgs.buildEnv.
      #
      # Usage:
      # Switch to this flake:
      #   nix run .#profile.switch
      # Revert a profile change (note: does not revert pins):
      #   nix run .#profile.rollback
      # Build, without switching:
      #   nix build .#profile
      # Pin nixpkgs in the flake registry and in NIX_PATH, so that
      # `nix run nixpkgs#hello` and `nix-shell -p hello --run hello` will
      # resolve to the same hello as below [should probably be run as root, see README caveats]:
      #   sudo nix run .#profile.pin
      packages.profile = flakey-profile.lib.mkProfile {
        inherit pkgs;
        # Specifies things to pin in the flake registry and in NIX_PATH.
        pinned = { nixpkgs = toString nixpkgs; };
        paths = with pkgs; [
          # System
          cmake
          pkg-config

          # TUI/CLI goodies
          neovim
          jujutsu
          git
          gh
          gh-dash
          fish
          zellij
          zjstatus
          yazi
          lazygit
          eza
          zoxide
          starship
          bat
          vhs
          charm-freeze
          pop
          ripgrep
          ripgrep-all
          tokei
          macchina
          bottom
          kalker
          onefetch
          fd
          procs
          rip2
          fzf
          difftastic
          atuin
          ast-grep
          dotenv-cli

          # Typst
          typst
          tinymist
          typstyle

          # Go
          go
          gopls
          gofumpt
          (lib.hiPrio gotools)

          # Python
          uv
          ruff
          ty

          # Rust
          rustup
          bacon

          # Webdev
          nodejs_24
          typescript
          xh
          biome
          vue-language-server
          pnpm

          # Virtualization & VMs
          docker
          docker-compose

          # Zig
          zig
          zls
          zigimports
          #zig-zlint

          # Lua
          lua
          stylua

          # Ruby
          ruby
          rubocop
          #bundler
          ruby-lsp

          # Database
          postgresql
          sqlite
          sqld

          # Extra
          protobuf

          # Nix
          devenv
          alejandra
          nixpkgs-fmt
          nixpkgs-lint
          nixpkgs-vet
          direnv
        ];
      };
    });
}
