# default.nix
{ inputs, ... }: {

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "znibb" = import ./users/znibb-home.nix;
    };
  };
}
