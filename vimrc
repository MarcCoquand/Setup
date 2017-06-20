set nocompatible              " be iMproved, required
filetype off                  " required
"============
"BEGIN Vundle
"============

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
"
Plugin 'edsono/vim-matchit'
Plugin 'chriskempson/base16-vim'
Plugin 'gmarik/Vundle.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'scrooloose/nerdcommenter'
Plugin 'xolox/vim-misc'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'reedes/vim-colors-pencil'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'scrooloose/nerdtree'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'Valloric/YouCompleteMe'

Bundle 'ervandew/supertab'
Plugin 'justinj/vim-react-snippets'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'mxw/vim-jsx'
Plugin 'elmcast/elm-vim'
Plugin 'morhetz/gruvbox'
Plugin 'tpope/vim-pathogen'
Plugin 'vim-syntastic/syntastic'


call vundle#end()            " required
set rtp+=~/.fzf


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
set smarttab                    "Indent instead of tab at start of line
set shiftround                  "Round spaces to nearest shiftwidth multiple
set nojoinspaces                "Don't convert spaces to tabs
set nofoldenable
syntax on
set backspace=2

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
map <leader>s :w<CR>
nmap <leader>qq :q!<CR>
nmap <leader>ww :wq<CR>
nmap <leader>n :b#<CR>
nmap <leader>ff :bdelete! %<CR>
nmap <leader>v v`[
nmap <leader>th :tag 
nmap <leader>td <C-]>
nmap <leader>tt <C-t>
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
au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
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

"NERDTree
nmap <leader>x :NERDTreeToggle<CR>
let g:NERDTreeMapMenu = ','
hi Directory ctermfg=red cterm=bold

"git
map <leader>g :!git 

" YCM

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" Pathogen
execute pathogen#infect()


"ultisnips

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<C-tab>"



"FZF

" FZF Functions
function! s:line_handler(l)
  let keys = split(a:l, ':\t')
  exec 'buf ' . keys[0]
  exec keys[1]
  normal! ^zz
endfunction

function! s:buffer_lines()
  let res = []
  for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    call extend(res, map(getbufline(b,0,"$"), 'b . ":\t" . (v:key + 1) . ":\t" . v:val '))
  endfor
  return res
endfunction

function! BufOpen(e)
  execute 'buffer '. matchstr(a:e, '^[ 0-9]*')
endfunction

function! TagCommand()
    return substitute('awk _!/^!/ { print \$1 }_ ', '_', "'", 'g')
                \ . join(tagfiles(), ' ')
endfunction

function! BufList()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

" --------------------
"  FZF-commands
"

command! FZFMru call fzf#run({
\   'source':      v:oldfiles,
\   'sink':        'e ',
\   'options':     '-m',
\   'tmux_height': '20%'
            \})

command! FZFLines call fzf#run({
\   'source':  <sid>buffer_lines(),
\   'sink':    function('<sid>line_handler'),
\   'options': '--extended --nth=3..',
\   'tmux_height': '60%'
\})

command! FZFTag call fzf#run({
\   'source'     : TagCommand(),
\   'sink'       : 'tag',
\   'tmux_width': '20%'
\   })

command! FZFBuffer call fzf#run({
\   'source':      reverse(BufList()),
\   'sink':        function('BufOpen'),
\   'options':     '+m',
\   'tmux_height': '20%'
\ })

"
" ---------------------
"  FZF mappings

nnoremap <silent> <leader>, :FZFMru <CR>
nmap <leader>o :FZF ~<CR>
nmap <leader>i :FZF<CR>
nnoremap <silent> <Leader>e :FZFBuffer<CR>

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

"youcompleteme
let g:ycm_allow_changing_updatetime = 0

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


