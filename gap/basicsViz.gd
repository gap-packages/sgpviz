############################################################################
##
#W  basicsViz.gd                           Manuel Delgado <mdelgado@fc.up.pt>
#W                                      Jose Morais    <josejoao@fc.up.pt>
##
#Y  Copyright (C)  2005,  CMUP, Universidade do Porto, Portugal
##
##
###########################################################################

DeclareProperty("HasCommutingIdempotents", IsSemigroup);

if not IsBound(IsInverseSemigroup) then
    DeclareProperty("IsInverseSemigroup", IsSemigroup);
fi;

DeclareGlobalFunction( "PartialTransformation" );

DeclareAttribute( "SmallGeneratingSetForSemigroups", IsSemigroup );

DeclareGlobalFunction( "ReduceNumberOfGenerators" );

###########################################################################
##
#F RightCayleyGraphAsAutomaton
##
## Computes the right Cayley graph of a finite monoid or semigroup. It uses the GAP 
## buit-in function CayleyGraphSemigroup to compute the Cayley Graph 
## and returns it as an automaton without initial and final states.
##
DeclareGlobalFunction( "RightCayleyGraphAsAutomaton" );
#############################################################################
DeclareSynonym( "RightCayleyGraphMonoidAsAutomaton", RightCayleyGraphAsAutomaton);


###########################################################################
##
#F DotForDrawingRightCayleyGraph
##
## outputs a string consisting of dot code the right Cayley graph of a finite monoid or semigroup.
##
DeclareGlobalFunction( "DotForDrawingRightCayleyGraph" );
