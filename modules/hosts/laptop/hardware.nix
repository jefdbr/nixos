{ inputs, ... }:
{
	flake.nixosModules.laptopHardware =
		{ config, lib, pkgs, modulesPath, ... }:
		{
		  imports =
		    [ (modulesPath + "/installer/scan/not-detected.nix")
		    ];

		  nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
		  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;

		  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
		  boot.initrd.kernelModules = [ ];
		  boot.kernelModules = [ "kvm-intel" ];
		  boot.extraModulePackages = [ ];

		  fileSystems."/" =
		    { device = "/dev/disk/by-uuid/89ec6b10-8c1b-4364-858f-3127d95321f8";
		      fsType = "ext4";
		    };

		  fileSystems."/boot" =
		    { device = "/dev/disk/by-uuid/0800-4A9B";
		      fsType = "vfat";
		      options = [ "fmask=0077" "dmask=0077" ];
		    };

		  swapDevices =
		    [ { device = "/dev/disk/by-uuid/ab963b06-3502-4624-91a4-64f7fba6dd75"; }
		    ];

		  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
		  hardware.cpu.intel.npu.enable = true;
		  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
		};
}
