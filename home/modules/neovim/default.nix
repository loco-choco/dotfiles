{ pkgs, ... }:{
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
    plugins.lsp = {
      enable = true;
      servers = {
        nixd.enable = true;
	      bashls.enable = true;
	      #clangd.enable = true;
	      ccls.enable = true;
        rust-analyzer.enable = true;
        rust-analyzer.installRustc = true;
        rust-analyzer.installCargo = true;
	      vhdl-ls.enable = true;
	      csharp-ls.enable = true;
        ltex = {
          enable = true;
          settings.enabled = ["json" "bibtex" "context" "context.tex" "html" "latex" "markdown" "org" "restructuredtext" "rsweave"];
        };
      };
    };
    plugins.cmp-nvim-lsp.enable = true;
    plugins.cmp = {
      enable = true;
      settings.completion.autocomplete = [ "TextChanged" ];
    };
  };
}
