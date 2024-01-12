#############################################################################
##
#A  testall.tst        SgpViz package                   Manuel Delgado
##                                                    
##  (based on the corresponding file of the 'example' package, 
##   by Alexander Konovalov) 
##
##  To create a test file, place GAP prompts, input and output exactly as
##  they must appear in the GAP session. Do not remove lines containing 
##  START_TEST and STOP_TEST statements.
##
##  The first line starts the test. START_TEST reinitializes the caches and 
##  the global random number generator, in order to be independent of the 
##  reading order of several test files. Furthermore, the assertion level 
##  is set to 2 by START_TEST and set back to the previous value in the 
##  subsequent STOP_TEST call.
##
##  The argument of STOP_TEST may be an arbitrary identifier string.
## 
gap> START_TEST("SgpViz package: testall.tst");

# Note that you may use comments in the test file
# and also separate parts of the test by empty lines
#
# First load the package without banner (the banner must be suppressed to 
# avoid reporting discrepancies in the case when the package is already 
# loaded)
gap> LoadPackage("sgpviz",false);
true

# Check that the data are consistent  
#
#############################################################################
# Some more elaborated tests
#
#############################################################################
#############################################################################
# Examples from the manual (slightly adapted)
# (These examples use at least a function from each file)
#basics
gap> f := FreeMonoid("a","b");;
gap> a := GeneratorsOfMonoid( f )[ 1 ];;
gap> b := GeneratorsOfMonoid( f )[ 2 ];;
gap> r:=[[a^3,a^2],
> [a^2*b,a^2],
> [b*a^2,a^2],
> [b^2,a^2],
> [a*b*a,a],
> [b*a*b,b] ];
[ [ a^3, a^2 ], [ a^2*b, a^2 ], [ b*a^2, a^2 ], [ b^2, a^2 ], [ a*b*a, a ], 
  [ b*a*b, b ] ]
gap> b21:= f/r;
<fp monoid on the generators [ a, b ]>

#
gap> g0:=Transformation([4,1,2,4]);;
gap> g1:=Transformation([1,3,4,4]);;
gap> g2:=Transformation([2,4,3,4]);;
gap> poi3:= Monoid(g0,g1,g2);
<transformation monoid of degree 4 with 3 generators>

#
gap> PartialTransformation([2,0,4,0]);
Transformation( [ 2, 5, 4, 5, 5 ] )

#
gap> el1 := Transformation( [ 2, 3, 4, 4 ] );;
gap> el2 := Transformation( [ 2, 4, 3, 4 ] );;
gap> f1 := SemigroupFactorization(poi3,el1);;
gap> Product(f1[1]) = el1;
true
gap> f2 := SemigroupFactorization(poi3,[el1,el2]);;
gap> Product(f2[1]) = el1;
true
gap> Product(f2[2]) = el2;
true

#
gap> p1 := PartialTransformation([6,2,0,0,2,6,0,0,10,10,0,0]);;
gap> p2 := PartialTransformation([0,0,1,5,0,0,5,9,0,0,9,1]);;
gap> p3 := PartialTransformation([0,0,3,3,0,0,7,7,0,0,11,11]);;
gap> p4 := PartialTransformation([4,4,0,0,8,8,0,0,12,12,0,0]);;
gap> css3:=Semigroup(p1,p2,p3,p4);
<transformation semigroup of degree 13 with 4 generators>
gap> el := Elements(css3)[8];;
gap> D := GreensDClassOfElement(css3, el);;
gap> IsRegularDClass(D);
true
gap> mat := [ [  1,  0,  1,  0 ],
>   [  0,  1,  0,  1 ],
>   [  0,  1,  0,  1 ],
>   [  1,  0,  1,  0 ] ];;
gap> res := GrahamBlocks(mat);;
gap> PrintArray(res[1]);
[ [  1,  1,  0,  0 ],
  [  1,  1,  0,  0 ],
  [  0,  0,  1,  1 ],
  [  0,  0,  1,  1 ] ]
gap> PrintArray(res[2]);
[ [  [ 1, 1 ],  [ 1, 3 ],  [ 1, 2 ],  [ 1, 4 ] ],
  [  [ 4, 1 ],  [ 4, 3 ],  [ 4, 2 ],  [ 4, 4 ] ],
  [  [ 2, 1 ],  [ 2, 3 ],  [ 2, 2 ],  [ 2, 4 ] ],
  [  [ 3, 1 ],  [ 3, 3 ],  [ 3, 2 ],  [ 3, 4 ] ] ]

#
gap> rcg := RightCayleyGraphAsAutomaton(b21);
< deterministic automaton on 2 letters with 6 states >
gap> Display(rcg);
   |  1  2  3  4  5  6  
-----------------------
 a |  2  4  6  4  2  4  
 b |  3  5  4  4  4  3  
Initial state:   [  ]
Accepting state: [  ]

#
#drawings
gap> dclasselementpoi3 := DotForDrawingDClassOfElement(poi3,Transformation([1,4,3,4]),1);;
gap> Number(dclasselementpoi3, x -> x='*');
3
gap> Number(dclasselementpoi3, x -> x='w');
11
gap> Number(dclasselementpoi3, x -> x=']');
13
gap> Number(dclasselementpoi3, x -> x='[') = Number(dclasselementpoi3, x -> x=']');
true

#
gap> dclassespoi3 := DotForDrawingDClasses(poi3);;
gap> Number(dclassespoi3, x -> x=';');
10
gap> Number(dclassespoi3, x -> x='*');
8
gap> Number(dclassespoi3, x -> x='w');
22
gap> Number(dclassespoi3, x -> x=']');
7
gap> Number(dclassespoi3, x -> x='[') = Number(dclassespoi3, x -> x=']');
true

#
gap> DotForDrawingRightCayleyGraph(b21);
"digraph  CayleyGraph {\n1 -> 2 [label=\"a\",color=red];\n1 -> 3 [label=\"b\",\
color=blue];\n2 -> 4 [label=\"a\",color=red];\n2 -> 5 [label=\"b\",color=blue]\
;\n3 -> 6 [label=\"a\",color=red];\n3 -> 4 [label=\"b\",color=blue];\n4 -> 4 [\
label=\"a\",color=red];\n4 -> 4 [label=\"b\",color=blue];\n5 -> 2 [label=\"a\"\
,color=red];\n5 -> 4 [label=\"b\",color=blue];\n6 -> 4 [label=\"a\",color=red]\
;\n6 -> 3 [label=\"b\",color=blue];\n1 [shape=circle, style=filled, fillcolor=\
deepskyblue];\n2 [shape=circle];\n3 [shape=circle];\n4 [shape=circle, style=fi\
lled, fillcolor=lightcoral];\n5 [shape=circle, style=filled, fillcolor=lightco\
ral];\n6 [shape=circle, style=filled, fillcolor=lightcoral];\n}\n"

#
gap> IsString(DotForDrawingRightCayleyGraph(b21));
true
gap> Number(DotForDrawingRightCayleyGraph(b21), x -> x=';');
18

#
gap> IsString(DotForDrawingRightCayleyGraph(poi3));
true
gap> Number(DotForDrawingRightCayleyGraph(poi3), x -> x=';');
80

#
gap> IsString(DotForDrawingSchutzenbergerGraphs(poi3));
true
gap> Number(DotForDrawingSchutzenbergerGraphs(poi3), x -> x=';');
24

#
#############################################################################
# Simple examples aiming for a better code coverage
#############################################################################

#
gap> s := Semigroup(Transformation( [ 4, 1, 2, 4 ] ),
> Transformation( [ 1, 3, 4, 4 ] ), Transformation( [ 2, 4, 3, 4 ] ));
<transformation semigroup of degree 4 with 3 generators>
gap> RightCayleyGraphAsAutomaton(s);
< deterministic automaton on 3 letters with 19 states >

#
gap> t1 := Transformation([2,3,1,4,5,5]);
Transformation( [ 2, 3, 1, 4, 5, 5 ] )
gap> t2 := Transformation([1,3,4,2,5,5]);
Transformation( [ 1, 3, 4, 2, 5, 5 ] )
gap> t3 := Transformation([1,5,3,2,4,4]);
Transformation( [ 1, 5, 3, 2, 4, 4 ] )
gap> a5 := Semigroup(t1,t2,t3);
<transformation semigroup of degree 6 with 3 generators>
gap> dclassesa5 := DotForDrawingDClasses(a5);;
gap> Number(dclassesa5, x -> x=';');
4
gap> Number(dclassesa5, x -> x='*');
1
gap> Number(dclassesa5, x -> x='w');
62
gap> Number(dclassesa5, x -> x='[') = Number(dclassesa5, x -> x=']');
true

#
gap> u1:=Transformation([2,2,3]);
Transformation( [ 2, 2 ] )
gap> g:=Transformation([2,3,1]);
Transformation( [ 2, 3, 1 ] )
gap> op3:= Monoid(g,u1);
<transformation monoid of degree 3 with 2 generators>
gap> dclassesop3 := DotForDrawingDClasses(op3);;
gap> Number(dclassesop3, x -> x=';');
8
gap> Number(dclassesop3, x -> x='*');
10
gap> Number(dclassesop3, x -> x='w');
26
gap> Number(dclassesop3, x -> x='[') = Number(dclassesop3, x -> x=']');
true

#
gap> u1:=Transformation([2,2,3,4,5]);
Transformation( [ 2, 2 ] )
gap> g:=Transformation([2,3,4,5,1]);
Transformation( [ 2, 3, 4, 5, 1 ] )
gap> op5:= Monoid(g,u1);
<transformation monoid of degree 5 with 2 generators>
gap> dclassesop5 := DotForDrawingDClasses(op5);;
gap> Number(dclassesop5, x -> x=';');
12
gap> Number(dclassesop5, x -> x='*');
101
gap> Number(dclassesop5, x -> x='w');
612
gap> Number(dclassesop5, x -> x='[') = Number(dclassesop5, x -> x=']');
true

#
gap> p1 := Transformation([2,1,3,4,5]);
Transformation( [ 2, 1 ] )
gap> p2 := Transformation([2,3,4,5,1]);
Transformation( [ 2, 3, 4, 5, 1 ] )
gap> S5 := Monoid(p1,p2);
<transformation monoid of degree 5 with 2 generators>
gap> dclassesS5 := DotForDrawingDClasses(S5);;
gap> Number(dclassesS5, x -> x=';');
4
gap> Number(dclassesS5, x -> x='*');
1
gap> Number(dclassesS5, x -> x='w');
122
gap> Number(dclassesS5, x -> x='[') = Number(dclassesS5, x -> x=']');
true

#
gap> kkkpori4 := Semigroup([ Transformation( [ 1 .. 5 ] ), 
> Transformation( [ 1, 2, 3, 5, 5 ] ),
>   Transformation( [ 1, 2, 5, 4, 5 ] ), Transformation( [ 1, 5, 3, 4, 5 ] ),
>   Transformation( [ 5, 2, 3, 4, 5 ] ) ] );
<transformation monoid of degree 5 with 4 generators>
gap> dclasseskkkpori4 := DotForDrawingDClasses(kkkpori4);;
gap> Number(dclasseskkkpori4, x -> x=';');
51
gap> Number(dclasseskkkpori4, x -> x='*');
16
gap> Number(dclasseskkkpori4, x -> x='w');
18
gap> Number(dclasseskkkpori4, x -> x='[') = Number(dclasseskkkpori4, x -> x=']');
true

#
gap> STOP_TEST( "testall.tst" );
