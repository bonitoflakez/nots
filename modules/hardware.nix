{ config, pkgs, ... }:

{
    boot.loader.systemd-boot.enable = true;
    boot.loader.grub.device = true;
    boot.loader.grub.efiSupport = true;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.kernelParams = [
      "initcall_blacklist=simpledrm_platform_driver_init"
    ];

    services.xserver.videoDrivers = ["intel" "nvidia"];

    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    hardware.pulseaudio.enable = true;
}
