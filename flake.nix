{
  description = "Projective Strawrage packaging";
  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    bundix.url = "github:bigzed/bundix/sagittaros/main";
    ruby-nix.url = "github:sagittaros/ruby-nix";
    projective-pkgs.url = "git+https://gitlab.office.flavoursys.com/steve.dierker/nixpkgs.git";
  };
  outputs = { self, nixpkgs, flake-utils, bundix, ruby-nix, projective-pkgs }:
    flake-utils.lib.eachDefaultSystem
    (system:
      let
        nix-pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        };

        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
          overlays = [
            ruby-nix.overlays.ruby
            projective-pkgs.overlays.${system}.gemConfig
            projective-pkgs.overlays.${system}.ruby
            bundix.overlays.${system}.bundix
          ];
        };

        rubyNix = ruby-nix.lib pkgs;
        gemset = import ./gemset.nix;

        inherit (rubyNix {
          name = "fsle";
          gemset = gemset;
          ruby = pkgs.ruby;
          gemConfig = pkgs.defaultGemConfig;
        })
        env ruby;
      in rec {
        devShells = rec {
          default = dev;
          dev = pkgs.mkShell {
            # NOTE ordering is important here, the head in $PATH always take precedence
            buildInputs = [ ruby env ] ++ (with pkgs; [
              bundix_bigzed libarchive pkg-config
            ]);
            PKG_CONFIG_PATH = [ "${pkgs.libarchive}/lib/pkgconfig" ];
          };
        };
      }
    );
}
