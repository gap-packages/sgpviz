##########################################################################
##########################################################################
##
# The aim of this function is to "splash" an image directly from the dot code.
# To this effect, it adds a preamble and makes a call to the Viz Splash function.
# To avoid forcing the user to install the Viz package (under development), a copy of the Viz Splash function is included in the file "splash_from_viz.g" of this package

InstallGlobalFunction(SV_Splash,
        function(arg)
  local  opt, dotstr;
  
  opt := First(arg, IsRecord);
  dotstr := First(arg, IsString);
  
    Splash_sv(dotstr,opt);  
end);

###########################################################################
##
#F DrawRightCayleyGraph
##
## Displays the right Cayley graph of a finite monoid or semigroup.
##
InstallGlobalFunction(DrawRightCayleyGraph, function(M)
  local  dotstr; 
  
  dotstr := DotForDrawingRightCayleyGraph(M);
  SV_Splash(dotstr);
end);

###########################################################################
##
#F  DrawDClassOfElement(S,el)
##
##  Displays the D-Class of the element <el> of the semigroup <S>
##
InstallGlobalFunction(DrawDClassOfElement, function(arg)
  local  dotstr; 
  
  #  dotstr := DotForDrawingDClassOfElement(arg[1],arg[2]);
  #dotstr := CallFuncList(DotForDrawingDClassOfElement,arg));
  #for compatibility with previous versions:
  dotstr := CallFuncList(DotForDrawingDClassOfElement,Filtered(arg, a -> not IsString(a)));
  
  SV_Splash(dotstr);
end);
#############################################################################
###########################################################################
##
#F  DrawDClasses(S)
##
##  Displays the D-Classes of the semigroup <S>
##
InstallGlobalFunction(DrawDClasses, function(arg)
  local  dotstr; 
  
 # dotstr := DotForDrawingRightCayleyGraph(arg);
  dotstr := CallFuncList(DotForDrawingDClasses,Filtered(arg, a -> not IsString(a)));
  SV_Splash(dotstr);
end);
#############################################################################
###########################################################################
##
#F  DrawSchutzenbergerGraphs(S)
##
##  Displays the Schutzenberger graphs of the semigroup <S>
##
InstallGlobalFunction(DrawSchutzenbergerGraphs, function(S)
  local  dotstr; 
  
  dotstr := DotForDrawingSchutzenbergerGraphs(S);
  SV_Splash(dotstr);
end);


