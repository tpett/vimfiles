set guifont=Menlo\ For\ Powerline:h14
set linespace=2
set antialias

" Don't beep
set visualbell

" Start without the toolbar and disable scrollbars
set guioptions-=T
set guioptions-=rL

if has("gui_macvim")
  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  "" Key Mappings
  macmenu &File.New\ Tab key=<D-T>
  map <D-t> :CommandTFlush<cr>\|:CommandT<cr>
  map <D-/> <Plug>CommentaryLine
  vmap <D-/> <Plug>Commentary
end

