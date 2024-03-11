{ config, pkgs, ... }:

{
  imports = [
    ./jellyfin.nix
  ];
  services.tvheadend.enable = true;
}
