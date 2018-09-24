#############################################################################
##
#A  testall.tst        SgpViz package                   Manuel Delgado
##                                                    
##  (based on the cooresponding file of the 'example' package, 
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
# Examples from the manual
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
gap> f1 := SemigroupFactorization(poi3,el1);
[ [ Transformation( [ 1, 3, 4, 4 ] ), Transformation( [ 2, 4, 3, 4 ] ) ] ]
gap> f1[1][1] * f1[1][2] = el1;
true
gap> SemigroupFactorization(poi3,[el1,el2]);
[ [ Transformation( [ 1, 3, 4, 4 ] ), Transformation( [ 2, 4, 3, 4 ] ) ], 
  [ Transformation( [ 2, 4, 3, 4 ] ) ] ]

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
gap> DisplayEggBoxOfDClass(D);
[ [  1,  1,  0,  0 ],
  [  1,  1,  0,  0 ],
  [  0,  0,  1,  1 ],
  [  0,  0,  1,  1 ] ]
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
gap> DotForDrawingDClassOfElement(poi3,Transformation([1,4,3,4]));
"digraph  DClassOfElement {\ngraph [center=yes,ordering=out];\nnode [shape=pla\
intext];\nedge [color=cornflowerblue,arrowhead=none];\n1 [label=<\n<TABLE BORD\
ER=\"0\" CELLBORDER=\"0\" CELLPADDING=\"0\" CELLSPACING=\"0\" PORT=\"1\">\n<TR\
><TD BORDER=\"0\"><TABLE CELLSPACING=\"0\"><TR><TD BGCOLOR=\"white\" BORDER=\"\
0\">*abc</TD></TR>\n</TABLE></TD><TD BORDER=\"0\"><TABLE CELLSPACING=\"0\"><TR\
><TD BGCOLOR=\"white\" BORDER=\"0\">a</TD></TR>\n</TABLE></TD><TD BORDER=\"0\"\
><TABLE CELLSPACING=\"0\"><TR><TD BGCOLOR=\"white\" BORDER=\"0\">ab</TD></TR>\
\n</TABLE></TD></TR>\n<TR><TD BORDER=\"0\"><TABLE CELLSPACING=\"0\"><TR><TD BG\
COLOR=\"white\" BORDER=\"0\">bc</TD></TR>\n</TABLE></TD><TD BORDER=\"0\"><TABL\
E CELLSPACING=\"0\"><TR><TD BGCOLOR=\"white\" BORDER=\"0\">*bca</TD></TR>\n</T\
ABLE></TD><TD BORDER=\"0\"><TABLE CELLSPACING=\"0\"><TR><TD BGCOLOR=\"white\" \
BORDER=\"0\">b</TD></TR>\n</TABLE></TD></TR>\n<TR><TD BORDER=\"0\"><TABLE CELL\
SPACING=\"0\"><TR><TD BGCOLOR=\"white\" BORDER=\"0\">c</TD></TR>\n</TABLE></TD\
><TD BORDER=\"0\"><TABLE CELLSPACING=\"0\"><TR><TD BGCOLOR=\"white\" BORDER=\"\
0\">ca</TD></TR>\n</TABLE></TD><TD BORDER=\"0\"><TABLE CELLSPACING=\"0\"><TR><\
TD BGCOLOR=\"white\" BORDER=\"0\">*cab</TD></TR>\n</TABLE></TD></TR>\n</TABLE>\
>];\n}\n"
gap> Print(last);
digraph  DClassOfElement {
graph [center=yes,ordering=out];
node [shape=plaintext];
edge [color=cornflowerblue,arrowhead=none];
1 [label=<
<TABLE BORDER="0" CELLBORDER="0" CELLPADDING="0" CELLSPACING="0" PORT="1">
<TR><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BORDER="0">*\
abc</TD></TR>
</TABLE></TD><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BOR\
DER="0">a</TD></TR>
</TABLE></TD><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BOR\
DER="0">ab</TD></TR>
</TABLE></TD></TR>
<TR><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BORDER="0">b\
c</TD></TR>
</TABLE></TD><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BOR\
DER="0">*bca</TD></TR>
</TABLE></TD><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BOR\
DER="0">b</TD></TR>
</TABLE></TD></TR>
<TR><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BORDER="0">c\
</TD></TR>
</TABLE></TD><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BOR\
DER="0">ca</TD></TR>
</TABLE></TD><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BOR\
DER="0">*cab</TD></TR>
</TABLE></TD></TR>
</TABLE>>];
}

#
gap> Print(DotForDrawingDClasses(poi3));
digraph  DClasses {
graph [center=yes,ordering=out];
node [shape=plaintext];
edge [color=cornflowerblue,arrowhead=none];
1 [label=<
<TABLE BORDER="0" CELLBORDER="0" CELLPADDING="0" CELLSPACING="0" PORT="1">
<TR><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BORDER="0">*\
0</TD></TR>
</TABLE></TD></TR>
</TABLE>>];
2 [label=<
<TABLE BORDER="0" CELLBORDER="0" CELLPADDING="0" CELLSPACING="0" PORT="2">
<TR><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BORDER="0">*\
a^2</TD></TR>
</TABLE></TD><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BOR\
DER="0">a^2b</TD></TR>
</TABLE></TD><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BOR\
DER="0">ba</TD></TR>
</TABLE></TD></TR>
<TR><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BORDER="0">a\
c^2</TD></TR>
</TABLE></TD><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BOR\
DER="0">*ac</TD></TR>
</TABLE></TD><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BOR\
DER="0">ab^2</TD></TR>
</TABLE></TD></TR>
<TR><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BORDER="0">c\
^2</TD></TR>
</TABLE></TD><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BOR\
DER="0">b^2c</TD></TR>
</TABLE></TD><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BOR\
DER="0">*b^2</TD></TR>
</TABLE></TD></TR>
</TABLE>>];
3 [label=<
<TABLE BORDER="0" CELLBORDER="0" CELLPADDING="0" CELLSPACING="0" PORT="3">
<TR><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BORDER="0">*\
abc</TD></TR>
</TABLE></TD><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BOR\
DER="0">a</TD></TR>
</TABLE></TD><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BOR\
DER="0">ab</TD></TR>
</TABLE></TD></TR>
<TR><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BORDER="0">b\
c</TD></TR>
</TABLE></TD><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BOR\
DER="0">*bca</TD></TR>
</TABLE></TD><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BOR\
DER="0">b</TD></TR>
</TABLE></TD></TR>
<TR><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BORDER="0">c\
</TD></TR>
</TABLE></TD><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BOR\
DER="0">ca</TD></TR>
</TABLE></TD><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BOR\
DER="0">*cab</TD></TR>
</TABLE></TD></TR>
</TABLE>>];
4 [label=<
<TABLE BORDER="0" CELLBORDER="0" CELLPADDING="0" CELLSPACING="0" PORT="4">
<TR><TD BORDER="0"><TABLE CELLSPACING="0"><TR><TD BGCOLOR="white" BORDER="0">*\
1</TD></TR>
</TABLE></TD></TR>
</TABLE>>];
4:4 -> 3:3;
3:3 -> 2:2;
2:2 -> 1:1;
}

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
gap> DotForDrawingSchutzenbergerGraphs(poi3);
"digraph  SchutzenbergerGraphs{\ncompound=true;\nsubgraph cluster4{\n1 [shape=\
circle];\n}\nsubgraph cluster3{\n2 -> 4 [label=\"a\",color=red];\n3 -> 2 [labe\
l=\"c\",color=green];\n4 -> 3 [label=\"b\",color=blue];\n2 [shape=circle];\n3 \
[shape=circle];\n4 [shape=circle];\n}\nsubgraph cluster2{\n5 -> 5 [label=\"b\"\
,color=blue];\n5 -> 6 [label=\"c\",color=green];\n6 -> 5 [label=\"a\",color=re\
d];\n6 -> 7 [label=\"c\",color=green];\n7 -> 7 [label=\"a\",color=red];\n7 -> \
6 [label=\"b\",color=blue];\n5 [shape=circle];\n6 [shape=circle];\n7 [shape=ci\
rcle];\n}\nsubgraph cluster1{\n8 -> 8 [label=\"a\",color=red];\n8 -> 8 [label=\
\"b\",color=blue];\n8 -> 8 [label=\"c\",color=green];\n8 [shape=circle];\n}\n1\
 -> 2 [lhead=cluster3,ltail=cluster4,color=cornflowerblue];\n2 -> 5 [lhead=clu\
ster2,ltail=cluster3,color=cornflowerblue];\n5 -> 8 [lhead=cluster1,ltail=clus\
ter2,color=cornflowerblue];\n}\n"
gap> Print(last);
digraph  SchutzenbergerGraphs{
compound=true;
subgraph cluster4{
1 [shape=circle];
}
subgraph cluster3{
2 -> 4 [label="a",color=red];
3 -> 2 [label="c",color=green];
4 -> 3 [label="b",color=blue];
2 [shape=circle];
3 [shape=circle];
4 [shape=circle];
}
subgraph cluster2{
5 -> 5 [label="b",color=blue];
5 -> 6 [label="c",color=green];
6 -> 5 [label="a",color=red];
6 -> 7 [label="c",color=green];
7 -> 7 [label="a",color=red];
7 -> 6 [label="b",color=blue];
5 [shape=circle];
6 [shape=circle];
7 [shape=circle];
}
subgraph cluster1{
8 -> 8 [label="a",color=red];
8 -> 8 [label="b",color=blue];
8 -> 8 [label="c",color=green];
8 [shape=circle];
}
1 -> 2 [lhead=cluster3,ltail=cluster4,color=cornflowerblue];
2 -> 5 [lhead=cluster2,ltail=cluster3,color=cornflowerblue];
5 -> 8 [lhead=cluster1,ltail=cluster2,color=cornflowerblue];
}


#
gap> STOP_TEST( "testall.tst" );
