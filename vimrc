syntax on

set smartindent
set mouse=a
set nu
set nowrap
set ruler
set showmatch
set hlsearch
set clipboard=unnamed
set backspace=indent,eol,start " Fix backspace...
helptags ~/.vim/doc

" To make sure always the working dir is same as the windows's
if $TERM == "xterm" 
    set autochdir
endif

au! BufEnter * silent! lcd %:p:h
"set autochdir


" for libraries
call pathogen#infect()

let g:JSLintHighlightErrorLine = 0

" File types and plugins
au! BufRead,BufNewFile *.coffee set filetype=coffee
au! BufRead,BufNewFile *.less set filetype=less
au! BufRead,BufNewFile *.json set filetype=json

fun! s:DetectNode()
    if getline(1) == '#!/usr/bin/env node'
        set ft=javascript
    endif
endfun

autocmd BufNewFile,BufRead * call s:DetectNode()

filetype indent on
filetype plugin on

" for tabs
set ts=4
set expandtab
set sw=4

vnoremap > >gv
vnoremap < <gv
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
imap <S-Tab> <Esc><<i

" make tab do tabs at beginning and spaces elsewhere
function! VaryTabs()
  if &expandtab
    return "\<Tab>"
  else
    let nonwhite = matchend(getline('.'),'\S')
    if nonwhite < 0 || col('.') <= nonwhite
      return "\<Tab>"
    else
      let pos = virtcol('.')
      let num = pos + &tabstop
      let num = num - (num % &tabstop) - pos +1
      return repeat(" ",num)
    endif
  endif
endfunction
inoremap <Tab> <C-R>=VaryTabs()<CR>

set background=dark
