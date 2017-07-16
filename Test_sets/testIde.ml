
(* Correct example *)
(* Corresponding concrete syntax:
	let y = false in y;
*)
run (Let("y", EBool(false), Ide("y"))) ;; 

flush stdout ;;

(* Wrong example *)
(* Corresponding concrete syntax:
	let y = false in z;
*)
run (Let("y", EBool(false), Ide("z"))) ;; 

