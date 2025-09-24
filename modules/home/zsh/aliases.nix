{
  ".." = "cd ..";
  "..." = "cd ../..";
  "...." = "cd ../../..";
  "....." = "cd ../../../..";
  "......" = "cd ../../../../..";
  bandwhich = "sudo bandwhich";
  bathelp = "bat --plain --language=help";
  bc = "wcalc";
  c = "clear";
  df = "df -h";
  grep = "grep --colour=auto";
  j = "just";
  open = "xdg-open";
  ping = "gping";
  rmf = "rm -rf";
  su = "su -";
  # Temporary as I develop my nix-ified neovim config
  vim = "nix run ~/neovim-nix/.# --";
}
