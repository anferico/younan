
(* Correct example *)
(* Corresponding concrete syntax: true and true *)
run (And(EBool(true), EBool(true))) ;;

flush stdout ;;

(* Wrong example *)
(* Corresponding concrete syntax: true and 32 *)
run (And(EBool(true), EInt(32))) ;;

