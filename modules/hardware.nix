{ config, pkgs, ... }:

{
    boot = {
      loader = {
        systemd-boot = {
          enable = true;
        };

        grub = {
          device = true;
          efiSupport = true;
        };

        efi = {
          canTouchEfiVariables = true;
        };
      };
    };


    hardware = {
      graphics = {
        enable = true;
      };

      nvidia = {
        modesetting = {
          enable = true;
        };

        powerManagement = {
          enable = false;
        };

        powerManagement = {
          finegrained = false;
        };

        open = false;

        nvidiaSettings = true;

        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };

      nvidia-container-toolkit = {
        enable = true;
      };

      pulseaudio = {
        enable = false;
      };
    };
}
