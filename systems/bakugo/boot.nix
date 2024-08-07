{ pkgs, ... }:

{
  boot = {
    initrd = {
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      kernelModules = [ "dm-snapshot" ];
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [
      "dm_raid"
      "kvm-amd"
    ];
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
      };
      timeout = 10;
    };
    swraid = {
      enable = true;
      # remove warning about unset mail
      mdadmConf = "PROGRAM ${pkgs.coreutils}/bin/true";
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/c07551c2-0f8d-46c8-91b1-4d6304022659";
    fsType = "btrfs";
    options = [ "subvol=root" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/0255-F0D5";
    fsType = "vfat";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/c07551c2-0f8d-46c8-91b1-4d6304022659";
    fsType = "btrfs";
    options = [ "subvol=home" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/c07551c2-0f8d-46c8-91b1-4d6304022659";
    fsType = "btrfs";
    options = [ "subvol=nix" ];
  };

  swapDevices = [ ];
}
