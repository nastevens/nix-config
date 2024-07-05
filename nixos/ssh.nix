{ flake, ... }:

let
  me = flake.config.me;
in
{
  services.openssh = {
    enable = true;
    settings = {
      AllowUsers = [ "${me.username}" ];
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
}
