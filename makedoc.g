##  this creates the documentation, needs: GAPDoc and AutoDoc packages, pdflatex
##  
##  Call this with GAP from within the package directory.
##
  
if fail = LoadPackage("AutoDoc", ">= 2016.01.21") then
    Error("AutoDoc 2016.01.21 or newer is required");
fi;

AutoDoc(rec( scaffold := rec( 
                              gapdoc_latex_options := rec(EarlyExtraPreamble:="\\usepackage{graphicx}\n\\usepackage{pgf}\n\\usepackage{tikz}\n\\usepgfmodule{plot}\n\\usepgflibrary{plothandlers}\n\\usetikzlibrary{shapes.geometric}\n\\usetikzlibrary{shadings}"),
                                      MainPage := false )));
PrintTo("version", GAPInfo.PackageInfoCurrent.Version);
