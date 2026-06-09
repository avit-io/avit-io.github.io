{
  description = "avit-io.github.io";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2511.912939";
    piforge = {
      url   = "github:avit-io/piforge";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, piforge }:
    let
      system = "x86_64-linux";
      pkgs   = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = piforge.lib.agda.mkShell {
        inherit pkgs;
        version       = "v28";
        extraPackages = with pkgs; [ hugo watchexec ];
        shellHook     = ''
          echo "hugo server -D   — dev server (include draft)"
          echo "hugo             — build in public/"
          echo "agda --html      — genera HTML con highlighting semantico"
        '';
      };
    };
}
