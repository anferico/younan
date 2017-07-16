
(* Correct example *)
(* Corresponding concrete syntax:
	false or false;
*)
run (Or(EBool(false), EBool(false))) ;;

flush stdout ;;

(* Wrong example *)
(* Corresponding concrete syntax:
	true or 25;
*)
run (Or(EBool(true), EInt(25))) ;;

