
(* Correct example *)
run (Fun("t", TypeOfInt, Op("*", EInt(2), Ide("t")))) ;;

flush stdout ;;

(* Wrong example *)
run (Fun(Ide("t"), TypeOfInt, Op("*", EInt(2), Ide("t")))) ;;

