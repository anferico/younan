# Younan
A simple interpreter for an even simpler functional language (Younan). The interpreter assumes static (lexical) scoping and performs dynamic type checking.

The interpreter assumes that the program has already gone through a compilation phase (Younan -> OCaml). Each example provided in the `Test_sets` directory shows indeed an OCaml representation of the original program. The concrete syntax of the language is defined by the following grammar:

```
Ide ::= <standard definition>        (Identifiers)
Int ::= <standard definition>        (Integer constants)


Val ::= Int                          (Integers)
        | True | False               (Booleans)
        | fun Ide -> E               (Non recursive, single-parameter functions)
        
        
E   ::= Ide                          (Identifier)
        | Val                        (Value)
        | E and E | E or E | not E   (Boolean expressions)
        | OP(E,E)                    (Expressions over integers, where OP ∈ {+, -, *, =, <=})
        | if E then E else E         (Conditional statement)        
        | let Ide=E in E             (Let statement)
        | E(E)                       (Function application)
        | try Ide with E in P        (Try-with expression)
        
        
P   ::= (_-->E)                      (Default pattern)
        | (E-->E)                    (Elementary pattern)
        | (E-->E)::P                 (Pattern composition)
```
The meaning of the language's constructs is standard, except for the expression __try__ *x* __with__ ... __in__ ..., which enables some sort of pattern matching. In the evaluation of __try__ *x* __with__ *E* __in__ *P*, the value obtained from the evaluation of the expression *E* is bound to the variable *x* and determines the selection of the pattern with the consequential execution of the associated expression. The intuition is that the first expression of the pattern (the one at the left of -->) contains the variable *x* and acts as a boolean guard: the pattern is chosen if the guard is satisfied, in which case the associated expression is evaluated. The pattern (\_-->E) is the default pattern. 
