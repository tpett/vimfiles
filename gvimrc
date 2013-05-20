set guifont=Menlo\ For\ Powerline:h14
set linespace=2
set antialias

" Don't beep
set visualbell

" Start without the toolbar and disable scrollbars
set guioptions-=T
set guioptions-=rL

" Ignore horizontal scrolling
map <ScrollWheelLeft> <nop>
map <ScrollWheelRight> <nop>

if has("gui_macvim")
  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  "" Key Mappings
  macmenu &File.New\ Tab key=<D-T>
  map <D-t> :CtrlP<cr>
  map <D-/> <Plug>CommentaryLine
  vmap <D-/> <Plug>Commentary
end

augroup auto_close_nerdtree_au
  au!
  au WinEnter * call s:CloseIfOnlyNerdTreeLeft()
augroup END

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

