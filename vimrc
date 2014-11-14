execute pathogen#infect()

syntax on
filetype plugin indent on
colors jellybeans

" open nerdtree when you open no file
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" close nerdtree when it's the only one left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

nmap <F8> :TagbarToggle<CR>
map <C-n> :NERDTreeToggle<CR>
