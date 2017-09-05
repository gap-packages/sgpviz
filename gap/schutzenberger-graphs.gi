############################################################################
##
#W  schutzenberger-graphs.gi            Manuel Delgado <mdelgado@fc.up.pt>
#W                                      Jose Morais    <josejoao@fc.up.pt>
##
#H  @(#)$Id: schutzenberger-graphs.gi,v 0.998 $
##
#Y  Copyright (C)  2005,  CMUP, Universidade do Porto, Portugal
##
##
###########################################################################
##
#F  DrawSchutzenbergerGraphs(S)
##
##  Draws the Schutzenberger graphs of the semigroup <S>
##
InstallGlobalFunction(DrawSchutzenbergerGraphs, function(S)
    local cg, dc, els, g, scc, graph_list, visited_dc, list,
          c, e, d, a, i, h,
          au, aut, l1, l2,  arr, array, colors, j, k, letters, max, name, aut2dc, dc2aut, dc2cnode, liga,
          nome, R, l, s, t, gv, dot, tdir, x, y, z,
          map, count, lend, box4, b5, b6, b7, fich, A, ix, dclasses, subAutomaton;

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


    if not IsSemigroup(S) then
        Error("The argument must be a semigroup");
    fi;
    if not IsInverseSemigroup(S) then
        Print("The argument is not an inverse semigroup\n");
        return;
    fi;
    if not IsTransformation(AsList(S)[1]) then
        Print("I will work with an isomorphic transformation semigroup instead\n");
        S:= Range(IsomorphismTransformationSemigroup(S));
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
    
    tdir := CMUP__getTempDir();
    gv := CMUP__getPsViewer();
    dot := CMUP__getDotExecutable();
    
    fich := "schutzenbergergraphs";
    name := Filename(tdir, Concatenation(fich, ".dot"));
    nome := "SchutzenbergerGraphs";
    PrintTo(name, "digraph  ", nome, "{\ncompound=true;\n");
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
            AppendTo(name, "subgraph cluster", ix, "{\n");

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
                    AppendTo(name,  String( arr[ l ][ k ]) );
                od;
                AppendTo(name,  "\n" );
            od;
            for i in Difference(aut!.initial, aut!.accepting) do
                AppendTo(name, map[i], " [shape=triangle];","\n");
            od;
            for j in aut!.accepting do
                if j in aut!.initial then
                    AppendTo(name, map[j], " [shape=triangle,peripheries=2];","\n");
                else
                    AppendTo(name, map[j], " [shape=doublecircle];","\n");
                fi;
            od;
            for k in Difference([1..aut!.states],Concatenation(aut!.initial, aut!.accepting)) do
                AppendTo(name, map[k], " [shape=circle];","\n");
            od;
            AppendTo(name,"}","\n");
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
        AppendTo(name, dc2cnode[x[1]], " -> ", dc2cnode[x[2]], " [lhead=cluster", x[2], ",ltail=cluster", x[1], ",color=cornflowerblue];\n");
    od;

    AppendTo(name,"}","\n");

    CMUP__executeDotAndViewer(tdir, dot, gv, Concatenation(fich, ".dot"));
end);
