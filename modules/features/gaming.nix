{ lib, ... }:
{
  flake.nixosModules.gaming =
    { pkgs, ... }:
    let
      proton-cachyos-bin = pkgs.stdenvNoCC.mkDerivation rec {
        pname = "proton-cachyos";
        version = "10.0-20260228";
        src = pkgs.fetchzip {
          url = "https://github.com/CachyOS/proton-cachyos/releases/download/cachyos-${version}-slr/proton-cachyos-${version}-slr-x86_64.tar.xz";
          hash = "sha256-ynVdcRa+GwTKUvuO8AgfYEP5sd1iR0Hla/QowU08iD4=";
        };
        dontBuild = true;
        dontFixup = true;
        installPhase = ''
          runHook preInstall
          mkdir -p $out
          cp -r ./* $out/
          runHook postInstall
        '';
      };
    in

    {
      systemd.services.openrazer-daemon = {
        wantedBy = lib.mkForce [ ];
      };

      environment.systemPackages = with pkgs; [
        mangohud
        polychromatic
        (heroic.override {
          extraPkgs =
            pkgs': with pkgs'; [
              gamescope
              gamemode
            ];
        })
      ];

      services.scx = {
        enable = true;
        scheduler = "scx_lavd";
      };

      hardware.openrazer = {
        enable = true;
        users = [ "jeffrey" ];
      };

      programs = {
        gamemode.enable = true;
        gamescope.enable = true;
        steam = {
          enable = true;
          gamescopeSession.enable = true;
          extraCompatPackages = with pkgs; [
            proton-ge-bin
            proton-cachyos-bin
          ];

          extraPackages = with pkgs; [
            SDL2
            wayland
          ];
        };
      };
    };
}
