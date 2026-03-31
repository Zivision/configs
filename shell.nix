{
  pkgs ? import <nixpkgs> { },
}:

with pkgs;

mkShell {
  nativeBuildInputs = with buildPackages; [
    python3
    stow
    emacs
    git
  ];
}
