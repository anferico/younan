
(* Correct example *)
run (EInt(47)) ;;

flush stdout ;;

(* Wrong example *)
run (EInt("somestring")) ;;

