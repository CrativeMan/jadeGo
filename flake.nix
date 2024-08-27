{
  description = "Basic Go development environment";

  inputs = {
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self
    , flake-utils
    , nixpkgs
    , ...
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.default = pkgs.buildGoModule rec {
        pname = "tasg";
        version = "1.0.2";

        src = ./.;

        vendorHash = "sha256-08I89i4/0yqtYLd7L6vM7UHZFgsA98LCEUOgAupB6+o=";
      };

      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          go
          gofumpt
          goimports-reviser
          golines
          delve
          cobra-cli
        ];
      };
    });
}

