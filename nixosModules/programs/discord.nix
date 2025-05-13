{ pkgs, lib, config, ... }:
{
  environment.systemPackages = [ pkgs.discord ];
}