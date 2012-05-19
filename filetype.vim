"" Additional filetype detection support
""

" Setup coffeescript
au BufRead,BufNewFile *coffee set ft=coffee

" Setup Haproxy configs
au BufRead,BufNewFile haproxy* set ft=haproxy

" Treat JSON files like JavaScript
au BufNewFile,BufRead *.json set ft=javascript

" Setup less files
au BufRead,BufNewFile {*.less}    set ft=scss

" Add a few more file types to ruby syntax
au BufRead,BufNewFile {*.thor}    set ft=ruby

