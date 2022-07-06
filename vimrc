unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

set wildmenu
set linebreak
set lazyredraw
set showmatch
set hlsearch
set incsearch
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
map <F5> :NERDTreeToggle<CR>
let g:fzf_preview_window = 'right:50%'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6  }  }

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
hi clear SpellBad
hi SpellBad term=reverse ctermbg=darkgreen

command W w !sudo tee % >/dev/null
set noexpandtab

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/autoload/plug.vim')

Plug 'hashivim/vim-terraform'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'vim-scripts/a.vim'
Plug 'Raimondi/delimitMate'
Plug 'jez/vim-superman'
Plug 'ntpeters/vim-better-whitespace'
Plug 'vim-scripts/HTML-AutoCloseTag'
Plug 'tpope/vim-surround'
Plug 'cdelledonne/vim-cmake'
Plug 'ludovicchabant/vim-gutentags'

call plug#end()
