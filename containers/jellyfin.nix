{ config, lib, pkgs, ... }:
{
  containers.jellyfin = {
    autoStart = true;
    hostAddress = "192.168.0.4";
    localAddress = "10.0.0.5";
    allowedDevices = [
      {
        modifier = "rw";
	node = "/dev/dri/renderD128";
      }
    ];
    bindMounts = {
      "/media" = { 
        hostPath = "/storage/media";
        isReadOnly = false;
      };
      "/dev/dri/renderD128" = {
        hostPath = "/dev/dri/renderD128";
        isReadOnly = false;
      };
      # secrets for ts-auth
      "/etc/tailscale/authkey" = {
        isReadOnly = true;
	hostPath = "${config.age.secrets.tailscale.path}";
      };
    };

    config = { config, pkgs, lib, ...}: {
      hardware.opengl = {
        enable = true;
        extraPackages = [
          pkgs.vaapiVdpau
        ];
      };
      services.jellyfin = {
        enable = true;
	openFirewall = true;
      };
      system.stateVersion = "23.11";
      networking.firewall.enable = true;
      networking.useHostResolvConf = lib.mkForce false;
      services.resolved.enable = true;
      services.tailscale.interfaceName = "userspace-networking";
      services.tailscale.enable = true;
      services.tailscale.authKeyFile = "/etc/tailscale/authkey";
    };
  };
}
