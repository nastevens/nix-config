{ pkgs, ... }:
let commonPkgs = with pkgs; [ coreutils git gnused unixtools.column ];
in pkgs.symlinkJoin {
  name = "git-utils";
  paths = [
    (pkgs.writeShellApplication {
      name = "git-lsbranch";
      runtimeInputs = commonPkgs;
      text = builtins.readFile ./git-lsbranch.sh;
    })
    (pkgs.writeShellApplication {
      name = "git-size";
      runtimeInputs = commonPkgs;
      text = builtins.readFile ./git-size.sh;
    })
    (pkgs.writeShellApplication {
      name = "git-who";
      runtimeInputs = commonPkgs ++ [ pkgs.huniq ];
      text = builtins.readFile ./git-who.sh;
    })
  ];
}
