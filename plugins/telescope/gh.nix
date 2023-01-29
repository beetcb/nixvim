{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.plugins.telescope.extensions.gh;
  helpers = import ../helpers.nix { inherit lib; };
in
{
  options.plugins.telescope.extensions.gh = {
    enable = mkEnableOption "Enable telescope-github.nvim";
    package = helpers.mkPackageOption "telescope extension gh" pkgs.vimPlugins.telescope-github-nvim;
  };

  config =
    mkIf cfg.enable {
      extraPlugins = [ cfg.package ];
      plugins.telescope.enabledExtensions = [ "gh" ];
    };
}
