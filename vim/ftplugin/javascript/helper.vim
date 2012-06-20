
" Mocha
" example
"
" write "it THEN it should be ok" and press <C-m>m
" you will end up with a mocha style function

map mm <esc>^0"mdd:call Mocha()<CR>

function! Mocha()
  let str = getreg('m')
  let arr = split(str, ' ')
  let cmd = arr[0]
  let str = join(arr[1:-2], ' ')
  exec "norm i" . cmd . "('" . str  . "', function() {\n\n})"
  exec "norm ki" 
endfunction


" Creating functions
" Write "ab ab1 ab2", press <C-m>f 
" you will end up with this:
" function ab(ab1, ab2){
" }
" Prepend ". " to make it anonymous

map mf :set opfunc=JsFunc<CR>g@

function! JsFunc(type, ...)
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@
  if a:0  " Invoked from Visual mode, use '< and '> marks.
    silent exe "normal! `<" . a:type . "`>\"ad"
  elseif a:type == 'line'
    silent exe "normal! '[V']\"ad"
  elseif a:type == 'block'
    silent exe "normal! `[\<C-V>`]\"ad"
  else
    silent exe "normal! `[v`]\"ad"
  endif
  silent exe 'normal! "Ax'

  let arr = split(substitute(getreg('a'), '\s*$', '', 'g'), ' ')

  if len(arr) == 0
    let name = ''
  else
    let name = arr[0]
  
    if name == '.'
      let name = '' 
    endif 
  endif
     
  let args = join(arr[1:], ', ')

  exec "norm ifunction " . name . "(" . args . ") {\n\n}"
  exec "norm ki" 
  let &selection = sel_save
endfunction	

map mv "myiw:call AddVar()<CR>

function! AddVar()
  let pos = getpos('.')
  let fmatch = search('function\(\n\|[^{]\)*{', 'be')
  let fpos = getpos('.')
  
  if fmatch == 0
    let fpos = [pos[0], 0, 0, 0]
    call setpos('.', fpos)
    let end = line('$')
  else
    exec 'normal! %'
    let end = line('.')
    call setpos('.', fpos)
  endif

  let spos = search('var\_.*;', 'c', end)

  if spos == 0 
    let pos[1] = pos[1] + 2
    exec "normal! a\nvar ". getreg('m') . ";\n"
  else
    call search(';')
    exec 'normal! i, '. getreg('m')
  endif 
  call setpos('.', pos)
endfunction

map mr mv"_dd:call Req()<CR>

function! Req()
  let str = getreg('"')
  exec "normal! $a\n" . str . " = require('" . str . "');"

endfunction

