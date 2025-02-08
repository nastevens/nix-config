{ pkgs, ... }:

{
  home.packages = with pkgs; [
    angle-grinder
    bat
    bc
    cargo-cache
    codevis
    fd
    file
    gawk
    gibo
    gnused
    gnutar
    gping
    hexyl
    htop
    hyperfine
    jq
    just
    kondo
    mdcat
    mmv
    p7zip
    ripgrep
    termdown
    tokei
    unzip
    viu
    which
    xan
    xh
    xz
    zip
    zstd
  ];
}
