
(* Correct example *)
(* Corresponding concrete syntax:
	let x = 5 in
		if x <= 99 then x
		else 13;
*)
run (Let("x", EInt(5), Ifthenelse(Op("<=", Ide("x"), EInt(99)), Ide("x"), EInt(13)))) ;; 

flush stdout ;;

(* Wrong example *)
(* Corresponding concrete syntax:
	let x = 5 in
		if x <= 99 then x
		else true;
*)
run (Let("x", EInt(5), Ifthenelse(Op("<=", Ide("x"), EInt(99)), Ide("x"), EBool(true)))) ;; 

