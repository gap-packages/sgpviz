##########################################################################
##
#F SV_Splash
##
## The aim of this function is to "splash" an image directly from the dot code.
## To this effect, it adds a preamble and makes a call to the Viz Splash function.
## To avoid forcing the user to install the Viz package (under development), a copy 
## of the Viz Splash function is included in the file "splash_from_viz.g" of this package
###########################################################################
DeclareGlobalFunction("SV_Splash");
###########################################################################
##
#F DrawRightCayleyGraph
##
## Displays the right Cayley graph of a finite monoid or semigroup.
##
DeclareGlobalFunction( "DrawRightCayleyGraph" );
#############################################################################
DeclareSynonym( "DrawCayleyGraph", DrawRightCayleyGraph);
###########################################################################
###########################################################################
##
#F  DrawDClassOfElement(S,el)
##
##  Displays the D-Class of the element <el> of the semigroup <S>
##
DeclareGlobalFunction( "DrawDClassOfElement" );
#############################################################################
###########################################################################
##
#F  DrawDClasses(S)
##
##  Displays the D-Classes of the semigroup <S>
##
DeclareGlobalFunction( "DrawDClasses" );
#############################################################################
###########################################################################
##
#F  DrawSchutzenbergerGraphs(S)
##
##  Displays the Schutzenberger graphs of the semigroup <S>
##
DeclareGlobalFunction( "DrawSchutzenbergerGraphs" );
