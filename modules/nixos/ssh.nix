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

      # I strictly limit users and auth methods, so the only way a legitimate
      # login attempt would get caught is if I forget to load my ssh key.
      # Therefore I can be pretty draconian with the failure penalties.
      PerSourcePenalties = "max:24h crash:1h authfail:5m noauth:5m";
    };
  };
}
