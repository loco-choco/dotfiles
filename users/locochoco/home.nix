{ pkgs, ... }:
{
  home.username = "locochoco";
  home.homeDirectory = "/home/locochoco";

  home.packages = with pkgs; [
    #keys stuff
    gnupg
    git-crypt
    pinentry-qt
    #terminal utils
    onefetch
    mpv
    f3d
    bat
  ];

  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
  };


  programs.kitty = {
    enable = true;
    theme = "Space Gray Eighties";
    keybindings = {
      "ctrl+k" = "kitten mykitten.py";
    };
  };

  programs.git = {
    enable = true;
    userName = "ShoosGun";
    userEmail = "ivanrwpf@gmail.com";
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      plenary-nvim
      gruvbox-material
      mini-nvim
      openscad-nvim #on nixpkgs 23.05
      hologram-nvim
    ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    enableVteIntegration = true;
    autocd = true;
    shellAliases = {
      "icat" = "kitty +kitten icat";
      "d" = "kitty +kitten diff";
      "edconf" = "nvim /etc/nixos/configuration.nix";
      "edhome" = "nvim /etc/nixos/home.nix";
      "nixrebuild" = "nixos-rebuild switch";
      "nixclean" = "nix-collect-garbage";
      "sedconf" = "sudo nvim /etc/nixos/configuration.nix";
      "sedhome" = "sudo nvim /etc/nixos/home.nix";
      "snixrebuild" = "sudo nixos-rebuild switch";
      "snixclean" = "sudo nix-collect-garbage";
    };
    plugins = [
      #{
      #  # will source zsh-autosuggestions.plugin.zsh
      #  name = "zsh-autosuggestions";
      #  src = pkgs.fetchFromGitHub {
      #    owner = "zsh-users";
      #    repo = "zsh-autosuggestions";
      #    rev = "v0.4.0";
      #    sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
      #  };
      #}
    ];
    prezto = {
      enable = true;
      prompt.theme = "paradox";
      pmodules = [ 
        "environment"
        "terminal"
        "editor"
        "history"
        "directory"
        "spectrum"
        "utility"
	      "git"
        "completion"
        "prompt"
      ];
    };
   }; 
}
