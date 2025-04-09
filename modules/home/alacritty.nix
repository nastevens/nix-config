{ pkgs, ... }: {
  programs.alacritty =
    let
      fontStyles = {
        normal = { style = "Regular"; };
        bold = { style = "Bold"; };
        italic = { style = "Italic"; };
        bold_italic = { style = "Bold Italic"; };
      };
      fontConfig = fontFamily: fontSize:
        {
          size = fontSize;
        } // builtins.mapAttrs (_: style: style // { family = fontFamily; })
          fontStyles;
      protocolList =
        let
          protocols = [
            "file"
            "ftp"
            "gemini"
            "git"
            "gopher"
            "http"
            "https"
            "ipfs"
            "ipns"
            "magnet"
            "mailto"
            "news"
            "ssh"
          ];
        in
        builtins.concatStringsSep "|" (builtins.map (p: "${p}:") protocols);
    in
    {
      enable = true;

      settings = {
        colors.primary.background = "#000000";
        env.TERM = "xterm-256color";
        font = fontConfig "Mononoki Nerd Font" 11;
        hints.enabled = [
          {
            # Open URLs in browser.
            regex = ''(${protocolList})[^<>"\\s{-}^⟨⟩`]+'';
            command = "${pkgs.xdg-utils}/bin/xdg-open";
            post_processing = true;
            mouse = {
              enabled = true;
              mods = "None";
            };
            binding = {
              key = "U";
              mods = "Control|Shift";
            };
          }

          {
            # Recognize github slugs in strings (i.e. "nastevens/nix-config")
            # and open in browser.
            regex =
              let an = "a-zA-Z0-9";
              in ''["'][${an}][${an}_-]+/[${an}][${an}_.-]+["']'';
            command = {
              program = "${pkgs.open-slug}/bin/open-slug";
              args = [ "https://github.com" ];
            };
            post_processing = true;
            mouse = {
              enabled = true;
              mods = "None";
            };
            binding = {
              key = "G";
              mods = "Control|Shift";
            };
          }
        ];
        selection.save_to_clipboard = true;
      };
    };
}
