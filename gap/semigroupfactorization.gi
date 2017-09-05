############################################################################
##
#W  semigroupfactorization.gi           Manuel Delgado <mdelgado@fc.up.pt>
#W                                      Jose Morais    <josejoao@fc.up.pt>
##
#H  @(#)$Id: semigroupfactorization.gi,v 0.998 $
##
#Y  Copyright (C)  2005,  CMUP, Universidade do Porto, Portugal
##
##
###########################################################################
#====================================================================
#siegen(17/09/05): after adapting the code to use the function "factorization" of the "semigroups" package, this function is no longer needed
#====================================================================

InstallGlobalFunction(SemigroupFactorization, function(S, L)
    local cg, els, gens, gens2, p1, path, fact, M, G, current, current2, el,
          map, visited, els_len, L_vis, L_len, L_pos, p, gensx,
          T, iso,
          path2fact,
          i, j, k, a, q, s, g, v;


    path2fact := function(p)
        local f, i, len;

        f := [];
        len := Length(p);
        for i in [1..len-1] do
            Add(f, gens[T[p[i]][p[i+1]]]);
        od;
        return(f);
    end;
    ## End of path2fact()  --


    if not (IsSemigroup(S) or IsMonoid(S)) then
        Error("The first argument must be a semigroup");
    fi;
#    if not IsTransformation(AsList(S)[1]) then
    if not IsTransformationSemigroup(S) then
        Print("I will work with an isomorphic transformation semigroup instead\n");
        iso := IsomorphismTransformationSemigroup(S);
        S := Range(iso);
        S := Semigroup(ReduceNumberOfGenerators(GeneratorsOfSemigroup(S)));
        L := List(L, x->ImageElm(iso,x));
    fi;

    if MultiplicativeNeutralElement(S) = fail then
        M := Monoid(Set(GeneratorsOfSemigroup(S)));
        gens2 := GeneratorsOfMonoid(M);
    else
        gens2 := Set(GeneratorsOfSemigroup(S));
        gensx := Difference(gens2,[IdentityTransformation]);
        
        # for el in gens2 do
        #     if not el = MultiplicativeNeutralElement(S) or (IsTransformation(MultiplicativeNeutralElement(S)) and
        #    not MultiplicativeNeutralElement(S) = IdentityTransformation(DegreeOfTransformationSemigroup(S)) then
        #         Add(gensx, el);
        #     fi;
        # od;
#        if IsTransformation(MultiplicativeNeutralElement(S)) and
#           not MultiplicativeNeutralElement(S) = IdentityTransformation(DegreeOfTransformation(MultiplicativeNeutralElement(S))) then
#            Add(gensx, MultiplicativeNeutralElement(S));
#        fi;
        if gensx = [] then
            gensx := [ShallowCopy(MultiplicativeNeutralElement(S))];
        fi;
        M := Monoid(gensx);
        gens2 := GeneratorsOfMonoid(M);
    fi;

    gens := [];
    for el in gens2 do
        if not el = MultiplicativeNeutralElement(M) then
            Add(gens, el);
        fi;
    od;

    els := Elements(M);
    els_len := Size(M);
    if not IsList(L) then
        L := [L];
    fi;
    if L = [] then
        return([]);
    fi;
    if ForAny(L, x -> not x in els) then
        Error("The second argument must be a list of elements of the given semigroup");
    fi;


    cg := RightCayleyGraphAsAutomaton(M);
    G := UnderlyingGraphOfAutomaton(cg);



    L_len := Length(L);
    L_vis := 0;
    L_pos := Set(List(L, x -> Position(els, x)));
    if MultiplicativeNeutralElement(M) in L then
        L_len := L_len - 1;
        p := Position(els, MultiplicativeNeutralElement(M));
        RemoveSet(L_pos, p);
    fi;


    T := NullMat(els_len, els_len);
    for a in [1..cg!.alphabet] do
        for q in [1..cg!.states] do
            T[q][cg!.transitions[a][q]] := a;
        od;
    od;

    p1 := Position(els, MultiplicativeNeutralElement(M));

    visited := [];
    path := [];
    fact := [];
    for i in [1..els_len] do
        visited[i] := false;
    od;
    path[p1] := [p1];
    fact[p1] := [MultiplicativeNeutralElement(M)];

    current := [[p1, G[p1]]];
    while L_vis < L_len do
        current2 := [];
        for el in current do
            for v in el[2] do
                if not visited[v] then
                    visited[v] := true;
                    path[v] := ShallowCopy(path[el[1]]);
                    Add(path[v],v);
                    if v in L_pos then
                        L_vis := L_vis + 1;
                    fi;
                    Add(current2, [v, G[v]]);
                fi;
            od;
        od;
        current := current2;
    od;

    for i in L_pos do
        fact[i] := path2fact(path[i]);
    od;
    return(List(L, x -> fact[Position(els, x)]));
end);
