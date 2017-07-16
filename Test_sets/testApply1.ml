
(* esempio corretto *)
(* Ipotetica sintassi concreta

	let h = fun (p:int) -> 2*p in
		h(7);
*)
run (Let("h", Fun("p", TypeOfInt, Op("*", EInt(2), Ide("p"))), Apply(Ide("h"), EInt(7)))) ;;

flush stdout ;;

(* esempio sbagliato *)
(* Ipotetica sintassi concreta

	let h = fun (p:int) -> 2*p in
		h(false);
*)
run (Let("h", Fun("p", TypeOfInt, Op("*", EInt(2), Ide("p"))), Apply(Ide("h"), EBool(false)))) ;;

