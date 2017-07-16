
(* Correct example *)
(* Corresponding concrete syntax:
	try x with 50 in
		| x = 0 --> x + 1
		| x = 1 --> x - 1
		| _ --> x
*)
let patterns1 =
	(Ordinary(Op("=", Ide("x"), EInt(0)), Op("+", Ide("x"), EInt(1))))::
	(Ordinary(Op("=", Ide("x"), EInt(1)), Op("-", Ide("x"), EInt(1))))::
	(Default(Ide("x")))::[] in
		run (TryWith("x", EInt(50), patterns1)) ;; 

flush stdout ;;

(* Wrong example *)
(* Corresponding concrete syntax:
	try x with -1 in
		| x = 0 --> x + 1
		| x = 1 --> x - 1
*)
let patterns2 =
	(Ordinary(Op("=", Ide("x"), EInt(0)), Op("+", Ide("x"), EInt(1))))::
	(Ordinary(Op("=", Ide("x"), EInt(1)), Op("-", Ide("x"), EInt(1))))::[] in
		run (TryWith("x", EInt(-1), patterns2)) ;; 

