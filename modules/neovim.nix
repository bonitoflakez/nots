{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    configure = {
    customRC = ''
        set number
        set relativenumber
        set tabstop=2
        set shiftwidth=2
        set hidden
        set nowrap
        set smartcase
        set noswapfile
        set nobackup
        set undodir=~/.vim/undodir
        set undofile

        let mapleader = " "

        " Use xclip for copying to clipboard
        nnoremap <leader>y :!xclip -selection clipboard<CR>
        nnoremap <leader>p :!xclip -selection clipboard -o<CR>

        " Enable mouse support
        set mouse=a

        " Enable true color support
        set termguicolors

        " Set colorscheme
        colorscheme gruvbox-material

        " Configure nvim-tree
        lua << EOF
          require("nvim-tree").setup({
            view = {
              width = 30,
            },
          })

          -- Toggle nvim-tree with <leader>t
          vim.api.nvim_set_keymap("n", "<leader>t", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
        EOF
    '';

    packages.nvimPlugins = with pkgs.vimPlugins; {
        start = [
          nvim-tree-lua
          vim-sleuth
          gruvbox-material
        ];
      };
    };
    };
}
