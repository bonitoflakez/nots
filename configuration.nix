{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/user.nix
      ./modules/networking.nix
      ./modules/hardware.nix
      ./modules/services.nix
      ./modules/misc.nix
    ];

  system.stateVersion = "24.05";
}
