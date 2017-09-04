#############################################################################
##
#W  read.g                            Manuel Delgado <mdelgado@fc.up.pt>
#W                                    Jose Morais    <josejoao@fc.up.pt>
##
##
#H  @(#)$Id: read.g,v 0.998 $
##
#Y  Copyright (C)  2005,  CMUP, Universidade do Porto, Portugal
##
##  Read the installation files.
##
DeclareInfoClass("InfoSgpViz");
ReadPackage( "sgpviz", "gap/infolevelsgpviz" );

ReadPackage( "sgpviz", "gap/basicsViz.gi" );
ReadPackage( "sgpviz", "gap/grahamblocks.gi" );
ReadPackage( "sgpviz", "gap/drawdclasses.gi" );
ReadPackage( "sgpviz", "gap/semigroupfactorization.gi" );
ReadPackage( "sgpviz", "gap/schutzenberger-graphs.gi" );
ReadPackage( "sgpviz", "gap/xautomaton.gi" );
ReadPackage( "sgpviz", "gap/xsemigroup.gi" );

#E  read.g  . . . . . . . . . . . . . . . . . . . . . . . . . . .  ends here
