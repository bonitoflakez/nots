{ config, pkgs, ... }:

{
    boot.loader.systemd-boot.enable = true;
    boot.loader.grub.device = true;
    boot.loader.grub.efiSupport = true;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.kernelParams = [
      "nvidia-drm.modset=1"
      "nvidia-drm.fbdev=1"
      "initcall_blacklist=simpledrm_platform_driver_init"
    ];

    boot.kernelModules = [
	"v4l2loopback"
    ];

    boot.extraModulePackages = [
	pkgs.linuxPackages.v4l2loopback
    ];

    services.xserver.videoDrivers = [ "nvidia" ];

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

      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };

    hardware.pulseaudio.enable = false;
}
