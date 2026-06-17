{ ... }:
{
  flake.nixosModules.gaming =
    { pkgs, ... }:
    let
      proton-cachyos-bin = pkgs.stdenvNoCC.mkDerivation rec {
        pname = "proton-cachyos";
        version = "11.0-20260506";
        src = pkgs.fetchzip {
          url = "https://github.com/CachyOS/proton-cachyos/releases/download/cachyos-${version}-slr/proton-cachyos-${version}-slr-x86_64.tar.xz";
          hash = "sha256-h2HHH5R/4GcUuL6paUM8b8iZRjI5LRI+RPJnmV+V+bY=";
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
      environment.systemPackages = with pkgs; [
        mangohud
        bolt-launcher
        (heroic.override {
          extraPkgs =
            pkgs': with pkgs'; [
              gamescope
              gamemode
            ];
        })
      ];

      home-manager.users.jeffrey = {
        home.file.".steam/root/compatibilitytools.d/proton-cachyos".source = proton-cachyos-bin;
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
