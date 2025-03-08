{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    opts = {
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
    };
    colorschemes.onedark = { enable = true; };
    plugins.lightline.enable = true;
    plugins.coq-nvim.enable = true;
    plugins.lsp = {
      enable = true;
      servers = {
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
    plugins.cmp-nvim-lsp.enable = true;
    plugins.cmp = {
      enable = true;
      settings.completion.autocomplete = [ "TextChanged" ];
    };
  };
}
