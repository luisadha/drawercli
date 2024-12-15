{
  description = "Flake for drawercli";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux = nixpkgs.lib.mkShell {
      buildInputs = [
        nixpkgs.stdenv
      ];
      shellHook = ''
        echo "drawercli ready to use!"
      '';
    };
  };
}
