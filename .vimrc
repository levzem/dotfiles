" Settings
syntax on
set backspace=indent,eol,start
set clipboard=unnamed
set number
set showmatch
set ignorecase
set hidden
set cursorline
"set relativenumber

" Spaces & Tabs
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Better line navigation
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_

" map all C-W to C
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
nnoremap <C-v> <C-W>v
nnoremap <C-s> <C-W>s
nnoremap <C-c> <C-W>c

nnoremap Y y$
