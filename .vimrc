""" Header
" Author: Mathias
set nocompatible              " be iMproved, required

"" Plugins
""" VimPlug
if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

""" Plugins
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'tpope/vim-surround'
Plug 'vim-python/python-syntax'
Plug '907th/vim-auto-save'
Plug 'lervag/vimtex'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tmhedberg/simpylfold'
Plug 'konfekt/fastfold'
Plug 'SirVer/ultisnips' ", { 'on': [] }
Plug 'honza/vim-snippets'
Plug 'valloric/youcompleteme' ", { 'on': [] }
Plug 'mbbill/undotree', { 'on':  'UndotreeToggle' }
Plug 'roman/golden-ratio'
Plug 'ambv/black'
Plug 'cjrh/vim-conda'
Plug 'matze/vim-move'
Plug 'godlygeek/tabular'
Plug 'michaeljsmith/vim-indent-object'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'reedes/vim-pencil'
Plug 'vim-pandoc/vim-pandoc'

"Plug 'rafaqz/ranger.vim'
" Plug 'tpope/vim-fugitive'

"Plug 'MPage'

"augroup load_us_ycm
    "autocmd!
    "autocmd InsertEnter * call plug#load('ultisnips', 'youcompleteme')
        "\| autocmd! load_us_ycm
"augroup END
call plug#end()

"" Vim
""" Settings
set number
set ignorecase
set showmatch
set incsearch
set hlsearch
set nolist
set mouse=a
set cursorline
set wildmenu
set ttimeoutlen=50
set encoding=utf-8
set clipboard=unnamedplus

filetype plugin indent on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set textwidth=80
set undofile
set undodir=~/.vim/undo/
set wrap

set laststatus=2
set shortmess=F
set noshowmode
highlight LineNr ctermbg=None
""" Mappings
map <Space> <Leader>
imap jk <Esc>
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
noremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <Leader>R :source $MYVIMRC<CR>
nnoremap B ^
nnoremap E $
nnoremap <leader>u :UndotreeToggle<cr>

""" Folding
set foldenable
set foldlevel=1

function! VimFolds(lnum)
  let s:thisline = getline(a:lnum)
  if match(s:thisline, '^"" ') >= 0
    return '>2'
  endif
  if match(s:thisline, '^""" ') >= 0
    return '>3'
  endif
  let s:two_following_lines = 0
  if line(a:lnum) + 2 <= line('$')
    let s:line_1_after = getline(a:lnum+1)
    let s:line_2_after = getline(a:lnum+2)
    let s:two_following_lines = 1
  endif
  if !s:two_following_lines
      return '='
    endif
  else
    if (match(s:thisline, '^"""""') >= 0) &&
       \ (match(s:line_1_after, '^"  ') >= 0) &&
       \ (match(s:line_2_after, '^""""') >= 0)
      return '>1'
    else
      return '='
    endif
  endif
endfunction

function! VimFoldText()
  " handle special case of normal comment first
  let s:info = '('.string(v:foldend-v:foldstart).' l)'
  if v:foldlevel == 1
    let s:line = ' +- '.getline(v:foldstart+1)[3:-2]
  elseif v:foldlevel == 2
    let s:line = ' +--  '.getline(v:foldstart)[3:]
  elseif v:foldlevel == 3
    let s:line = ' +--- '.getline(v:foldstart)[4:]
  elseif v:foldlevel == 4
    let s:line = ' +---- '.getline(v:foldstart)[5:]
  endif
  if strwidth(s:line) > 80 - len(s:info) - 3
    return s:line[:79-len(s:info)-3+len(s:line)-strwidth(s:line)].'...'.s:info
  else
    return s:line.repeat(' ', 80 - strwidth(s:line) - len(s:info)).s:info
  endif
endfunction

augroup fold_vimrc
  autocmd!
  autocmd FileType vim 
       \ setlocal foldmethod=expr |
       \ setlocal foldexpr=VimFolds(v:lnum) |
       \ setlocal foldtext=VimFoldText() |
       \ setlocal foldlevel=2 |
    "              \ set foldcolumn=2 foldminlines=2
augroup END

""


""" Autocmd
augroup pencil
  autocmd!
  "autocmd FileType markdown,mkd,tex call pencil#init()
  autocmd FileType markdown,mkd,tex set spell
  "autocmd FileType text         call pencil#init()
augroup END

"" Plugin settings
""" FZF
let g:fzf_colors =
  \ { 'fg':    ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" This is the default extra key bindings
 let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }

 " Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'left': '~40%' }
nnoremap <silent> <leader>f :FZF<cr>
nnoremap <silent> <leader>F :FZF ~<cr>

""" NerdTree
nmap <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

""" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']

""" Ultisnips
"let g:UltiSnipsExpandTrigger       = "<Tab>"
"let g:UltiSnipsJumpForwardTrigger  = "<Tab>"
"let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"
"let g:UltiSnipsExpandTrigger       = "<c-tab>"
"let g:UltiSnipsJumpForwardTrigger  = "<tab>"
"let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
"let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:ultisnips_python_style       = "google"

""" Lightline
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ }
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

""" Vimux
map <Leader>rb :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vi :VimuxInspectRunner<CR>
map <Leader>vq :VimuxCloseRunner<CR>
map <Leader>vx :VimuxInterruptRunner<CR>
map <Leader>vz :call VimuxZoomRunner()<CR>
"let g:vimtex_fold_enabled=1
"let g:vimtex_fold_complete_close_braces=1
"let g:vimtex_fold_manual=1
"set foldmethod=expr

""" Ranger
map <leader>rr :vertical terminal ranger<CR>
"map <leader>rr :RangerEdit<cr>
"map <leader>rv :RangerVSplit<cr>
"map <leader>rs :RangerSplit<cr>
"map <leader>rt :RangerTab<cr>
"map <leader>ri :RangerInsert<cr>
"map <leader>ra :RangerAppend<cr>
"map <leader>rc :set operatorfunc=RangerChangeOperator<cr>g@
"map <leader>rd :RangerCD<cr>
"map <leader>rld :RangerLCD<cr>

""" Vim-move
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

""" Autosave
let g:auto_save = 0  " enable AutoSave on Vim startup

""" Vimtex
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
au VimEnter * let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme
au FileType tex,plaintex set foldmethod=expr
au FileType tex,plaintex set foldexpr=vimtex#fold#level(v:lnum)
au FileType tex,plaintex set foldtext=vimtex#fold#text()

""" Goyo
let g:Goyo_width = 100
"" Language specific
""" Python 
let g:python_highlight_all = 1
let g:python_space_error_highlight = 0
"let g:python_highlight_string_format = 
nnoremap <leader>r :w !python3<cr>

