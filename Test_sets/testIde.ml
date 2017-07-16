
(* esempio corretto *)
(* Ipotetica sintassi concreta
	let y = false in y;
*)
run (Let("y", EBool(false), Ide("y"))) ;; 

flush stdout ;;

(* esempio sbagliato *)
(* Ipotetica sintassi concreta
	let y = false in z;
*)
run (Let("y", EBool(false), Ide("z"))) ;; 

