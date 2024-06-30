syntax on

" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()
set expandtab
set tabstop=2
set smartcase
set shiftwidth=2
set ai
set number
autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
set belloff=all
autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
autocmd VimLeave * silent !stty ixon

set nohlsearch
set incsearch
set ruler
set mouse=a
set ttymouse=xterm
set clipboard=unnamed
set backspace=indent,eol,start
set t_Co=256
set background=dark
set guifont="DroidSansMono Nerd Font"

set rtp+=/usr/local/opt/fzf

nnoremap <Leader>vr :source ~/.vimrc<CR>
let mapleader = " "
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>s :sp<CR>
nnoremap <leader>v :vsp<CR>
nnoremap <leader><Left> :vertical resize -5<cr>
nnoremap <leader><Up> :resize +5<cr>
nnoremap <leader><Down> :resize -5<cr>
nnoremap <leader><Right> :vertical resize +5<cr>

nnoremap <leader>r "hy:%s/<C-r>h//g<left><left>
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

let g:airline_powerline_fonts = 1
let g:airline_theme = 'term'
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 0
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

hi MatchParen ctermfg=15 ctermbg=239 cterm=bold guibg=NONE guifg=NONE gui=bold
