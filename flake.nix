{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  inputs.agenix.url = "github:ryantm/agenix";

  outputs = { self, nixpkgs, agenix }@attrs: {

    nixosConfigurations.heavy-compute = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ 
        ./configuration.nix 
	agenix.nixosModules.default
      ];
    };
  };
}
