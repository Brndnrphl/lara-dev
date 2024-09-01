{ config, pkgs, inputs, system, ... }:
{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    phps.url = "github:loophp/nix-shell";
  };

  pkgs = import inputs.nixpkgs {
    inherit system;
    overlays = [
        inputs.phps.overlays.default
    ];
  };
}
