{ pkgs, config, ... }: {
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement = {
      enable = false;
      finegrained = false;
    };
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };
  environment.systemPackages = with pkgs; [ glxinfo mesa-demos nvtop ];
}
