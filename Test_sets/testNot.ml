
(* esempio corretto *)
(* Ipotetica sintassi concreta
	not(false)
*)
run (Not(EBool(false))) ;; 

flush stdout ;;

(* esempio sbagliato *)
(* Ipotetica sintassi concreta
	not(0)
*)
run (Not(EInt(0))) ;; 

