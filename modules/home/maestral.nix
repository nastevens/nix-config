{
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.meta) getExe;
  maestral = pkgs.maestral;
  failAction = builtins.replaceStrings [ "\n" ] [ " " ] ''
    if [ ''${SERVICE_RESULT} != success ]; then
      notify-send Maestral 'Daemon failed: ''${SERVICE_RESULT}'
    fi
  '';
in
{
  home.packages = [
    maestral
  ];
  programs.zsh.initContent = ''
    eval "$(${getExe maestral} completion zsh)"
  '';
  systemd.user.services."maestral-daemon" = {
    Unit = {
      Description = "Maestral daemon";
    };
    Service = {
      Type = "notify";
      ExecStart = ''
        ${getExe maestral} start --foreground --config-name="maestral"
      '';
      WatchdogSec = 30;
      ExecStop = ''
        ${getExe maestral} stop --config-name="maestral"
      '';
      ExecStopPost = ''
        ${pkgs.runtimeShell} -c "${failAction}"
      '';
      Environment = "PYTHONOPTIMIZE=2 LC_CTYPE=UTF-8";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
