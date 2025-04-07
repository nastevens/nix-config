{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "open-slug";
  runtimeInputs = [ pkgs.xdg-utils ];
  text = builtins.readFile ./open-slug.sh;
}
