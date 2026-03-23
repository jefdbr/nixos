{ inputs, ... }: {
  flake.nixosModules.boot = { pkgs, ... }: {
    nixpkgs.overlays = [
      inputs.nix-cachyos-kernel.overlays.pinned
    ];

    boot = {
      kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
        timeout = 5;
      };

      initrd.systemd.network.wait-online.enable = false;
    };
  };
}
