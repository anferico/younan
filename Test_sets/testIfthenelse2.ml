
(* Correct example *)
(* Corresponding concrete syntax:
	let x = 5 in
		if x = 10 then x
		else 20;
*)
run (Let("x", EInt(5), Ifthenelse(Op("=", Ide("x"), EInt(10)), Ide("x"), EInt(20)))) ;;

flush stdout ;;

(* Wrong example *)
(* Corresponding concrete syntax:
	let x = 5 in
		if x - 10 then x
		else 20;
*)
run (Let("x", EInt(5), Ifthenelse(Op("-", Ide("x"), EInt(10)), Ide("x"), EInt(20)))) ;;

