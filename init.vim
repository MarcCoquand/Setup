call plug#begin('~/.local/share/nvim/plugged')

Plug 'adolenc/cl-neovim'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/kien/ctrlp.vim'
Plug 'https://github.com/terryma/vim-multiple-cursors'
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }
Plug 'https://github.com/scrooloose/nerdtree'
Plug 'https://github.com/rakr/vim-two-firewatch'
Plug 'https://github.com/Shougo/denite.nvim'
Plug 'https://github.com/scrooloose/nerdcommenter'
Plug 'neoclide/coc.nvim', {'do': 'yarn install'}
Plug 'https://github.com/w0rp/ale'
Plug 'jlesquembre/base16-neovim'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ElmCast/elm-vim'

Plug 'leafgarland/typescript-vim'


Plug 'lervag/vimtex'
call plug#end()

set expandtab
set tabstop=4
set shiftwidth=4
set relativenumber
set clipboard=unnamed
let mapleader="m"
" Change EOF tilde to dot
set fcs=eob:·
" Hide status bar
nnoremap <Space> :
vnoremap <Space> :
nnoremap <Leader>n :e#<CR>
nnoremap <Leader>q :set background=light<CR>
set termguicolors "Remove this in urxvt
set background=light " or light if you prefer the light version
set t_Co=256
augroup MyColors
    autocmd!
    autocmd ColorScheme * highlight Normal cterm=NONE ctermbg=17 gui=NONE guibg=#fff
                      \ | highlight NonText cterm=NONE ctermbg=17 gui=NONE guibg=#fff
augroup END
colorscheme two-firewatch
let g:loaded_matchparen=1
inoremap <silent><C-i> :pc<cr>
"Spellcheck
autocmd FileType markdown setlocal spell

"---
"LATEX

autocmd FileType tex nnoremap <leader>m :!pdflatex %<CR><CR>:!bibtex %<<CR><CR>:!pdflatex %<CR><CR>:!pdflatex %<CR>
autocmd FileType tex setlocal spell



let g:LanguageClient_serverCommands = {
    \ 'reason': ['/home/marccoquand/reason-language-server/reason-language-server.exe'],
    \ }

nnoremap <silent> gd :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<cr>
nnoremap <silent> <cr> :call LanguageClient_textDocument_hover()<cr>

"---
"Ale
let g:ale_completion_enabled = 0
let g:ale_javascript_prettier_options = ' --stdin\ --parser\ flow\ --single-quote\ --trailing-comma\ all\ --no-bracket-spacing'
let g:ale_fixers = {'javascript': ['eslint'], 'css': ['prettier'], 'html': ['prettier'], 'markdown': ['prettier'], 'haskell': ['stylish-haskell'], 'latex': ['write-good'] }
let g:ale_enabled = 1
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

let g:ale_sign_error = '×'
let g:ale_sign_warning = '▵'
let g:ale_lint_on_text_changed = 'never'
function CheckIfFileExists(filename)
  if filereadable(a:filename)
    return 1
  endif

  return 0
endfunction

" Disable GHC linter if in a Haskell Stack project
if (CheckIfFileExists("./stack.yaml") == 1)
  let g:ale_linters = {
  \   'haskell': ['stack-build'], 
  \}
endif

nnoremap <leader> d :ALEDetail<cr>

"---
"Clear search highlight
nnoremap <silent><Leader><space> :noh<cr>

" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber
"---
"Denite 
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')

"---
"Colorcolumn
set textwidth=80
set cc=+1
fun! ToggleCC()
  if &cc == ''
    set cc=+1
  else
    set cc=
  endif
endfun
nnoremap <silent><Leader>w :call ToggleCC()<CR>



" ----
" NERDTree 
let NERDTreeShowLineNumbers=1
nnoremap <Leader>x :NERDTreeToggle<CR>
let g:NERDTreeStatusline = '%#NonText#'
let g:NERDTreeQuitOnOpen = 1

" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber


" ---
" coc

" if hidden not set, TextEdit might fail.
set hidden

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300


" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


"---
" Nerdcommenter
let g:NERDSpaceDelims = 1

"---
" REASONML
autocmd Filetype reason setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
