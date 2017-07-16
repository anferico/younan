
(* esempio corretto *)
(* Ipotetica sintassi concreta
	let c = 3 in
		c + 5;
*)
run (Let("c", EInt(3), Op("+", Ide("c"), EInt(5)))) ;; 

flush stdout ;;

(* esempio sbagliato *)
(* Ipotetica sintassi concreta
	let c = fun (z:bool) -> z in
		c + 5;
*)
run (Let("c", Fun("z", TypeOfBool, Ide("z")), Op("+", Ide("c"), EInt(5)))) ;; 
