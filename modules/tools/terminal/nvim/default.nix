{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.terminal.nvim;
in
{
  options = {
    tools.terminal.nvim = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables nvim editor 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.variables.EDITOR = "nvim";
    programs.nvf = {
      enable = true;
      settings = {
        vim.viAlias = false;
        vim.vimAlias = true;
        #### Appearence
        vim.utility.sleuth.enable = true;
        vim.theme = {
          enable = true;
          name = "onedark";
        };
        vim.mini.statusline.enable = true;
        vim.lineNumberMode = "relNumber";
        #### LSP and Autocomplete
        vim.autocomplete.blink-cmp = {
          enable = true;
          setupOpts.signature.enabled = true;
        };
        vim.lsp.lspkind.enable = true; # Pictograms
        vim.lsp = {
          enable = true;
          inlayHints.enable = true;
          lightbulb.enable = true;
          presets = {
            nushell.enable = true;
          };
        };
        vim.languages = {
          enableFormat = true;
          json.enable = true;
          nix.enable = true;
          bash.enable = true;
        };
        #### Code Snippets
        vim.snippets.luasnip.enable = true;
        #### Spell Checking
        vim.spellcheck = {
          enable = true;
          vim-dirtytalk.enable = true;
          languages = [
            "en"
            "fr"
          ];
        };
      };
    };
  };
}
