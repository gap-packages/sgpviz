############################################################################
##
#W  xautomaton.gi                       Manuel Delgado <mdelgado@fc.up.pt>
#W                                      Jose Morais    <josejoao@fc.up.pt>
##
#Y  Copyright (C)  2005,  CMUP, Universidade do Porto, Portugal
##
##
###########################################################################
##
#F  XAutomaton()
##
##  Tcl/Tk interface to specify automata.
##
InstallGlobalFunction(XAutomaton, function(arg)
    local func, d, f, xautomatonstream, otu, A, args, i, s, s2, a, q, var, wish;
    
    func := function(ix)
        local i, result, s;
        
        s := ReadLine(xautomatonstream);
        while true do
            if s = "quit\n" or s = "quit\r\n" then
                UnInstallCharReadHookFunc( xautomatonstream, func );
                CloseStream(xautomatonstream);
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
            s := ReadLine(xautomatonstream);
        od;
    end;
    
    d := DirectoriesPackageLibrary( "sgpviz", "src" )[1];
    f := "xautomaton.tcl";
    wish := Filename(DirectoriesSystemPrograms(), "wish");
    if wish = fail then
        Error("Please install Tcl/Tk and make the 'wish' executable reachable by the 'PATH' environment variable");
    fi;
    if arg = [] then
        xautomatonstream := InputOutputLocalProcess(d,wish,[f]);
    else
        A := arg[1];
        if not IsAutomatonObj(A) then
            Error("Please supply no arguments to XAutomaton() or an Automaton");
        fi;
        var := "aut";
        if IsBound(arg[2]) then
            var := arg[2];
            if not IsString(var) then
                Error("The second argument to XAutomaton(), if present, must be a string");
            fi;
        fi;

        args := [var, String(A!.type), String(A!.states)];
        if IsInt(FamilyObj(A)!.alphabet) then
            Add(args, String(FamilyObj(A)!.alphabet));
        else
            Add(args, Concatenation("\"", FamilyObj(A)!.alphabet, "\""));
        fi;
        if A!.initial = [] then
            Add(args, "-1");
        else
            s2 := String(A!.initial);
            s := [];
            for i in [3..Length(s2)-2] do
                if not s2[i] = ' ' then
                    Add(s, s2[i]);
                fi;
            od;
            Add(args, s);
        fi;
        if A!.accepting = [] then
            Add(args, "-1");
        else
            s2 := String(A!.accepting);
            s := [];
            for i in [3..Length(s2)-2] do
                if not s2[i] = ' ' then
                    Add(s, s2[i]);
                fi;
            od;
            Add(args, s);
        fi;
        if A!.type = "det" then
            for a in [1..A!.alphabet] do
                for q in [1..A!.states] do
                    Add(args, String(A!.transitions[a][q]));
                od;
            od;
        else
            for a in [1..A!.alphabet] do
                for q in [1..A!.states] do
                    s2 := String(A!.transitions[a][q]);
                    s := [];
                    for i in [2..Length(s2)-1] do
                        if not s2[i] = ' ' then
                            Add(s, s2[i]);
                        fi;
                    od;
                    Add(args, s);
                od;
            od;
        fi;
        xautomatonstream := InputOutputLocalProcess(d,wish,Concatenation([f], args));
    fi;
    otu := OutputTextUser( );

    InstallCharReadHookFunc( xautomatonstream, "r", func );
end);
