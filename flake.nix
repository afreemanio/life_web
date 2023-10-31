{
	# Provides the requirements for the 'macroquad' crate as a nix flake.
	# To activate:
	# `nix develop`
  description = "Life simulation written in rust";


  # Flake inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs"; # also valid: "nixpkgs"
  };

  # Flake outputs
  outputs = {
    self,
    nixpkgs,
  }: let
    # Systems supported
    allSystems = [
      "x86_64-linux" # 64-bit Intel/AMD Linux
      "aarch64-linux" # 64-bit ARM Linux
      "x86_64-darwin" # 64-bit Intel macOS
      "aarch64-darwin" # 64-bit ARM macOS
    ];

    # Helper to provide system-specific attributes
    forAllSystems = f:
      nixpkgs.lib.genAttrs allSystems (system:
        f {
          pkgs = import nixpkgs {inherit system;};
        });
  in {
    # Development environment output
    devShells = forAllSystems ({pkgs}: {
      default = let
      in
        pkgs.mkShell {
					buildInputs = [
            pkgs.alsaLib
						pkgs.libGL
						pkgs.xorg.libX11
						pkgs.xorg.libXi
          ];

        };
    });
  };
}
