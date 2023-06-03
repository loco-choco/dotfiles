{ pkgs, inputs, ... }:
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
    xdragon
    #owmods
    inputs.ow-mod-man.packages.${system}.owmods-cli
    #inputs.ow-mod-man.packages.${system}.owmods-gui
    #circuit tools
    kicad
    #website making
    zola
  ];

  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  programs.newsboat = {
    enable = true;
    autoReload = true;
    urls = [
      {
        url = "https://xeiaso.net/blog.rss";
      }
    ];
  };
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
    settings = {
      enabled_layouts = "*";
    };
  };

  programs.git = {
    enable = true;
    userName = "ShoosGun";
    userEmail = "ivanrwpf@gmail.com";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
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
    localVariables = {
      VISUAL = "nvim";#for ranger default editor
    };
    shellAliases = {
      "icat" = "kitty +kitten icat";
      "d" = "kitty +kitten diff";
      "nix" = "noglob nix"; #so we can use the # char in flakes
      "w3m" = "w3m -o inline_img_protocol=4";#so we can see images in kitty
      "bat" = "bat -P"; # this makes it display the whole file at once
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
