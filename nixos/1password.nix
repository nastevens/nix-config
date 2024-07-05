{ flake, ... }:

let
  me = flake.config.me;
in
{
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ me.username ];
  };
}
