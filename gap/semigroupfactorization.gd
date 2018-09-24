############################################################################
##
#W  semigroupfactorization.gd           Manuel Delgado <mdelgado@fc.up.pt>
#W                                      Jose Morais    <josejoao@fc.up.pt>
##
#H  @(#)$Id: semigroupfactorization.gd,v 0.998 $
##
#Y  Copyright (C)  2005,  CMUP, Universidade do Porto, Portugal
##
##
###########################################################################
##
#F  SemigroupFactorization(S,L)
##
##  <L> is an element (or list of elements) of the semigroup <S>.
##  Returns a minimal factorization on the generators of <S> of the
##  element(s) of <L>
##
DeclareGlobalFunction( "SemigroupFactorization" );
DeclareGlobalFunction( "SemigroupFactorizationOLD" );
