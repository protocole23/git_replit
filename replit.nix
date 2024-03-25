{ pkgs }: {
  deps = [
    pkgs.q
    pkgs.non
    pkgs.bashInteractive
    pkgs.nodePackages.bash-language-server
    pkgs.man
  ];
}