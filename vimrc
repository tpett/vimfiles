""
"" Thanks:
""   Gary Bernhardt  <destroyallsoftware.com>
""   Drew Neil  <vimcasts.org>
""   Tim Pope  <tbaggery.com>
""   Janus  <github.com/carlhuda/janus>
""   Mislav Marohnić <https://github.com/mislav/vimfiles>

" Basic Setup

set nocompatible
syntax enable
set encoding=utf-8

runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()     " load pathogen

filetype plugin indent on  " setup filetype detection

" Look and Feel

set background=dark
let g:zenburn_high_Contrast=1
let g:zenburn_old_Visual = 1
color zenburn

set number         " show line numbers
set ruler          " show the cursor position all the time
set showcmd        " display incomplete commands
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
set backspace=indent,eol,start    " backspace through everything in insert mode

augroup whitespace_au
  au!
  " in Makefiles, use real tabs, not tabs expanded to spaces
  au FileType make set noexpandtab
  " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79
augroup END

" List chars
set listchars=""                  " reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen

" Searching

set hlsearch                      " highlight matches
set incsearch                     " incremental searching
set ignorecase                    " searches are case insensitive...
set smartcase                     " ... unless they contain at least one capital letter

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

" Quick switch to last buffer
nnoremap <leader>l <c-^>

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

if has("statusline") && !&cp
  set laststatus=2  " always show the status bar
endif

" Bufexplorer
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1

" CommandT
let g:CommandTMaxHeight=10
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>

"" Misc

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

