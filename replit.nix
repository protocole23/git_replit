{ pkgs }: {
  deps = [
    pkgs.vim
    pkgs.ed
    pkgs.q
    pkgs.non
    pkgs.bashInteractive
    pkgs.nodePackages.bash-language-server
    pkgs.man
  ];
}