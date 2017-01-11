" .vimrc
"if 700 > v:version | finish | endif

colo elflord
syntax on
:match ErrorMsg '\%80v.'
set textwidth=79

set noautoindent
set showcmd
set incsearch
"set showmatch
"set ignorecase
"set smartcase
"set autowrite

let mapleader="-"
set foldmethod=marker

set listchars=eol:\|,tab:@>,trail:%
set list
set laststatus=2

set statusline=%t         " tail of file name (last part of file name)
set statusline+=%m        " modified flag
set statusline+=%r        " readonly flag
set statusline+=[%{&ff}]  " fileformat (unix, dos, mac)
set statusline+=%y        " filetype
set statusline+=%=        " left align / right align separator
set statusline+={%c%V}    " column number, virtual column number
set statusline+=[%l/%L]   " line number / total lines
set statusline+=[0x%O]    " byte number in file
set statusline+={0x%B}    " value of byte under cursor
set statusline+=%P        " percentage through file

":%!xxd     " hex editor
":%!xxd -r  " restore from hex

"filetype indent on
" don't use filetype plugins, write indents by hand
if has("autocmd")
  autocmd FileType python,java set expandtab shiftwidth=4 softtabstop=4 ai
  autocmd FileType vim,sql,xml set expandtab shiftwidth=2 softtabstop=2 ai
  autocmd FileType c,cpp       set cindent comments=sr:/*,mb:*,ex:*/,://
  autocmd FileType mail        set textwidth=72

  autocmd BufRead,BufNewFile *.md set filetype=markdown
endif

