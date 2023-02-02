{ lib
, pkgs
, config
, ...
} @ args:
with lib; let
  helpers = import ../helpers.nix args;
in
{
  options.plugins.fidget = {
    enable = helpers.defaultNullOpts.mkBool false "Enable fidget.nvim";
    package = helpers.mkPackageOption "fidget" pkgs.vimPlugins.fidget-nvim;
    setupOptions = helpers.defaultNullOpts.mkNullable (types.attrs) "{}" ''
      Setup options for fidget, see -> https://github.com/j-hui/fidget.nvim/blob/main/doc/fidget.md#options for more details.
    '';
  };
  config =
    let
      cfg = config.plugins.fidget;
    in
    mkIf cfg.enable {
      extraPlugins = [ cfg.package ];
      extraConfigLua =
        ''require("fidget").setup${helpers.toLuaObject cfg.setupOptions}'';
    };
}
