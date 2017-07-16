
run (Let("g", EInt(8), Op("+", Ide("g"), EInt(2)))) ;; (* esempio corretto *)

flush stdout ;;

run (Let(Ide("g"), EInt(8), Op("+", Ide("g"), EInt(2)))) ;; (* esempio sbagliato *)

