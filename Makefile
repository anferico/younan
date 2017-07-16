
# Variables
OCAML_INTERP=ocaml # Edit this if you're using another OCaml interpreter
LANG_INTERP=$(shell pwd)/Interpreter.ml
TESTLOC=$(shell pwd)/Test_sets/

# Phony targets
PHONY=testEint testEBool testFun testIde testAnd testOr testNot testOp1 testOp2 testIfthenelse1 testIfthenelse2 testLet testApply1 testApply2 testTryWith1 testTryWith2

testEInt :
	cat $(LANG_INTERP) $(TESTLOC)$@.ml | $(OCAML_INTERP)

testEBool :
	cat $(LANG_INTERP) $(TESTLOC)$@.ml | $(OCAML_INTERP)

testFun :
	cat $(LANG_INTERP) $(TESTLOC)$@.ml | $(OCAML_INTERP)
	
testIde :
	cat $(LANG_INTERP) $(TESTLOC)$@.ml | $(OCAML_INTERP)
	
testAnd :
	cat $(LANG_INTERP) $(TESTLOC)$@.ml | $(OCAML_INTERP)
	
testOr :
	cat $(LANG_INTERP) $(TESTLOC)$@.ml | $(OCAML_INTERP)
	
testNot :
	cat $(LANG_INTERP) $(TESTLOC)$@.ml | $(OCAML_INTERP)
	
testOp1 :
	cat $(LANG_INTERP) $(TESTLOC)$@.ml | $(OCAML_INTERP)
	
testOp2 :
	cat $(LANG_INTERP) $(TESTLOC)$@.ml | $(OCAML_INTERP)
	
testIfthenelse1 :
	cat $(LANG_INTERP) $(TESTLOC)$@.ml | $(OCAML_INTERP)

testIfthenelse2 :
	cat $(LANG_INTERP) $(TESTLOC)$@.ml | $(OCAML_INTERP)
	
testLet :
	cat $(LANG_INTERP) $(TESTLOC)$@.ml | $(OCAML_INTERP)
	
testApply1 :
	cat $(LANG_INTERP) $(TESTLOC)$@.ml | $(OCAML_INTERP)
	
testApply2 :
	cat $(LANG_INTERP) $(TESTLOC)$@.ml | $(OCAML_INTERP)
	
testTryWith1 :
	cat $(LANG_INTERP) $(TESTLOC)$@.ml | $(OCAML_INTERP)

testTryWith2 :
	cat $(LANG_INTERP) $(TESTLOC)$@.ml | $(OCAML_INTERP)

