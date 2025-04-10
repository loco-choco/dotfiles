{ pkgs, ... }:
{
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
        jdtls.enable = true;
        nixd.enable = true;
        bashls.enable = true;
        #clangd.enable = true;
        ccls.enable = true;
        vhdl_ls.enable = true;
        verible.enable = true;
        rust_analyzer = {
          enable = true;
          installRustc = true;
          installCargo = true;
        };
        csharp_ls.enable = true;
        ltex = {
          enable = true;
          settings.enabled = [
            "json"
            "bibtex"
            "context"
            "context.tex"
            "html"
            "latex"
            "markdown"
            "org"
            "restructuredtext"
            "rsweave"
          ];

        };
      };
    };
    plugins.lsp-format.enable = true;
    plugins.none-ls.enable = true;
    plugins.none-ls.sources.formatting.nixfmt = {
      enable = true;
      package = pkgs.nixfmt-rfc-style;
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

      cmp = {
        enable = true;
        menu = {
          nvim_lsp = "[LSP]";
          nvim_lua = "[api]";
          path = "[path]";
          luasnip = "[snip]";
          buffer = "[buffer]";
          neorg = "[neorg]";
          nixpkgs_maintainers = "[nixpkgs]";
        };
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
          { name = "neorg"; }
          { name = "nixpkgs_maintainers"; }
        ];
      };
    };
  };
}
