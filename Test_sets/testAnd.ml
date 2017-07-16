
(* esempio corretto *)
(* Ipotetica sintassi concreta
	true and true;
*)
run (And(EBool(true), EBool(true))) ;;

flush stdout ;;

(* esempio sbagliato *)
(* Ipotetica sintassi concreta
	true and 32;
*)
run (And(EBool(true), EInt(32))) ;;

