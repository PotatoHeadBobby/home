if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
let mapleader = ","
map <Leader> <Plug>(easymotion-prefix)
set wildmode=longest:full,full
set wildmenu
set nocompatible
filetype plugin on
syntax on
imap jj <Esc>
call plug#begin('~/.vim/plugged')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'https://github.com/easymotion/vim-easymotion'
Plug 'https://github.com/rking/ag.vim'
Plug 'vim-airline/vim-airline'
Plug 'justinmk/vim-sneak'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline-themes'
Plug 'https://github.com/tomtom/tcomment_vim'
Plug 'airblade/vim-gitgutter'
Plug 'morhetz/gruvbox'
Plug 'justinmk/vim-sneak'
Plug 'liuchengxu/vim-which-key'
Plug 'inkarkat/vim-mark'
Plug 'jlanzarotta/bufexplorer'
Plug 'inkarkat/vim-ingo-library'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'vimwiki/vimwiki'
call plug#end()
map <Leader>f :NERDTreeFind<CR>
map <Leader>o :NERDTreeToggle<CR>
map <Leader>b :browse oldfiles<CR>
map <f2> :w<CR>
map <f12> :only<CR>
map <f10> :BufExplorer<CR>
map <f11> :History<CR>
"map <F7> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
" map <expr> <F7> ':execute "Ggrep " . expand("<cword>") . " **/*." . expand('%:e') '
" map <expr> <F7> ':Ggrep ' . ' ' . expand('<cword>') . ' ' . expand('%:p:h') . ' **/*.' . expand('%:e')
 map <expr> <F7> ':Find ' . ' ' . expand('<cword>')
 nnoremap <F6> :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/iiii
 nnoremap ^[[1;5S :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i
":execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw
nnoremap ^[[1;5S :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i
map <C-PageUp> :cprev
map <C-PageDown> :cnext
let g:vimwiki_list = [{'path': '/mnt/d/Dropbox/vimwiki'}]
call vimwiki#vars#init()
map ^K :browse oldfiles^M
map ^[[18;2~  :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw

set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
set dictionary+=/home/ecajzel/dict.txt

"Open quickfix window
augroup QuickFixAutoload
    autocmd!
    autocmd QuickFixCmdPost [^l]* nested botright cwindow
    autocmd QuickFixCmdPost l* nested botright lwindow
augroup END

set incsearch
set hlsearch
set incsearch
set hlsearch
set ignorecase
set smartcase
set relativenumber
set history=5000

"mappings for unimpaired
nmap < [
nmap > ]
omap < [
omap > ]
xmap < [
xmap > ]

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

map <C-PgDn> :cnext
" Save session on quitting Vim
autocmd VimLeave * NERDTreeClose
autocmd VimLeave * mksession! mysession.vim

" Restore session on starting Vim
autocmd VimEnter * source mysession.vim
autocmd VimEnter * NERDTree
hi DiffAdd      ctermfg=NONE          ctermbg=Green
hi DiffChange   ctermfg=NONE          ctermbg=NONE
hi DiffDelete   ctermfg=LightBlue     ctermbg=Red
hi DiffText     ctermfg=Yellow        ctermbg=Red
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
colorscheme gruvbox
set bg=dark


set grepprg=ag\ --vimgrep
" set grepprg=git\ grep

function! Grep(...)
  return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost cgetexpr cwindow
  autocmd QuickFixCmdPost lgetexpr lwindow
augroup END


""""""""""""""""""""""""""""""""""""""""
"From https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2#.xgkib3w5f
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
"""""""""""""""""""""""""""""""""""""""

" tabstop:          Width of tab character
" softtabstop:      Fine tunes the amount of white space to be added
" shiftwidth        Determines the amount of whitespace to add in normal mode
" expandtab:        When this option is enabled, vi will use spaces instead of tabs
set tabstop     =2
set softtabstop =2
set shiftwidth  =2
set expandtab
set autoindent

"Switch to another buffer even though current contain unsaved changes
set hidden
map <C-n> :bn<CR>
map <C-p> :bp<CR>
"Insert new line below current line
nnoremap o o<Esc>k

if &diff
    set cursorline
    map ] ]c
    map [ [c
    hi DiffAdd    ctermfg=233 ctermbg=LightGreen guifg=#003300 guibg=#DDFFDD gui=none cterm=none
    hi DiffChange ctermbg=white  guibg=#ececec gui=none   cterm=none
    hi DiffText   ctermfg=233  ctermbg=yellow  guifg=#000033 guibg=#DDDDFF gui=none cterm=none
endif

" reselect pasted text
nnoremap gp `[v`]

