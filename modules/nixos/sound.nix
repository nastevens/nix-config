{ pkgs, ... }:

{
  services = {
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;

      # May be useful for things like games, but leaving disabled until
      # I know I need it.
      # alsa = {
      #   enable = true;
      #   support32Bit = true;
      # };
    };
  };

  # Allows sound daemon to dynamically request realtime support.
  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    pavucontrol
  ];
}
