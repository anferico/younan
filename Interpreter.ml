
type ide = string ;;

(* Polymorphic environment *)
type 't environment = (ide * 't) list ;;

(* Value types *)
type valueType =
	  TypeOfInt
	| TypeOfBool
	| TypeOfFun of valueType * valueType 
	| Unknown ;;

(* Allowed typed expressions *)
type typedExpression =
	  EInt of int
	| EBool of bool
	| Fun of ide * valueType * typedExpression
	| Ide of ide
	| And of typedExpression * typedExpression
	| Or of typedExpression * typedExpression
	| Not of typedExpression
	| Op of string * typedExpression * typedExpression
	| Ifthenelse of typedExpression * typedExpression * typedExpression
	| Let of ide * typedExpression * typedExpression
	| Apply of typedExpression * typedExpression
	| TryWith of ide * typedExpression * pattern list
and pattern =
	  Default of typedExpression
	| Ordinary of typedExpression * typedExpression ;;

(* Expressible values *)
type expressibleValue = 
	  Int of int
	| Bool of bool
	| Funval of closure
	| Unbound
(* Function closure *)
and closure = typedExpression * expressibleValue environment * valueType environment ;;

(* Gets the value associated with the specified identifier from the environment *)
let rec applyEnv ((env: expressibleValue environment), (idtf: ide)) = match env with
	  [] -> Unbound
	| (id, vl)::rest -> if id = idtf then vl
						else applyEnv(rest, idtf) ;;

(* Gets the type associated with the specified identifier from the environment *)				
let rec applyTenv ((tenv: valueType environment), (idtf: ide)) = match tenv with
	  [] -> Unknown
	| (id, tp)::rest -> if id = idtf then tp
						else applyTenv(rest, idtf) ;;

(* Gets the type of the specified exression *)
let rec typeof ((tenv: valueType environment), (exp: typedExpression)) = match exp with
	  EInt(n) -> TypeOfInt
	| EBool(bl) -> TypeOfBool
	| Fun(id, ptyp, bd) -> 
	      let tenv1 = (id, ptyp)::tenv in 
	          TypeOfFun(ptyp, typeof(tenv1, bd))
	| Ide(id) -> applyTenv(tenv, id)
	| And(exp1, exp2) -> (match (typeof(tenv, exp1), typeof(tenv, exp2)) with
						 	   (TypeOfBool, TypeOfBool) -> TypeOfBool
						 	 | (_, _) -> failwith("'And' requires two boolean arguments."))
	| Or(exp1, exp2) -> (match (typeof(tenv, exp1), typeof(tenv, exp2)) with
						 	  (TypeOfBool, TypeOfBool) -> TypeOfBool
						 	| (_, _) -> failwith("'Or' requires two boolean arguments."))
	| Not(exp1) -> (match typeof(tenv, exp1) with
				         TypeOfBool -> TypeOfBool
				       | _ -> failwith("'Not' requires a boolean argument."))
	| Op(op, exp1, exp2) -> (match (typeof(tenv, exp1), typeof(tenv, exp2)) with
								  (TypeOfInt, TypeOfInt) -> (match op with
									  					          "+" -> TypeOfInt
														        | "-" -> TypeOfInt
														        | "*" -> TypeOfInt
									                            | "=" -> TypeOfBool
									                            | "<=" -> TypeOfBool
															    | _ -> failwith("Unknown operator"))
								| (_, _) -> failwith("'Op' requires two integer arguments."))						
	| Ifthenelse(grd, th, el) -> (match typeof(tenv, grd) with
							 		  TypeOfBool -> 
							 		      let t1 = typeof(tenv, th) and t2 = typeof(tenv, el) in
									 		      if t1 != t2 then 
									 		          failwith("then branch's type and else branch's type do not match.")
									 		      else t1
							 		 | _ -> failwith("Non-boolean guard."))
	| Let(id, vl, bd) -> let tenv1 = (id, typeof(tenv, vl))::tenv in
						     typeof(tenv1, bd)
	| Apply(f, arg) -> (match typeof(tenv, f) with
					        TypeOfFun(at, rt) ->
					            let argtype = typeof(tenv, arg) in
					                if at != argtype then
					                    failwith("Actual parameter's type and formal parameter's type do not match.")
					            	else rt
					       | _ -> failwith("First argument of 'Apply' must be of functional type."))
	| TryWith(id, exp1, pt) ->
	 	  let tenv1 = (id, typeof(tenv, exp1))::tenv in
	          (match pt with
	           	    [] -> failwith("No patterns were specified.")
	              | Default(bd)::remn ->
	                    let t1 = typeof(tenv1, bd) in
					 	    let t2 = if remn != [] then typeof(tenv1, TryWith(id, exp1, remn)) else t1 in
					  	        if t1 != t2 then
					  			    failwith("'TryWith' brackets must be all of the same type.")
					  			else t1
	              | Ordinary(grd, bd)::remn ->
	               	    (match typeof(tenv1, grd) with
						    TypeOfBool ->
						        let t1 = typeof(tenv1, bd) in
					  		 		let t2 = if remn != [] then typeof(tenv1, TryWith(id, exp1, remn)) else t1 in
							  	        if t1 != t2 then
							  			    failwith("'TryWith' brackets must be all of the same type.")
							  			else t1
						  | _ -> failwith("Non-boolean pattern guard."))) ;;

(* Gets the semantics of the specified expression *)
let rec semantics ((exp: typedExpression), (env: expressibleValue environment), (tenv: valueType environment))
	= match exp with
	
	  EInt(n) -> Int(n)
	| EBool(bl) -> Bool(bl)
	| Fun(id, ptyp, bd) -> Funval(exp, env, tenv)
	| Ide(id) -> applyEnv(env, id)
	| And(exp1, exp2) -> (match (typeof(tenv, exp1), typeof(tenv, exp2)) with
						 	   (TypeOfBool, TypeOfBool) -> 
						 	       let ex1 = semantics(exp1, env, tenv)
						 	       and ex2 = semantics(exp2, env, tenv) in 
						 	          (match (ex1, ex2) with
						 	                (Bool(e1), Bool(e2)) -> Bool(e1 && e2)
						 	              | (_, _) -> failwith("Two boolean expressions required."))
						 	 | (_, _) -> failwith("'And' requires two boolean arguments."))
	| Or(exp1, exp2) -> (match (typeof(tenv, exp1), typeof(tenv, exp2)) with
						 	   (TypeOfBool, TypeOfBool) -> 
						 	       let ex1 = semantics(exp1, env, tenv)
						 	       and ex2 = semantics(exp2, env, tenv) in 
						 	          (match (ex1, ex2) with
						 	                (Bool(e1), Bool(e2)) -> Bool(e1 || e2)
						 	              | (_, _) -> failwith("Two boolean expressions required."))
						 	 | (_, _) -> failwith("'Or' requires two boolean arguments."))
	| Not(exp1) -> (match typeof(tenv, exp1) with
						 	   TypeOfBool -> 
						 	       let ex1 = semantics(exp1, env, tenv) in 
						 	          (match ex1 with
						 	                Bool(e1) -> Bool(not(e1))
						 	              | _ -> failwith("Boolean expression required."))
						 	 | _ -> failwith("'Not' requires a boolean argument."))
	| Op(op, exp1, exp2) -> (match (typeof(tenv, exp1), typeof(tenv, exp2)) with
								  (TypeOfInt, TypeOfInt) ->
								  	  let ex1 = semantics(exp1, env, tenv)
						 	          and ex2 = semantics(exp2, env, tenv) in
						 	          	  (match (ex1, ex2) with
						 	          	      (Int(e1), Int(e2)) ->
												  (match op with
							  					          "+" -> Int(e1 + e2)
														| "-" -> Int(e1 - e2)
														| "*" -> Int(e1 * e2)
											            | "=" -> Bool(e1 = e2)
											            | "<=" -> Bool(e1 <= e2)
														| _ -> failwith("Unknown operator."))
											| (_, _) -> failwith("Two integer expressions required."))
								| (_, _) -> failwith("'Op' requires two integer arguments."))						
	| Ifthenelse(grd, th, el) -> let guard = semantics(grd, env, tenv) in
								 	(match typeof(tenv, grd) with
								 		  TypeOfBool ->
									 		  let t1 = typeof(tenv, th) and t2 = typeof(tenv, el) in
									 		      if t1 != t2 then 
									 		          failwith("then branch's type and else branch's type do not match.")
									 		      else
											 		  if guard = Bool(true) then
														  semantics(th, env, tenv)
													  else
														  semantics(el, env, tenv)
								 		| _ -> failwith("Non-boolean guard."))
	| Let(id, vl, bd) -> let env1 = (id, semantics(vl, env, tenv))::env
						 and tenv1 = (id, typeof(tenv, vl))::tenv in
						     semantics(bd, env1, tenv1)
	| Apply(f, arg) -> (match semantics(f, env, tenv) with
					         Funval(Fun(id, atyp, bd), declenv, decltypenv) ->
					             let argtype = typeof(tenv, arg) in
					                 if atyp != argtype then
					                     failwith("Actual parameter's type and formal parameter's type do not match.")
					            	 else
					            	 	 let declenv1 = (id, semantics(arg, env, tenv))::declenv
					            	 	 and decltypenv1 = (id, atyp)::decltypenv in
					       	         		 semantics(bd, declenv1, decltypenv1)
					       | _ -> failwith("First argument of 'Apply' must be of functional type."))
	| TryWith(id, exp1, pt) ->
	      let env1 = (id, semantics(exp1, env, tenv))::env
	 	  and tenv1 = (id, typeof(tenv, exp1))::tenv in
	          (match pt with
	           	    [] -> failwith("Could not match any pattern. Maybe you are missing the default pattern?")
	              | Default(bd)::remn ->
	                    let t1 = typeof(tenv1, bd) in
					 	    let t2 = if remn != [] then typeof(tenv1, TryWith(id, exp1, remn)) else t1 in
					  	        if t1 != t2 then
					  			    failwith("'TryWith' brackets must be all of the same type.")
					  			else
					  			    semantics(bd, env1, tenv1)
	              | Ordinary(grd, bd)::remn ->
	               	    (match typeof(tenv1, grd) with
						    TypeOfBool ->
						         let t1 = typeof(tenv1, bd) in
					  		 		 let t2 = if remn != [] then typeof(tenv1, TryWith(id, exp1, remn)) else t1
					  		 		 and guard = semantics(grd, env1, tenv1) in
							  	         if t1 != t2 then
							  			     failwith("'TryWith' brackets must be all of the same type.")
							  			 else
							  			     if guard = Bool(true) then
							  			         semantics(bd, env1, tenv1)
							  			     else
							  			      	 semantics(TryWith(id, exp1, remn), env, tenv)
						  | _ -> failwith("Non-boolean pattern guard."))) ;;

(* Evaluate the specified expression *)
let run (exp: typedExpression) = semantics(exp, [], []) ;;

