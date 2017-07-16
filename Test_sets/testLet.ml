
(* Correct example *)
run (Let("g", EInt(8), Op("+", Ide("g"), EInt(2)))) ;;

flush stdout ;;

(* Wrong example *)
run (Let(Ide("g"), EInt(8), Op("+", Ide("g"), EInt(2)))) ;;

