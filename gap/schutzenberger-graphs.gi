############################################################################
##
#W  schutzenberger-graphs.gi            Manuel Delgado <mdelgado@fc.up.pt>
#W                                      Jose Morais    <josejoao@fc.up.pt>
##
##
#Y  Copyright (C)  2005,  CMUP, Universidade do Porto, Portugal
##
##
###########################################################################
##
#F  DotForDrawingSchutzenbergerGraphs(S)
##
##  returns DOT code for the Schutzenberger graphs of the semigroup <S>
##
InstallGlobalFunction(DotForDrawingSchutzenbergerGraphs, function(sgp)
  local  subAutomaton, S, cg, dc, els, g, scc, graph_list, visited_dc, list, 
         aut2dc, dc2aut, c, e, d, aut, lend, i, k, box4, j, b5, b7, count, 
         map, dotstr, dc2cnode, x, ix, A, h, letters, au, colors, l2, array, 
         s, arr, max, l, liga, y;

  subAutomaton := function ( A, S, I, F )
    local  i, M, N, s, a, q, l;
    N := Length( S );
    if A!.type = "det"  then
      M := NullMat( A!.alphabet, N );
      for i  in [ 1 .. N ]  do
        for a  in [ 1 .. A!.alphabet ]  do
          q := A!.transitions[a][S[i]];
          if q in S  then
            M[a][i] := Position( S, q );
          fi;
        od;
      od;
      return Automaton( "det", N, FamilyObj( A )!.alphabet, M, List( I, function ( x )
        return Position( S, x );
      end ), List( F, function ( x )
        return Position( S, x );
      end ) );
    else
      M := [  ];
      for a  in [ 1 .. A!.alphabet ]  do
        M[a] := [  ];
        for i  in [ 1 .. N ]  do
          M[a][i] := [  ];
        od;
      od;
      for i  in [ 1 .. N ]  do
        for a  in [ 1 .. A!.alphabet ]  do
          l := A!.transitions[a][S[i]];
          for q  in l  do
            if q in S  then
              Add( M[a][i], Position( S, q ) );
            fi;
          od;
        od;
      od;
      return Automaton( A!.type, N, FamilyObj( A )!.alphabet, M, List( I, function ( x )
        return Position( S, x );
      end ), List( F, function ( x )
        return Position( S, x );
      end ) );
    fi;
    return;
  end;
  ##  End of subAutomaton()  --


  if not IsSemigroup(sgp) then
    Error("The argument must be a semigroup");
  fi;
  if not IsInverseSemigroup(sgp) then
    Print("The argument is not an inverse semigroup\n");
    return;
  fi;
  if not IsTransformation(AsList(sgp)[1]) then
    Print("I will work with an isomorphic transformation semigroup instead\n");
    S:= Range(IsomorphismTransformationSemigroup(sgp));
  fi;
  # to face the fact that semigroups behave differently depending on the use or not of the "semigroups" package, a fresh object is created 
  if IsMonoid(sgp) then 
    S := Monoid(GeneratorsOfMonoid(sgp));
  elif IsSemigroup(sgp) then
    S := Semigroup(GeneratorsOfSemigroup(sgp));
  fi;  


  cg := RightCayleyGraphAsAutomaton(S);
  dc := GreensDClasses(S);
  els := Elements(S);
  g := UnderlyingGraphOfAutomaton(cg);
  scc := GraphStronglyConnectedComponents(g);
  graph_list := [];
  visited_dc := [];
  list := [];
  aut2dc := [];
  dc2aut := [];
  for c in scc do
    e := els[c[1]];
    d := GreensDClassOfElement(S, e);
    if not d in visited_dc then
      Add(visited_dc, d);
      aut := subAutomaton(cg, c, [], []);
      Add(graph_list, aut);
      Add(aut2dc, Position(dc, d));
    fi;
  od;

  lend := Length(dc);
  for i in [1..lend] do
    k := aut2dc[i];
    dc2aut[k] := i;
  od;
  box4 := [];
  for i in [1..lend] do
    box4[i] := [];
    list := [1..lend];
    RemoveSet(list, i);
    for j in list do
      if IsGreensLessThanOrEqual(dc[i], dc[j]) then
        Add(box4[i], j);
      fi;
    od;
  od;
  j := 1;
  b5 := [];
  b7 := StructuralCopy(box4);
  visited_dc := [];
  for i in [1..lend] do
    visited_dc[i] := false;
  od;
  while not ForAll(visited_dc, b->b) do
    for i in [1..lend] do
      if b7[i] = [] then
        if not IsBound(b5[j]) then
          b5[j] := [];
        fi;
        Add(b5[j], i);
        b7[i] := [0];
        visited_dc[i] := true;
      fi;
    od;
    for i in [1..lend] do
      b7[i] := Difference(b7[i], b5[j]);
    od;
    j := j + 1;
  od;

  count := 1;
  map := [];

  dotstr:= "digraph  SchutzenbergerGraphs{\ncompound=true;\n";
  dc2cnode := [];
  for x in b5 do
    for ix in x do
      A := graph_list[dc2aut[ix]];
      for h in [1..A!.states] do
        map[h] := count;
        count := count + 1;
      od;

      aut := A;
      dc2cnode[ix] := map[1];
      Append(dotstr, Concatenation("subgraph cluster", String(ix)));
      Append(dotstr, "{\n");

      letters := [];
      au := StructuralCopy(aut!.transitions);
      for i in [1 .. Length(aut!.transitions)] do
        for j in [1 .. Length(aut!.transitions[1])] do
          if not IsBound(au[i][j]) or au[i][j] = 0 or au[i][j] = [0] then
            au[i][j] := " ";
          fi;
        od;
      od;

      if IsInt(FamilyObj(aut)!.alphabet) then
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
          for i in FamilyObj(A)!.alphabet do
            Add(letters, [i]);
          od;
          colors := ["red", "blue", "green", "yellow", "brown", "black"];
        else
          letters := [];
          for i in FamilyObj(A)!.alphabet do
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
      arr := List( au, x -> List( x, String ) );
      max := Maximum( List( arr, x -> Maximum( List(x,Length) ) ) );

      for i in [1 .. aut!.states] do
        for j in [1 .. aut!.alphabet] do
          if IsBound(au[j]) and IsBound(au[j][i]) and
             au[j][i] <> " " then
            if IsList(au[j][i]) then
              for k in au[j][i] do
                Add(array, [map[i], " -> ", map[k]," [label=", "\"", letters[j],"\"",",color=", colors[j], "];"]);
              od;
            else
              Add(array, [map[i], " -> ", map[au[j][i]]," [label=", "\"", letters[j],"\"",",color=", colors[j], "];"]);
            fi;
          fi;

        od;
      od;

      arr := List( array, x -> List( x, String ) );


      for l  in [ 1 .. Length( arr ) ]  do
        for k  in [ 1 .. Length( arr[ l ] ) ]  do
          Append(dotstr,  String( arr[ l ][ k ]) );
        od;
        Append(dotstr,  "\n" );
      od;
      for i in Difference(aut!.initial, aut!.accepting) do
        Append(dotstr, Concatenation(String(map[i]), " [shape=triangle];\n"));
      od;
      for j in aut!.accepting do
        if j in aut!.initial then
          Append(dotstr, Concatenation(String(map[j]), " [shape=triangle,peripheries=2];\n"));
        else
          Append(dotstr, Concatenation(String(map[j]), " [shape=doublecircle];\n"));
        fi;
      od;
      for k in Difference([1..aut!.states],Concatenation(aut!.initial, aut!.accepting)) do
        Append(dotstr, Concatenation(String(map[k]), " [shape=circle];","\n"));
      od;
      Append(dotstr,"}\n");
      map := [];
    od;
  od;

  liga := [];
  for i in [1..Length(b5)-1] do
    for x in b5[i+1] do
      for y in b5[i] do
        if IsGreensLessThanOrEqual(dc[x], dc[y]) then
          Add(liga, [y,x]);
        fi;
      od;
    od;
  od;
  for x in liga do
    Append(dotstr, Concatenation(String(dc2cnode[x[1]]), " -> "));

    Append(dotstr, Concatenation(String(dc2cnode[x[2]]), " [lhead=cluster"));

    Append(dotstr, Concatenation(String(x[2]), ",ltail=cluster"));
    Append(dotstr, Concatenation(String(x[1]), ",color=cornflowerblue];\n"));
  od;

  Append(dotstr,"}\n");
  return dotstr;

end);
