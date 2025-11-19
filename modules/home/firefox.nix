{ ... }:
{
  programs.firefox = {
    enable = true;
    policies = {
      DefaultDownloadDirectory = "\${home}/Downloads";
      DisplayBookmarksToolbar = "always";
      NoDefaultBookmarks = true;
    };
    profiles.nick = {
      containers = { };
      # This is getting overwritten every time
      # search.default = "DuckDuckGo";

      # Disable tab bar (use tree tabs)
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
      userChrome = ''
        #TabsToolbar {
          height: 0px !important;
          min-height: 0px !important;
          max-height: 0px !important;
        }
        #TabsToolbar .tabbrowser-tab {
          display: none !important;
        };
      '';
    };
  };
}
