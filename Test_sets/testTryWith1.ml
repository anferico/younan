
(* Correct example *)
(* Corresponding concrete syntax:
	try x with 50 in
		| x <= 0 --> x + 1
		| not(x <= 10) --> x - 1
		| _ --> x
*)
let patterns1 =
	(Ordinary(Op("<=", Ide("x"), EInt(0)), Op("+", Ide("x"), EInt(1))))::
	(Ordinary(Not(Op("<=", Ide("x"), EInt(10))), Op("-", Ide("x"), EInt(1))))::
	(Default(Ide("x")))::[] in
		run (TryWith("x", EInt(50), patterns1)) ;;

flush stdout ;;

(* Wrong example *)
(* Corresponding concrete syntax:
	try x with 50 in
		| x <= 0 --> x + 1
		| not(x <= 10) --> x = 15
		| _ --> x
*)
let patterns2 =
	(Ordinary(Op("<=", Ide("x"), EInt(0)), Op("+", Ide("x"), EInt(1))))::
	(Ordinary(Not(Op("<=", Ide("x"), EInt(10))), Op("=", Ide("x"), EInt(15))))::
	(Default(Ide("x")))::[] in
		run (TryWith("x", EInt(50), patterns2)) ;;

