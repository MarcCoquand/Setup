set nocompatible              " be iMproved, required
filetype off                  " required
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-pathogen'
Plug 'DrTom/fsharp-vim'
Plug 'chriskempson/base16-vim'
Plug 'gmarik/Vundle.vim'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdcommenter'
Plug 'xolox/vim-misc'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'reedes/vim-colors-pencil'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'purescript-contrib/purescript-vim'
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mxw/vim-jsx'
Plug 'elmcast/elm-vim'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-pathogen'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-repeat'
Plug 'vim-scripts/AutoComplPop'
Plug 'reasonml-editor/vim-reason'
Plug 'Quramy/vim-dtsm'
Plug 'Quramy/tsuquyomi'
Plug 'elixir-editors/vim-elixir'
Plug 'fsharp/vim-fsharp', {
      \ 'for': 'fsharp',
      \ 'do':  'make fsautocomplete',
      \}
call plug#end()

"random config
filetype plugin indent on    " required
filetype plugin on
set shellslash
set grepprg=grep\ -nH\ $*
set tw=80
set tabstop=2                   "A tab is 8 spaces
set expandtab                   "Always uses spaces instead of tabs
set softtabstop=2               "Insert 4 spaces when tab is pressed
set shiftwidth=2                "An indent is 4 spaces
set backspace=2
set smarttab                    "Indent instead of tab at start of line
set shiftround                  "Round spaces to nearest shiftwidth multiple
set nojoinspaces                "Don't convert spaces to tabs
set nofoldenable
syntax on

set clipboard=unnamed
set t_Co=256
autocmd BufEnter * silent! lcd %:p:h
autocmd InsertEnter,InsertLeave * set cul!
set scrolljump=8        " Scroll 8 lines at a time at bottom/top
let mapleader = 'm'
set incsearch
set ignorecase
set showcmd
nnoremap gp `[v`]
set relativenumber
set guioptions-=r 
"set colorcolumn=80
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
function! g:ToggleColorColumn()
  if &colorcolumn != ''
    setlocal colorcolumn&
  else
    setlocal colorcolumn=+1
  endif
endfunction
nnoremap <silent> <leader>;; :call g:ToggleColorColumn()<CR>
colorscheme gruvbox

"keybindings and mappings
nmap <leader>n :b#<CR>
nmap <leader>ff :bdelete! %<CR>
nmap <leader>v v`[
nmap <space> :
vmap <space> :

"paranthesis
inoremap <c-k> <Esc>/[)}"'\]>]<CR>:nohl<CR>a

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"compiler
au FileType markdown nnoremap <buffer> <silent> <leader>y  :!pandoc % -o %<.pdf --template='%:p:h'/md.latex --listings<CR>
au FileType markdown nnoremap <buffer> <silent> <leader>[  :!pandoc % -o %<.pdf --listings<CR>
au FileType markdown nnoremap <buffer> <silent> <leader>å  :!pandoc -t beamer -s %<.md -o %<.pdf -V colortheme:seagull -V lang=swedish<CR>
let &makeprg='hdevtools check %'
au FileType c nnoremap <buffer> <leader>y :!gcc -Wall -std=c99 -g *.c -o %< && ./%<<CR>
au FileType lua nnoremap <buffer> <leader>y :!open -a love .<CR>
au FileType tex nnoremap <buffer> <leader>y :!pdflatex %<CR>
au FileType dot nnoremap <buffer> <leader>y :!dot -T pdf -o %<.pdf %<CR>
au FileType ruby nnoremap <buffer> <leader>y :!jruby %<CR>

"vimux
au FileType haskell nnoremap <buffer> <F10> :VimuxRunCommand("ghci")<CR>
au FileType tex nnoremap <buffer> <F10> :VimuxRunCommand("octave")<CR>
au FileType matlab nnoremap <buffer> <F10> :VimuxRunCommand("octave")<CR>
au FileType clojure nnoremap <buffer> <F10> :VimuxRunCommand("lein repl")<CR>
au FileType clojure nnoremap <buffer> <F12> :VimuxRunCommand("lein run")<CR>
au FileType c nnoremap <buffer> <leader>u[ :VimuxRunCommand("clear; gdb " . bufname("%"))<CR>
au FileType c nnoremap <buffer> <leader>ul :VimuxRunCommand("file " . fnamemodify(bufname("%"), ":r"))<CR>
au FileType c nnoremap <buffer> <leader>ub :VimuxRunCommand("b " . line('.'))<CR>
au FileType c nnoremap <buffer> <leader>ur :VimuxRunCommand("run")<CR>
au FileType c nnoremap <buffer> <leader>ut :VimuxRunCommand("bt")<CR>
au FileType c nnoremap <buffer> <leader>ui :VimuxInspectRunner<CR>
au FileType c nnoremap <buffer> <leader>uc :VimuxCloseRunner<CR>
let g:VimuxHeight = "40"

"easyalign
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)

" Pathogen - required for F#
execute pathogen#infect()


"NERDTree
nmap <leader>x :NERDTreeToggle<CR>
let g:NERDTreeMapMenu = ','
hi Directory ctermfg=red cterm=bold

"git
map <leader>g :!git 

"F#
let g:fsharp_only_check_errors_on_write = 1
let g:fsharp_completion_helptext = 1

"ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<C-tab>"

"latex
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'
set spelllang=sv,en
au FileType tex :set spell
au FileType <silent> tex :SyntasticToggleMode 
"au FileType tex nnoremap <buffer> <F9> :!evince %<.pdf<CR>

"markdown
au BufRead,BufNewFile *.md set filetype=markdown
au FileType markdown :set spell

"anyblock surround
nmap <silent><leader>rr <Plug>(operator-surround-delete)<Plug>(textobj-anyblock-a)
nmap <silent><leader>rc <Plug>(operator-surround-replace)<Plug>(textobj-anyblock-a)
map <silent><leader>ra <Plug>(operator-surround-append)

""==================
""BEGIN COLOURSCHEME
""==================

"syntax on
"syntax reset
"highlight clear

""hi EasyMotionTarget2First ctermbg=none ctermfg=red

"hi SneakStreakMask ctermfg=blue ctermbg=white
"hi SneakPluginScope ctermfg=white ctermbg=blue
"hi SneakPluginTarget ctermfg=white ctermbg=blue
"hi TagbarHighlight ctermbg=red ctermfg=NONE
"hi Comment ctermfg=grey ctermbg=NONE 
hi LineNr ctermfg=NONE ctermbg=NONE 
hi Number ctermfg=NONE ctermbg=NONE 
hi Function cterm=bold 
hi Type cterm=bold 
hi Statement cterm=bold 
hi String ctermfg=cyan ctermbg=NONE 
hi Identifier ctermfg=NONE ctermbg=NONE 
hi Boolean ctermfg=NONE ctermbg=NONE 
hi Float ctermfg=NONE ctermbg=NONE 
hi Type cterm=bold
hi VertSplit ctermfg=0 ctermbg=0
hi Special ctermfg=NONE ctermbg=none 
hi SpecialKey ctermfg=NONE ctermbg=none 
hi Folded ctermfg=white ctermbg=black 
hi texItalStyle cterm=italic
hi texBoldStyle cterm=bold
hi clear SpellBad
hi SpellBad cterm=underline 
hi Normal ctermfg=white ctermbg=NONE
highlight LineNr ctermfg=grey
hi CursorLineNr ctermbg=NONE cterm=bold
highlight EndOfBuffer ctermfg=black ctermbg=NONE



