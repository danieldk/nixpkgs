# This module enables the ROCM stack

{ config, lib, pkgs, ... }:

with lib;

{
  config = mkIf (elem "amdgpu-rocm" config.services.xserver.videoDrivers) {
    hardware.opengl.package = pkgs.rocm-mesa.drivers;
    hardware.opengl.extraPackages = [ pkgs.rocm-opencl-icd ];
    boot.blacklistedKernelModules = [ "radeon" ];
  };
}
