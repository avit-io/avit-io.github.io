{
  description = "avit-io.github.io";

  inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2511.912939";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs   = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          hugo          # sito statico
          agda          # agda --html per snippet con highlighting semantico
          watchexec     # rebuild automatico
        ];
        shellHook = ''
          echo "hugo server -D   — dev server (include draft)"
          echo "hugo             — build in public/"
        '';
      };
    };
}
