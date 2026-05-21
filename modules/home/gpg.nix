{ pkgs, ... }:

{
  programs.gpg = {
    enable = true;
    # TODO: specify as XDG data directory
    # homedir = "";
    mutableKeys = false;
  };
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-tty;
  };
}
