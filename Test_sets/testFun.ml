
run (Fun("t", TypeOfInt, Op("*", EInt(2), Ide("t")))) ;; (* esempio corretto *)

flush stdout ;;

run (Fun(Ide("t"), TypeOfInt, Op("*", EInt(2), Ide("t")))) ;; (* esempio sbagliato *)

