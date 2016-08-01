" be IMproved
set nocompatible

" basic configuration
set background=dark            " use dark background
set history=1000               " long command history
set incsearch                  " search while typing
set linebreak                  " when wrapping, break at words
set number                     " line numbers
set scrolloff=5                " show 5 lines before after cursor
set showmatch                  " hghlight matching braket
set ttyfast                    " fast terminal connection
set wrap                       " wrap long lines
syntax on                      " enable syntax highlighting
set backspace=indent,eol,start " modify backspace behaviour
set mouse=a
set listchars=tab:▸\ ,eol:¬,trail:␣
set list

" train yourself not to use the arrow keys
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>
noremap <Up>    <NOP>

" indentation options
filetype plugin on
filetype plugin indent on " recognize indentation of filetype
set autoindent            " copy indent to newline
set expandtab             " expand tab into spaces when using < and > command
set shiftwidth=4          " number of spaces used for indentation
set tabstop=4             " number of spaces that form a tab

" filetype specific indentation
autocmd FileType html,htm,xml,css setlocal shiftwidth=2 tabstop=2      " web files
" autocmd FileType tex,sty setlocal shiftwidth=2 tabstop=2 softtabstop=2 " LaTeX files

" filetype recognition
autocmd BufRead,BufNewFile *.tex set filetype=tex
autocmd BufRead,BufNewFile *.tikz set filetype=tex
autocmd BufRead,BufNewFile *.pgfplot set filetype=tex

" function that compiles YouCompleteMe
function! BuildYouCompleteMe(info)
    if a:info.status != 'unchanged' || a:info.force
        !python2 ./install.py --clang-completer --system-libclang
    endif
endfunction

" load plugins with vim-plug
call plug#begin('~/.config/nvim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mhinz/vim-signify'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'scrooloose/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'valloric/YouCompleteMe', { 'do': function('BuildYouCompleteMe') }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" syntastic config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1 " automatically populate location list with found errors
let g:syntastic_auto_loc_list = 1            " automatically open7close loc list
let g:syntastic_check_on_open = 1            " perform check if buffer is first opened
let g:syntastic_check_on_wq   = 0            " skip checks if buffer is written with :wq
let g:syntastic_aggregate_errors = 1         " aggregate messages from multiple checkers
let g:syntastic_python_python_exec = "/usr/bin/python3"

" YouCompleteMe configuration
let g:ycm_auto_trigger = 1 " automatically trigger completion
let g:ycm_complete_in_comments = 0 " do not complete in comments
let g:ycm_complete_in_strings = 0 " do not complete in strings
let g:ycm_extra_conf_globlist = ["~/code/*"] " in these places .ycm_extra_conf.py files will be automatically loaded
let g:ycm_global_ycm_extra_conf = "~/.vim/ycm.py" " set a global default .ycm_extra_conf.py file
let g:ycm_seed_identifiers_with_syntax = 1 " seed syntastic database with language keywords
let g:ycm_python_binary_path = "/usr/bin/python3"

" airline configuration
set laststatus=2                               " give all windwos a status line
let g:airline#extensions#branch#enabled    = 1 " fugitive/lawrencium integration
let g:airline#extensions#syntastic#enabled = 1 " enable syntastic integration
let g:airline#extensions#tabline#enabled   = 1 " use enhanced tabline
let g:airline_solarized_normal_green       = 1 " use green in normal mode
let g:airline_powerline_fonts              = 0
let g:airline_left_sep                     = ''
let g:airline_right_sep                    = ''

" signify configuration
let g:signify_vcs_list = [ 'git' ]

" indent-guides config
let g:indent_guides_auto_colors           = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes     = ['help', 'nerdtree']
let g:indent_guides_guide_size            = 1
let g:indent_guides_start_level           = 2
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#073642 ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#073642 ctermbg=0

" map <C-k> <C-w><Up>
" map <C-j> <C-w><Down>
" map <C-l> <C-w><Right>
" map <C-h> <C-w><Left>
map <C-h> :bp<cr>
map <C-l> :bn<cr>

set spelllang=en

" http://llvm.org/svn/llvm-project/cfe/tags/RELEASE_371/final/tools/clang-format/
map <C-K> :pyf $HOME/.vim/clang-format.py<cr>
imap <C-K> <c-o>:pyf $HOME/clang-format.py<cr>

colorscheme solarized " use solarized color scheme
