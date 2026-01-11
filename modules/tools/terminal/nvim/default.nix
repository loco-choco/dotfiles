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
    programs.nixvim = {
      enable = true;
      opts = {
        expandtab = true;
        shiftwidth = 2;
        tabstop = 2;
      };
      colorschemes.onedark = {
        enable = true;
      };
      plugins.lightline.enable = true;
      plugins.coq-nvim.enable = true;
      ## LSP
      plugins.lsp = {
        enable = true;
        servers = {
          jsonls.enable = true;
          jdtls.enable = true;
          nixd.enable = true;
          bashls.enable = true;
        };
      };
      plugins.lsp-format.enable = true;
      plugins.none-ls.enable = true;
      plugins.none-ls.sources.formatting.nixfmt = {
        enable = true;
        package = pkgs.nixfmt;
      };

      ## Auto Complete
      # (from https://github.com/GaetanLepage/nix-config/blob/master/home/modules/tui/neovim/completion.nix)
      opts.completeopt = [
        "menu"
        "menuone"
        "noselect"
      ];

      plugins.luasnip.enable = true;

      plugins.lspkind = {
        enable = true;
        settings.cmp.menu = {
          nvim_lsp = "[LSP]";
          nvim_lua = "[api]";
          path = "[path]";
          luasnip = "[snip]";
          buffer = "[buffer]";
        };
      };

      plugins.cmp = {
        enable = true;

        settings = {
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";

          mapping = {
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };

          sources = [
            { name = "path"; }
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            {
              name = "buffer";
              # Words from other open buffers can also be suggested.
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            }
          ];
        };
      };
    };
  };
}
