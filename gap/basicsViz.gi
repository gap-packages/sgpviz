############################################################################
##
#W  basics.gi                       Manuel Delgado <mdelgado@fc.up.pt>
#W                                    Jose Morais    <josejoao@fc.up.pt>
##
#H  @(#)$Id: basics.gi,v 0.998 $
##
#Y  Copyright (C)  2005,  CMUP, Universidade do Porto, Portugal
##
##
###########################################################################
##
##
###########################################################################
##
#M HasCommutingIdempotents(M)
##
## Tests whether the idempotents of a semigroup <M> commute
##
InstallMethod(HasCommutingIdempotents, "for finite semigroups", true,
                 [IsSemigroup], 0, 
    function(M)
    local e1, e2, E;
    E := Idempotents(M);
    for e1 in E do
        for e2 in E do
            if e1*e2 <> e2*e1 then
                Info(InfoSgpViz,2, e1, " and ", e2, " don't commute");
                return false;
            fi;
        od;
    od;
    return true;
end);


#####################################33###################################
##
#M IsInverseSemigroup(S)
##
## Tests whether a finite semigroup is inverse
##
InstallMethod(IsInverseSemigroup, "for finite semigroups", true,
              [IsSemigroup], 0,
function(S)
    return HasCommutingIdempotents(S) and IsRegularSemigroup(S);
end);

#############################################################################
##
#F PartialTransformation(L)
##
## A partial transformation is a partial function of a set of integers of 
## the form  {1,..., n}. It is given by means of the list of images. When 
## an element has no image, we write 0. 
##
## Returns a transformation on a set with one more element that acts like 
## a zero
##
InstallGlobalFunction(PartialTransformation, function(L)    
    local i, n, K;
    n := Length(L);
    #check that it represents a partial transformation.
       
    if ForAny([1..n], i-> (IsBound(L[i]) and not L[i] in [0..n])) then
        Error ("<L> does not describe a partial transformation");
    fi;
    
    K := ShallowCopy(L);
    for i in [1..n] do
        if K[i] = 0 then
            K[i] := n+1;
        fi;
    od;
    K[n+1] := n+1;
    return TransformationNC(K);
end);

############################################################################
##
#F RightCayleyGraphAsAutomaton
##
## Computes the right Cayley graph of a finite monoid or semigroup. It uses the GAP 
## buit-in function CayleyGraphSemigroup to compute the Cayley Graph 
## and returns it as an automaton without initial and final states.
##
## Warning: since the GAP function "CayleyGraphSemigroup" behaves differently according to whether
## the package "semigroups" is loaded or not, this function may have different (but equivalent)
## results
##
InstallGlobalFunction(RightCayleyGraphAsAutomaton, function(sgp)
  local  M, cg, tr, size, table, n;
    
    if not IsSemigroup(sgp) then
        Error("the argument must be a semigroup");
      fi;      
      
        # to face the fact that semigroups behave differently depending on the use or not of the "semigroups" package, a fresh object is created 
  if IsMonoid(sgp) then 
    if not (IsTransformationMonoid(sgp)) then
      Info(InfoSgpViz,1,"I will work with an isomorphic transformation semigroup instead\n");
      M:= Range(IsomorphismTransformationMonoid(sgp));
      M := Monoid(ReduceNumberOfGenerators(GeneratorsOfSemigroup(M)));
    else
      M := Monoid(GeneratorsOfMonoid(sgp));
    fi;
  elif IsSemigroup(sgp) then
    if not (IsTransformationSemigroup(sgp)) then
      Info(InfoSgpViz,1,"I will work with an isomorphic transformation semigroup instead\n");
      M:= Range(IsomorphismTransformationSemigroup(sgp));
      M := Semigroup(ReduceNumberOfGenerators(GeneratorsOfSemigroup(M)));
    else
      M := Semigroup(GeneratorsOfSemigroup(sgp));
    fi;

  fi;  
   if IsFpSemigroup(M) or IsFpMonoid(M) then
       cg := CayleyGraphSemigroup(Range(IsomorphismTransformationSemigroup(M)));
   else
        cg := CayleyGraphSemigroup(M);
   fi;
    
    tr := ShallowCopy(TransposedMat(cg));
    
    size := Size(M);
    
    ## removes the action of the identity (when present as a generator, as is always the case for monoids when using the "semigroups" package...  
    if First(tr, i-> i = [1..size]) <> fail then
         Unbind(tr[Position(tr,First(tr, i-> i = [1..size]))]);
         table := Compacted(tr);
    else
        table := tr;
    fi;
    
    n := Length(table);
    
    # if MultiplicativeNeutralElement(M) in GeneratorsOfSemigroup(M) then
    #     n := Length(GeneratorsOfSemigroup(M))-1;
    # else
    #     n := Length(GeneratorsOfSemigroup(M));
    # fi;
  
    # if n <> Length(cg[1]) then
    #     Print("WARNING: you are possibly using twice the same generator and this may cause problems...\n");
    # fi;
    return Automaton("det", Size(M), n, table, [], []);
end);

###########################################################################
##
#F DotForDrawingRightCayleyGraph
##
## outputs a string consisting of dot code the right Cayley graph of a finite monoid or semigroup.
##
InstallGlobalFunction(DotForDrawingRightCayleyGraph, function(M)
  local  aut, letters, au, i, j, colors, l2, array, s, arr, max, xs, xout, k, 
         dotstring, l, pos_id, pos_idempotents;

    aut := RightCayleyGraphAsAutomaton(M);
    letters := [];
    au := StructuralCopy(aut!.transitions);
    for i in [1 .. Length(aut!.transitions)] do
        for j in [1 .. Length(aut!.transitions[1])] do
            if not IsBound(au[i][j]) or au[i][j] = 0 or au[i][j] = [0] then
                au[i][j] := " ";
            fi;
        od;
    od;

    if IsInt(AlphabetOfAutomaton(aut)) then
        if aut!.alphabet < 7 then       ##  for small alphabets, the letters
                                        ##  a, b, c, d are used
            letters := ["a", "b", "c", "d", "e", "f"];
            colors := ["red", "blue", "green", "yellow", "brown", "black"];
        else
            for i in [1 .. aut!.alphabet] do
                Add(letters, Concatenation("a", String(i)));
            od;
            colors := [];
            for i in [1 .. aut!.alphabet] do
                colors[i]:= "black";
            od;
        fi;
    else
        if aut!.alphabet < 7 then       ##  for small alphabets, the letters
                                        ##  a, b, c, d are used
            letters := [];
            for i in AlphabetOfAutomaton(aut) do
                Add(letters, [i]);
            od;
            colors := ["red", "blue", "green", "yellow", "brown", "black"];
        else
            letters := [];
            for i in AlphabetOfAutomaton(aut) do
                Add(letters, [i]);
            od;
            colors := [];
            for i in [1 .. aut!.alphabet] do
                colors[i]:= "black";
            od;
        fi;
    fi;
    if aut!.type = "epsilon" then
        letters[aut!.alphabet] := "@";
    fi;
    l2 := [];
    array := [];
    s := [];
##    max := Maximum( List( arr, x -> Maximum( List(x,Length) ) ) );

    for i in [1 .. aut!.states] do
        for j in [1 .. aut!.alphabet] do
            xs := "";
            xout := OutputTextString(xs, false);
            PrintTo(xout, letters[j]);
            if IsBound(au[j]) and IsBound(au[j][i]) and au[j][i] <> " " then
                if IsList(au[j][i]) then
                    for k in au[j][i] do
                        Add(array, [i, " -> ", k," [label=", "\"", xs,"\"",",color=", colors[j], "];"]);
                    od;
                else
                    Add(array, [i, " -> ", au[j][i]," [label=", "\"", xs,"\"",",color=", colors[j], "];"]);
                fi;
            fi;
            CloseStream(xout);
        od;
    od;
      arr := List( array, x -> List( x, String ) );
  #siegen: in the following, "AppendTo(name," was replaced by "Append(dotstring,"
    dotstring :=  "digraph  CayleyGraph {\n";
    for l  in [ 1 .. Length( arr ) ]  do
        for k  in [ 1 .. Length( arr[ l ] ) ]  do
            Append(dotstring,  String( arr[ l ][ k ]) );
        od;
        if l = Length( arr )  then
            Append(dotstring,  "\n" );
        else
            Append(dotstring,  "\n" );
        fi;
    od;
    # The state corresponding to the neutral element
    pos_id := Position(Elements(M), MultiplicativeNeutralElement(M));
    # The list of states corresponding to the idempotents
    pos_idempotents := Set(List(Idempotents(M), e -> Position(Elements(M), e)));
    for k in [1..aut!.states] do
        if k = pos_id then
            Append(dotstring, Concatenation(String(k), " [shape=circle, style=filled, fillcolor=deepskyblue];","\n"));
        elif k in pos_idempotents then
            Append(dotstring, Concatenation(String(k), " [shape=circle, style=filled, fillcolor=lightcoral];","\n"));
        else
            Append(dotstring, Concatenation(String(k), " [shape=circle];","\n"));
        fi;
    od;
    Append(dotstring,"}\n");
    return dotstring;
    
    
#    CMUP__executeDotAndViewer(tdir, dot, gv, "cayleygraph.dot");
end);
   


#siegen
# ###########################################################################
# ##
# #F DrawRightCayleyGraph
# ##
# ## Drawss the right Cayley graph of a finite monoid or semigroup.
# ##
# InstallGlobalFunction(DrawRightCayleyGraph, function(M)
#     local   gv,  dot,  tdir,  name,  aut,  
#             nome,  letters,  au,  i,  j,  colors,  l2,  array,  s,  
#             arr,  max,  xs,  xout,  k,  l,  pos_id, pos_idempotents;
    
        
#     tdir := CMUP__getTempDir();
#     gv := CMUP__getPsViewer();
#     dot := CMUP__getDotExecutable();
    
#     name := Filename(tdir, "cayleygraph.dot");
#     aut := RightCayleyGraphAsAutomaton(M);
    
#     nome := "CayleyGraph";
#     letters := [];
#     au := StructuralCopy(aut!.transitions);
#     for i in [1 .. Length(aut!.transitions)] do
#         for j in [1 .. Length(aut!.transitions[1])] do
#             if not IsBound(au[i][j]) or au[i][j] = 0 or au[i][j] = [0] then
#                 au[i][j] := " ";
#             fi;
#         od;
#     od;

#     if IsInt(AlphabetOfAutomaton(aut)) then
#         if aut!.alphabet < 7 then       ##  for small alphabets, the letters
#                                         ##  a, b, c, d are used
#             letters := ["a", "b", "c", "d", "e", "f"];
#             colors := ["red", "blue", "green", "yellow", "brown", "black"];
#         else
#             for i in [1 .. aut!.alphabet] do
#                 Add(letters, Concatenation("a", String(i)));
#             od;
#             colors := [];
#             for i in [1 .. aut!.alphabet] do
#                 colors[i]:= "black";
#             od;
#         fi;
#     else
#         if aut!.alphabet < 7 then       ##  for small alphabets, the letters
#                                         ##  a, b, c, d are used
#             letters := [];
#             for i in AlphabetOfAutomaton(aut) do
#                 Add(letters, [i]);
#             od;
#             colors := ["red", "blue", "green", "yellow", "brown", "black"];
#         else
#             letters := [];
#             for i in AlphabetOfAutomaton(aut) do
#                 Add(letters, [i]);
#             od;
#             colors := [];
#             for i in [1 .. aut!.alphabet] do
#                 colors[i]:= "black";
#             od;
#         fi;
#     fi;
#     if aut!.type = "epsilon" then
#         letters[aut!.alphabet] := "@";
#     fi;
#     l2 := [];
#     array := [];
#     s := [];
#     arr := List( au, x -> List( x, String ) );
#     max := Maximum( List( arr, x -> Maximum( List(x,Length) ) ) );


#     for i in [1 .. aut!.states] do
#         for j in [1 .. aut!.alphabet] do
#             xs := "";
#             xout := OutputTextString(xs, false);
#             PrintTo(xout, letters[j]);
#             if IsBound(au[j]) and IsBound(au[j][i]) and au[j][i] <> " " then
#                 if IsList(au[j][i]) then
#                     for k in au[j][i] do
#                         Add(array, [i, " -> ", k," [label=", "\"", xs,"\"",",color=", colors[j], "];"]);
#                     od;
#                 else
#                     Add(array, [i, " -> ", au[j][i]," [label=", "\"", xs,"\"",",color=", colors[j], "];"]);
#                 fi;
#             fi;
#             CloseStream(xout);
#         od;
#     od;



#     arr := List( array, x -> List( x, String ) );

#     PrintTo(name, "digraph  ", nome, "{", "\n");
#     for l  in [ 1 .. Length( arr ) ]  do
#         for k  in [ 1 .. Length( arr[ l ] ) ]  do
#             AppendTo(name,  String( arr[ l ][ k ]) );
#         od;
#         if l = Length( arr )  then
#             AppendTo(name,  "\n" );
#         else
#             AppendTo(name,  "\n" );
#         fi;
#     od;
#     # The state corresponding to the neutral element
#     pos_id := Position(Elements(M), MultiplicativeNeutralElement(M));
#     # The list of states corresponding to the idempotents
#     pos_idempotents := Set(List(Idempotents(M), e -> Position(Elements(M), e)));
#     for k in [1..aut!.states] do
#         if k = pos_id then
#             AppendTo(name, k, " [shape=circle, style=filled, fillcolor=deepskyblue];","\n");
#         elif k in pos_idempotents then
#             AppendTo(name, k, " [shape=circle, style=filled, fillcolor=lightcoral];","\n");
#         else
#             AppendTo(name, k, " [shape=circle];","\n");
#         fi;
#     od;
#     AppendTo(name,"}","\n");
    
#     CMUP__executeDotAndViewer(tdir, dot, gv, "cayleygraph.dot");
# end);


InstallMethod(SmallGeneratingSetForSemigroups,"generators subset",true,[IsSemigroup],
        function (S)
    local Dif, High, i, n, rk, SGS, U, V, US, T;

    SGS := ShallowCopy(GeneratorsOfSemigroup(S));
    n := Length(SGS);
    #
    # For some transformation semigroups the following coincides with the Jorder
    if IsTransformationSemigroup(S) then
        Sort(SGS, function(u,v) return
          RankOfTransformation(u)>RankOfTransformation(v);end);
      else
          Sort(SGS, function(u,v) return
            IsGreensLessThanOrEqual(GreensJClassOfElement(S,v),GreensJClassOfElement(S,u));end);
        fi;

        rk := Length(SGS);
        if 5*LogInt(rk,2) < rk/2 then
            High := SGS{[1..5*LogInt(rk,2)+1]};
            US := Semigroup(High);
            i := 1;
            while i < Length(High)  do
                U:=Subsemigroup(US,High{Difference([1..Length(High)],[i])});
                if Size(U)<Size(US) then
                    i:=i+1;
                else
                    High:=GeneratorsOfSemigroup(U);
                fi;
            od;
            Dif := Difference(SGS,Elements(Subsemigroup(US,High)));
            SGS := Union(Dif, High);
        fi;
        
        rk := Length(SGS);
        if rk > n/10 then
            High := SGS{[1..Int(rk/3)+1]};
            US := Semigroup(High);
            i := 1;
            while i < Length(High)  do
                U:=Subsemigroup(US,High{Difference([1..Length(High)],[Length(High)-i])});
                if Size(U)<Size(US) then
                    i:=i+1;
                else
                    High:=GeneratorsOfSemigroup(U);
                fi;
            od;
            Dif := Difference(SGS,Elements(Subsemigroup(US,High)));
            SGS := Union(Dif, High);
        fi;

        rk := Length(SGS);
        if rk > n/10 then

        High := SGS{[1..Int(rk/2)+1]};
        US := Semigroup(High);
        i := 1;
        while i < Length(High)  do
            U:=Subsemigroup(US,High{Difference([1..Length(High)],[Length(High)-i])});
            if Size(U)<Size(US) then
                i:=i+1;
            else
                High:=GeneratorsOfSemigroup(U);
            fi;
        od;
        Dif := Difference(SGS,Elements(Subsemigroup(US,High)));
        SGS := Union(Dif, High);
    fi;

    # A test...
    T := Semigroup(SGS);
    if not ForAll(GeneratorsOfSemigroup(S), i -> i in T) then
        Error("Problems in SmallGeneratingSetForSemigroups");
        #otherwise S=T
    fi;

    i := 1;
    while i < Length(SGS)  do
        U:=Subsemigroup(T,SGS{Difference([1..Length(SGS)],[Length(SGS)-i])});
        if Size(U)<Size(T) then
            i:=i+1;
        else
            SGS:=GeneratorsOfSemigroup(U);
        fi;
    od;
    
    return SGS;
end);
   
############################################################################
##
#F ReduceNumberOfGenerators(L)
## Imposing that L is a subset of the set of generators, produces a new
## set of generators.
#
InstallGlobalFunction(ReduceNumberOfGenerators, function(arg)
    return SmallGeneratingSetForSemigroups(Semigroup(Flat(arg)));
end);
