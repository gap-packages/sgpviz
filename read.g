#############################################################################
##
#W  read.g                            Manuel Delgado <mdelgado@fc.up.pt>
#W                                    Jose Morais    <josejoao@fc.up.pt>
##
##
#Y  Copyright (C)  2005,  CMUP, Universidade do Porto, Portugal
##
##  Read the installation files.
##
DeclareInfoClass("InfoViz");
DeclareInfoClass("InfoSgpViz");
#ReadPackage( "sgpviz", "gap/infolevelsgpviz" );
ReadPackage( "sgpviz", "gap/splash_from_Viz.g" );

ReadPackage( "sgpviz", "gap/basicsViz.gi" );
ReadPackage( "sgpviz", "gap/grahamblocks.gi" );
ReadPackage( "sgpviz", "gap/drawdclasses.gi" );
ReadPackage( "sgpviz", "gap/semigroupfactorization.gi" );
ReadPackage( "sgpviz", "gap/schutzenberger-graphs.gi" );
ReadPackage( "sgpviz", "gap/sgpviz-display.gi" );
ReadPackage( "sgpviz", "gap/xautomaton.gi" );
ReadPackage( "sgpviz", "gap/xsemigroup.gi" );
ReadPackage( "sgpviz", "gap/sv_utils.gi");

#E  read.g  . . . . . . . . . . . . . . . . . . . . . . . . . . .  ends here
