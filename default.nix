{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "drawercli";
  version = "1.2.4";

  src = ./.;

  buildInputs = [ pkgs.bash ];

  buildPhase = ''
    mkdir -p $out/bin
  '';

  installPhase = ''
    mkdir -p $out/share/doc/drawercli
    cp -f ./LICENSE $out/share/doc/drawercli/LICENSE
    cp -f ./README.md $out/share/doc/drawercli/README.md
    cp -f ./drawercli.sh $out/bin/drawercli
    chmod +x $out/bin/drawercli
  '';

  meta = with pkgs.lib; {
    description = "This cli app supports using termuxlauncher as your primary launcher for Android phones, interactively and easily install. That's simply the Termuxlauncher Add-on built with fzf🚀
";
    license = licenses.mit;
    maintainers = with maintainers; [ luisadha ];
  };
}
