{ lib, ... }:

let
  meSubmodule = lib.types.submodule {
    options = {
      name = lib.mkOption {
        type = lib.types.str;
      };
      username = lib.mkOption {
        type = lib.types.str;
      };
    };
  };
in
{
  options = {
    me = lib.mkOption {
      type = meSubmodule;
    };
  };
  config = {
    me = {
      name = "Nick Stevens";
      username = "nick";
    };
  };
}
