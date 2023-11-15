{ pkgs, ... }:{
  programs.nixvim = {
    enable = true;
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
	clangd.enable = true;
        rust-analyzer.enable = true;
	csharp-ls.enable = true;
	csharp-ls.package = pkgs.csharp-ls.overrideAttrs (old: {
          version = "0.9.0";
	  #nugetSha256 = "";
	});
      };
    };
    plugins.nvim-cmp = {
      enable = true;
      completion.autocomplete = [ "TextChanged" ];
    };
  };
}
