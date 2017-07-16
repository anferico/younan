
(* Correct example *)
(* Corresponding concrete syntax:
	not(false)
*)
run (Not(EBool(false))) ;; 

flush stdout ;;

(* Wrong example *)
(* Corresponding concrete syntax:
	not(0)
*)
run (Not(EInt(0))) ;; 

