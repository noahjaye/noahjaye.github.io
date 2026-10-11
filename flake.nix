{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
  };

  outputs = inputs:
    let
      forAll = f: builtins.mapAttrs f inputs.nixpkgs.legacyPackages;
    in {
    packages = forAll (system: pkgs: {
      hello = pkgs.hello;
      hugo  = pkgs.hugo;
      default = inputs.self.packages.${system}.hugo;
    });

    devShells = forAll (system: pkgs: {
      default = pkgs.mkShell { packages = [ pkgs.hugo ]; };
    });
  };
}
