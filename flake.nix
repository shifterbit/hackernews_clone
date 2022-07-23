{
  description = "Hacker News clone in Elixir";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    devShells.x86_64-linux.default = pkgs.callPackage ./shell.nix {};
    packages.x86_64-linux.default = pkgs.callPackage ./default.nix {};
  };
}
