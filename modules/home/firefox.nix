{
  lib,
  pkgs,
  ...
}:

{
  programs.firefox = {
    enable = true;

    # --- Containers ---
    profiles.nick.containersForce = true;
    profiles.nick.containers =
      let
        makeContainers =
          containerList:
          builtins.listToAttrs (
            lib.imap0 (i: c: {
              inherit (c) name;
              value = {
                inherit (c) color icon;
                id = i;
              };
            }) (containerList)
          );
      in
      makeContainers [
        {
          name = "Amazon Music";
          color = "green";
          icon = "circle";
        }
        {
          name = "Amazon Shopping";
          color = "pink";
          icon = "cart";
        }
        {
          name = "Google";
          color = "blue";
          icon = "circle";
        }
        {
          name = "Social";
          color = "blue";
          icon = "fence";
        }
      ];

    # --- Search ---
    profiles.nick.search = {
      default = "ddg";
      force = true;
      engines =
        let
          nixSearchParams = [
            {
              name = "channel";
              value = "unstable";
            }
            {
              name = "type";
              value = "packages";
            }
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
          nixIcon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          simpleQueryUrls = url: paramName: [
            {
              template = url;
              params = [
                {
                  name = paramName;
                  value = "{searchTerms}";
                }
              ];
            }
          ];
        in
        {
          home-manager-options = {
            name = "Home Manager Options";
            urls = [
              {
                template = "https://home-manager-options.extranix.com/";
                params = [
                  {
                    name = "release";
                    value = "master";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = nixIcon;
            definedAliases = [ "@ho" ];
          };

          mdn = {
            name = "MDN";
            urls = simpleQueryUrls "https://developer.mozilla.org/en-US/search" "q";
            iconMapObj."16" = "https://developer.mozilla.org/favicon.ico";
            definedAliases = [ "@mdn" ];
          };

          nix-functions = {
            name = "Noogle (Nix Functions)";
            urls = simpleQueryUrls "https://noogle.dev/q" "term";
            iconMapObj."16" = "https://noogle.dev/favicon.ico";
            definedAliases = [
              "@nf"
              "@noogle"
            ];
          };

          nix-packages = {
            name = "Nix Packages";
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = nixSearchParams;
              }
            ];
            icon = nixIcon;
            definedAliases = [ "@np" ];
          };

          nix-options = {
            name = "Nix Options";
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = nixSearchParams;
              }
            ];
            icon = nixIcon;
            definedAliases = [ "@no" ];
          };

          nixos-wiki = {
            name = "NixOS Wiki";
            urls = simpleQueryUrls "https://wiki.nixos.org/w/index.php" "search";
            icon = nixIcon;
            definedAliases = [ "@nw" ];
          };

          overclocked-remix = {
            name = "OverClocked ReMix";
            urls = simpleQueryUrls "https://ocremix.org/site-search/" "q";
            iconMapObj."16" = "https://ocremix.org/favicon.ico";
            definedAliases = [ "@ocr" ];
          };

          python = {
            name = "Python";
            urls = simpleQueryUrls "https://docs.python.org/3/search.html" "q";
            iconMapObj."16" = "https://docs.python.org/favicon.ico";
            definedAliases = [ "@py" ];
          };

          rust = {
            name = "Rust std";
            urls = simpleQueryUrls "https://doc.rust-lang.org/std/" "search";
            iconMapObj."16" = "https://docs.rust-lang.org/favicon.ico";
            definedAliases = [ "@rust" ];
          };

          bing.metaData.hidden = true;
          google.metaData.hidden = true;
          perplexity.metaData.hidden = true;
        };
    };

    # --- Policies ---
    policies = {
      AppAutoUpdate = false;
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      Cookies.Allow = [
        "https://octopi.local"
        "https://pi.hole"
        "https://proton.me"
      ];
      DefaultDownloadDirectory = "\${home}/Downloads";
      DisplayBookmarksToolbar = "always";
      DisplayMenuBar = "default-off";
      GenerativeAI = {
        Enabled = false;
      };
      HttpsOnlyMode = "enabled";
      NetworkPrediction = false;
      NewTabPage = false;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      SanitizeOnShutdown = {
        Cache = true;
        Cookies = true;
      };
      ShowHomeButton = true;
      VisualSearchEnabled = true;

      # --- Extension Installation
      ExtensionSettings =
        let
          moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
        in
        {
          # "*".installation_mode = "blocked";
          "*".installation_mode = "allowed";

          "uBlock0@raymondhill.net" = {
            install_url = moz "ublock-origin";
            installation_mode = "normal_installed";
            private_browsing = true;
          };
          "{d634138d-c276-4fc8-924b-40a0ea21d284}" = {
            install_url = moz "1password-x-password-manager";
            installation_mode = "normal_installed";
          };
          "@testpilot-containers" = {
            install_url = moz "multi-account-containers";
            installation_mode = "normal_installed";
          };
          "myallychou@gmail.com" = {
            install_url = moz "youtube-recommended-videos";
            installation_mode = "normal_installed";
          };
          "@react-devtools" = {
            install_url = moz "react-devtools";
            installation_mode = "normal_installed";
          };
        };
    };

    # --- Settings ---
    profiles.nick.settings = {
      # Disable accessibility
      "accessibility.force_disabled" = 1;

      # Block autoplay until I'm interacting
      "media.block-autoplay-until-in-foreground" = true;
      "media.block-play-until-document-interaction" = true;
      "media.block-play-until-visible" = true;

      # Prevent pop-ups for adding mailto: handlers
      "network.protocol-handler.external.mailto" = false;

      # Use vertical tabs
      "sidebar.animation.enabled" = false;
      "sidebar.animation.expand-on-hover.delay-duration-ms" = 500;
      "sidebar.revamp" = true;
      "sidebar.verticalTabs" = true;
      "sidebar.visibility" = "expand-on-hover";

      # No startup page
      "browser.startup.homepage" = "chrome://browser/content/blanktab.html";

      # Sync service settings
      "services.sync.engine.addons" = false;
      "services.sync.engine.addresses" = false;
      "services.sync.engine.bookmarks" = true;
      "services.sync.engine.creditcards" = false;
      "services.sync.engine.extension-storage" = true;
      "services.sync.engine.forms" = false;
      "services.sync.engine.history" = true;
      "services.sync.engine.passwords" = false;
      "services.sync.engine.prefs" = false;
      "services.sync.engine.tabs" = true;

      # pdfjs settings
      "pdfjs.defaultZoomValue" = "page-width";
      "pdfjs.sidebarViewOnLoad" = 0;

      # Layout toolbar
      "browser.uiCustomization.state" = builtins.toJSON {
        placements = {
          widget-overflow-fixed-list = [ ];
          unified-extensions-area = [
            "ublock0_raymondhill_net-browser-action"
          ];
          nav-bar = [
            "sidebar-button"
            "back-button"
            "forward-button"
            "stop-reload-button"
            "home-button"
            "screenshot-button"
            "downloads-button"
            "firefox-view-button"
            "_testpilot-containers-browser-action"
            "vertical-spacer"
            "urlbar-container"
            "vertical-spacer"
            "fxa-toolbar-menu-button"
            "_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action"
            "unified-extensions-button"
          ];
          toolbar-menubar = [
            "menubar-items"
          ];
          TabsToolbar = [ ];
          vertical-tabs = [
            "tabbrowser-tabs"
          ];
          PersonalToolbar = [
            "personal-bookmarks"
            "bookmarks-menu-button"
          ];
        };
        seen = [
          "developer-button"
          "screenshot-button"
        ];
        dirtyAreaCache = [ ];
        currentVersion = 23;
        newElementCount = 0;
      };

      # Remove nags
      "browser.aboutConfig.showWarning" = false;
      "browser.aboutwelcome.didSeeFinalScreen" = true;
      "browser.toolbarbuttons.introduced.sidebar-button" = true;
      "sidebar.new-sidebar.has-used" = true;
      "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
    };
  };
}
