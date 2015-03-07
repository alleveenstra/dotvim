execute pathogen#infect()

filetype off
syntax on
filetype plugin indent on

set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set number
set encoding=utf-8
set nocompatible
set runtimepath^=~/.vim/bundle/ctrlp.vim
set hlsearch

#inoremap  <Up>     <NOP>
#inoremap  <Down>   <NOP>
#inoremap  <Left>   <NOP>
#inoremap  <Right>  <NOP>
#noremap   <Up>     <NOP>
#noremap   <Down>   <NOP>
#noremap   <Left>   <NOP>
#noremap   <Right>  <NOP>

map <C-n> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>

" open nerdtree when you open no file
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close nerdtree when it's the only one left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Go leader mappings
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>d <Plug>(go-def)

set background=dark
colorscheme jellybeans

let g:ycm_autoclose_preview_window_after_insertion = 1

let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:auto_save = 0
let g:neocomplete#enable_at_startup = 1
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_json_checkers=['jsonlint']

" mapping of multicursor keys
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key=''
let g:multi_cursor_skip_key=''
let g:multi_cursor_quit_key='<Esc>'

function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-e>"
" this mapping Enter key to <C-y> to chose the current highlight item 
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

if has('gui_running')
    set guioptions-=T  " no toolbar
    let g:Powerline_symbols = 'fancy'
    set lines=60 columns=108 linespace=0
    set guifont=Sauce\ Code\ Powerline\ Bold
    let g:airline_powerline_fonts = 1
else
    let g:solarized_termcolors=256
    set t_Co=256
endif

autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction
