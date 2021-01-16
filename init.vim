call plug#begin()
" Aesthetics
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Functionalities
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'ryanoasis/vim-devicons'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

let g:deoplete#enable_at_startup = 1
call plug#end()

" Set spellcheck language
set spelllang=de

""" Coloring
syntax on
color dracula
highlight Pmenu guibg=white guifg=black gui=bold
highlight Comment gui=bold
highlight Normal gui=none
highlight NonText guibg=none

" Opaque Background (Comment out to use terminal's profile)
set termguicolors

" Clipboard
set clipboard+=unnamedplus

""" Other Configurations
filetype plugin indent on
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
set incsearch ignorecase smartcase hlsearch
set number

" Airline
let g:airline_powerline_fonts = 1
let g:airline_section_warning = ''
