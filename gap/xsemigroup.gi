############################################################################
##
#W  xsemigroup.gi                       Manuel Delgado <mdelgado@fc.up.pt>
#W                                      Jose Morais    <josejoao@fc.up.pt>
##
#H  @(#)$Id: xemigroup.gi,v 0.998 $
##
#Y  Copyright (C)  2005,  CMUP, Universidade do Porto, Portugal
##
##
###########################################################################
##
#F  XSemigroup()
##
##  Tcl/Tk interface to specify a semigroup
##
InstallGlobalFunction(XSemigroup, function(arg)
    local func, d, f, xsemigroupstream, otu, A, args, i, j, s, s2, t, a, q, var, S, gens, dg, l, r,
          list, zero, zind, partial, len, wish,
          rel, leng;

    func := function(ix)
        local i, result, s;

        s := ReadLine(xsemigroupstream);
        while true do
            if s = "quit\n" or s = "quit\r\n" then
                UnInstallCharReadHookFunc( xsemigroupstream, func );
                CloseStream(xsemigroupstream);
                CloseStream(otu);
                break;
            elif s = "end\n" or s = "end\r\n" then
                break;
            else
                Print(s);
                result := READ_COMMAND_REAL( InputTextString(s) , true );
                if result[1] = true then
                  if IsBound(result[2]) then
                    View(result[2]);
                  fi;
                # result := READ_COMMAND( InputTextString(s) , true );
                # if not result = SuPeRfail then
                #     View(result);
                    Print("\n");
                fi;
                PrintTo(otu, "gap> ");
            fi;
            s := ReadLine(xsemigroupstream);
        od;
    end;

    d := DirectoriesPackageLibrary( "sgpviz", "src" )[1];
    f := "xsemigroup.tcl";    
    wish := Filename(DirectoriesSystemPrograms(), "wish");
    if wish = fail then
        Error("Please install Tcl/Tk and make the 'wish' executable reachable by the 'PATH' environment variable");
    fi;
    if arg = [] then
        xsemigroupstream := InputOutputLocalProcess(d,wish,[f]);
    else
        S := arg[1];
        if IsTransformationSemigroup(S) then
            if IsMonoid(S) then
                args := ["M", "1", "2"];
                gens := GeneratorsOfMonoid(S);
            else
                args := ["S", "0", "2"];
                gens := GeneratorsOfSemigroup(S);
            fi;
            leng := Length(gens);
##            dg := DegreeOfTransformation(gens[1]);
            dg := DegreeOfTransformationSemigroup(S);

            # Check if the transitions are partial
            list := List(gens, g -> ImageListOfTransformation(g));
            partial := ForAll(list, lx -> lx[dg] = dg);
            zero := list[1][dg];
            zind := dg;

            if partial and dg > 1 then
                args[3] := "4";
                Add(args, String(leng));
                Add(args, String(dg-1));
                for i in [1..leng] do
                    l := ImageListOfTransformation(gens[i]);
                    for j in Difference([1..dg], [zind]) do
                        t := l[j];
                        if t = zero then
                            Add(args, "0");
                        else
                            Add(args, String(t));
                        fi;
                    od;
                od;
            else
                Add(args, String(leng));
                Add(args, String(dg));
                for i in [1..leng] do
                    l := ImageListOfTransformation(gens[i]);
                    for j in l do
                        Add(args, String(j));
                    od;
                od;
            fi;
        elif IsFpSemigroup(S) then
            args := ["S", "0", "1"];
            gens := GeneratorsOfSemigroup(S);
            leng := Length(gens);
            rel := RelationsOfFpSemigroup(S);
            Add(args, String(leng));
            Add(args, String(Length(rel)));
            for r in rel do
                s := String(r);
                s2 := "";
                for j in [3..Length(s) - 2] do
                    if s[j] = '^' or s[j] = ' ' or s[j] = '*' then
                    elif s[j] = ',' then
                        Add(args, s2);
                        s2 := "";
                    else
                        Add(s2, s[j]);
                    fi;
                od;
                Add(args, s2);
            od;
        elif IsFpMonoid(S) then
            args := ["M", "1", "1"];
            gens := GeneratorsOfMonoid(S);
            if gens[1] = MultiplicativeNeutralElement(S) then
                leng := Length(gens) - 1;
            else
                leng := Length(gens);
            fi;
            rel := RelationsOfFpMonoid(S);
            Add(args, String(leng));
            Add(args, String(Length(rel)));
            for r in rel do
                s := String(r);
                s2 := "";
                for j in [3..Length(s) - 2] do
                    if s[j] = '^' or s[j] = ' ' or s[j] = '*' then
                    elif s[j] = ',' then
                        Add(args, s2);
                        s2 := "";
                    else
                        Add(s2, s[j]);
                    fi;
                od;
                Add(args, s2);
            od;
        else
            Error("Correct me");
        fi;
        xsemigroupstream := InputOutputLocalProcess(d,wish,Concatenation([f], args));
    fi;
    otu := OutputTextUser( );

    InstallCharReadHookFunc( xsemigroupstream, "r", func );
end);
