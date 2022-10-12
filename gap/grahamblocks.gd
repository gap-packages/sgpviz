############################################################################
##
#W  grahamblocks.gd                     Manuel Delgado <mdelgado@fc.up.pt>
#W                                      Jose Morais    <josejoao@fc.up.pt>
##
#Y  Copyright (C)  2005,  CMUP, Universidade do Porto, Portugal
##
##
###########################################################################
##
#F  GrahamBlocks(mat_input)
##
##  This function returns [mat, phi]
##  where mat is in Graham blocks form
##  and phi[i][j] = [i', j'] where mat_input[i'][j'] = mat[i][j]
DeclareGlobalFunction( "GrahamBlocks" );
