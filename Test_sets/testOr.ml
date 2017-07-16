
(* esempio corretto *)
(* Ipotetica sintassi concreta
	false or false;
*)
run (Or(EBool(false), EBool(false))) ;;

flush stdout ;;

(* esempio sbagliato *)
(* Ipotetica sintassi concreta
	true or 25;
*)
run (Or(EBool(true), EInt(25))) ;;

