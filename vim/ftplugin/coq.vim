call coquille#FNMapping()
call coquille#Launch()
let g:coquille_auto_move = 'true'
hi CheckedByCoq ctermbg=5
call tcomment#DefineType('coq', '(* %s *)')
