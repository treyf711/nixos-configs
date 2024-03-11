{ config, lib, pkgs, ... }:
{
  containers.jellyfin = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.0.4";
    localAddress = "10.0.0.5";

    config = { config, pkgs, lib, ...}: {

      services.jellyfin = {
        enable = true;
	openFirewall = true;
      };
      system.stateVersion = "23.11";
      networking.firewall.enable = true;
      networking.useHostResolvConf = lib.mkForce false;
      services.resolved.enable = true;
    };
  };
}
