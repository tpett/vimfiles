""
"" Thanks:
""   Gary Bernhardt  <destroyallsoftware.com>
""   Drew Neil  <vimcasts.org>
""   Tim Pope  <tbaggery.com>
""   Janus  <github.com/carlhuda/janus>
""   Mislav Marohnić <https://github.com/mislav/vimfiles>

" Basic Setup

set nocompatible

filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()


Bundle 'Lokaltog/powerline'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'danro/rename.vim'
Bundle 'elixir-lang/vim-elixir'
Bundle 'ervandew/supertab'
Bundle 'jnurmine/Zenburn'
Bundle 'jnwhiteh/vim-golang'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'nono/vim-handlebars'
Bundle 'pangloss/vim-javascript'
Bundle 'rizzatti/dash.vim'
Bundle 'rizzatti/funcoo.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'vim-ruby/vim-ruby'
Bundle 'vim-scripts/bufexplorer.zip'
Bundle 'vim-scripts/greplace.vim'
Bundle 'xenoterracide/html.vim'

set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

filetype plugin indent on  " setup filetype detection

" Look and Feel

set background=dark
let g:zenburn_high_Contrast=1
let g:zenburn_old_Visual = 1
color zenburn

set relativenumber " show relative line numbers
set cursorline     " highlight current line
set cursorcolumn   " highlight current column
set scrolloff=3    " provide some context when editing
set nostartofline  " don't jump to first character when paging

" Remove line/column selection on inactive panes
augroup position_selection_au
  au!
  au WinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
  au WinEnter * setlocal cursorcolumn
  au WinLeave * setlocal nocursorcolumn
augroup END

" Remember last location in file, but not for commit messages.
" see :help last-position-jump
augroup remember_position_au
  au!
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif
augroup END

" Allow backgrounding buffers without writing them, and remember marks/undo
" for backgrounded buffers
set hidden

" Whitespace

set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " show invisible characters

augroup whitespace_au
  au!
  " in Makefiles, use real tabs, not tabs expanded to spaces
  au FileType make set noexpandtab
  " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79
  " Make go 4 space tabs
  au FileType go set softtabstop=4 tabstop=4 shiftwidth=4
augroup END

" Searching

set hlsearch                      " highlight matches
set ignorecase                    " searches are case insensitive...
set smartcase                     " ... unless they contain at least one capital letter

" Tab completion behavior
set wildmode=longest,list,full

" Syntax

let python_highlight_all=1    " use verbose syntax highlight in Python
let ruby_operators=1          " options for Ruby syntax highlighting

" Folding

augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

" General Mappings

let mapleader=","

" don't use Ex mode, use Q for formatting
map Q gq

" clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" more natural split behavior
set splitbelow
set splitright

" disable cursor keys in normal mode
map <Left>  :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up>    :echo "no!"<cr>
map <Down>  :echo "no!"<cr>

" remap F1 for great good
map <F1> <Esc>
imap <F1> <Esc>

" quick remove trailing whitespace
command! KillWhitespace :normal :%s/ *$//g<cr><c-o><cr>
map <leader>w :KillWhitespace<cr>

" Quick edit this file
map <leader>v :sp $MYVIMRC<CR><C-W>_
map <silent> <leader>V :source $MYVIMRC<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" Spelling
map <leader>s :set spell! <CR>
set spelllang=en_us

" visually select last inserted text
nmap gV `[v`]

" nicer line front/end movement keys
nnoremap H ^
nnoremap L $

" Plugin Mappings / Configs

" Gundo
nnoremap <F5> :GundoToggle<CR>

" Fugitive shortcuts
nnoremap <Leader>ggs :Gstatus<CR>
nnoremap <Leader>ggb :Gblame<CR>
nnoremap <Leader>ggd :Gdiff<CR>
nnoremap <Leader>ggr :Gread<CR>
nnoremap <Leader>ggl :Glog<CR>

augroup fugitive_buffer_delete_au
  au!
  " Auto delete fugitive buffers
  au BufReadPost fugitive://* set bufhidden=delete
augroup END

" Powerline
let g:Powerline_symbols = 'fancy'

" Bufexplorer
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1

"" Misc

" History
set backupdir=~/.vim/_data/backup    " where to put backup files.
set directory=~/.vim/_data/swap      " where to put swap files.
set undodir=~/.vim/_data/undo        " where to put undo files.
set undofile                         " store undo data in a file

" turns wrapping on for a file
function! s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=72
endfunction

" Make sure all mardown files have the correct filetype set and setup wrapping
augroup text_wrapping_au
  au!
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown | call s:setupWrapping()
augroup END

augroup gitcommit_au
  au!
  au Filetype gitcommit setlocal spell textwidth=72
augroup END

" NERDTree
map <Leader>n :NERDTreeToggle<CR>
map <Leader>r :NERDTreeFind<CR>
let NERDTreeSortOrder=['*', '\.swp$', '\.bak$', '\~$']

" Use xmllint for indenting XML
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

" Custom leaders
map <leader>t :!rspec . --no-color<cr>
nnoremap <leader>l <c-^>
map <leader>d :Dash<cr>
map <leader>ot :sp ~/Dropbox/Documents/current-project-todos.md<CR><C-W>_

