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

command W w !sudo tee % >/dev/null
set noexpandtab

callplug
Plug '~/.vim/pack/vendor/start/vim-easytags/plugin/easytags.vim'
callplug

callplug
Plug '~/.vim/pack/vendor/start/vim-misc/plugin/xolox/misc.vim'
callplug

callplug
Plug '~/.vim/pack/vendor/start/vim-nerdtree/nerdtree_plugin/vim-nerdtree-tabs.vim'
callplug

callplug
Plug '~/.vim/pack/vendor/start/vim-symlink/plugin/symlink.vim'
callplug
