{
  description = "wgscribe — Windscribe WireGuard client in POSIX shell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      eachSystem = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
      ];
    in {
      packages = eachSystem (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          wgscribe = pkgs.callPackage ./package.nix { };
          default = self.packages.${system}.wgscribe;
        });

      overlays.default = final: prev: {
        wgscribe = self.packages.${prev.stdenv.hostPlatform.system}.wgscribe;
      };
    };
}
