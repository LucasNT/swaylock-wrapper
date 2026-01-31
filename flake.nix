{
  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11"; };

  outputs = { self, nixpkgs }:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      packages.x86_64-linux.swaylock-wrapper = pkgs.writeShellApplication {
        name = "swaylock-wrapper";
        runtimeInputs = [ pkgs.swaylock pkgs.util-linux ];
        text = ./lock.sh;
      };
      packages.x86_64-linux.default =
        self.packages.x86_64-linux.swaylock-wrapper;
    };
}
