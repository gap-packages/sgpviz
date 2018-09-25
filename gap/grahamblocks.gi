############################################################################
##
#W  grahamblocks.gi                     Manuel Delgado <mdelgado@fc.up.pt>
#W                                      Jose Morais    <josejoao@fc.up.pt>
##
#Y  Copyright (C)  2005,  CMUP, Universidade do Porto, Portugal
##
##
##--------------------------------------------------------------------------
##
#F  GrahamBlocks(mat_input)
##
##  This function returns [mat, phi]
##  where mat is in Graham blocks form
##  and phi[i][j] = [i', j'] where mat_input[i'][j'] = mat[i][j]

InstallGlobalFunction(GrahamBlocks, function(mat_input)
    local i, j, k, r, c, x, mrows, mcols, rows, cols, marked_rows, marked_cols, lens,
          bag_rows, bag_cols, el, max, mat, mat2, seen_rows, bool,
          gcol, grow, phi, phi2, growb, gcolb, line, column,
          markRowsAndCols, exchangeRows, exchangeCols;
    
    
    markRowsAndCols := function(L)
        local i, j, r, c, list, list2;
        
        list := [];
        for i in L do
            if seen_rows[i] = 0 then
                # Mark row i
                for j in [1..cols] do
                    if mat[i][j] = 1 then
                        AddSet(mrows[i], j);
                        AddSet(list, j);
                        AddSet(marked_rows, i);
                    fi;
                od;
            fi;
        od;
        list2 := [];
        for j in list do
            if not j in marked_cols then
                # Mark column j
                for r in [1..rows] do
                    if mat[r][j] = 1 then
                        AddSet(mcols[j], r);
                        AddSet(list2, r);
                        AddSet(marked_cols, j);
                    fi;
                od;
            fi;
        od;
        if not list2 = [] then
            markRowsAndCols(list2);
        fi;
    end;
    ##  End of markRowsAndCols()  --
    
    
    # Exchange rows a and b
    exchangeRows := function(a, b)
        local j;
        
#        Print("Exchanging rows ", a, " and ", b, "\n");
        mat2[a] := List(mat[b], x -> x);
            
        for j in [1..cols] do
            phi2[a][j][1] := phi[b][j][1];
        od;
        
    end;
    ##  End of exchangeRows()  --
    
    
    # Exchange columns a and b
    exchangeCols := function(a, b)
        local i;
        
#        Print("Exchanging cols ", a, " and ", b, "\n");
        for i in [1..rows] do
            mat[i][a] := mat2[i][b];
            
            phi[i][a][2] := phi2[i][b][2];
        od;
        
    end;
    ##  End of exchangeCols()  --
    
    
    # =========== Main Code ============
    
    #    mat := List(mat_input, line -> List(line, x -> x));
    mat := ShallowCopy(mat_input);
    grow := 1;
    gcol := 1;
    rows := Length(mat);
    cols := Length(mat[1]);
    seen_rows := List([1..rows], x -> 0);
    phi := List([1..rows], i -> List([1..cols], j -> [i, j]));
    
    repeat
        bool := false;
        mrows := List([1..rows], x -> []);
        mcols := List([1..cols], x -> []);
        marked_rows := [];
        marked_cols := [];
        
        for i in [1..rows] do
            if 1 in mat[i] and seen_rows[i] = 0 then
                markRowsAndCols([i]);
                bool := true;
                break;
            fi;
        od;

        # Update seen rows
        c := 0;
        for i in marked_rows do
            seen_rows[grow + c] := 1;
            c := c + 1;
        od;
        
        # If at least 2 rows were marked
        if IsBound(marked_rows[2]) then
            #Determine the biggest length of all rows
            lens := [];
            for x in marked_rows do
                lens[x] := Length(mrows[x]);
            od;
            max := Maximum(lens);
        
            # Check the least numbered cols
            bag_rows := [];
            for i in marked_rows do
                for k in [1..max-lens[i]] do
                    # [..., 3, ...] should come first than
                    # [...,  , ...] 
                    Add(mrows[i], 10^7);
                od;
                AddSet(bag_rows, [mrows[i], i]);
            od;
            
            # Move lines up
            mat2 := List(mat, line -> List(line, x -> x));  # duplicate mat
            phi2 := List(phi, line -> List(line, x -> [x[1], x[2]]));  # duplicate phi
            growb := grow;
            for el in bag_rows do
                exchangeRows(grow, el[2]);
                grow := grow + 1;
            od;
            line := Difference([growb..rows], marked_rows);
            j := 1;
            for i in [grow..rows] do
                exchangeRows(i, line[j]);
                j := j + 1;
            od;

            # Move cols left
            mat := List(mat2, line -> List(line, x -> x));
            phi := List(phi2, line -> List(line, x -> [x[1], x[2]]));
            gcolb := gcol;
            for j in marked_cols do
                exchangeCols(gcol, j);
                gcol := gcol + 1;
            od;
            column := Difference([gcolb..cols], marked_cols);
            j := 1;
            for i in [gcol..cols] do
                exchangeCols(i, column[j]);
                j := j + 1;
            od;
            
        # If only one row was seen
        elif IsBound(marked_rows[1]) then
            # Move lines up
            mat2 := List(mat, line -> List(line, x -> x));  # duplicate mat
            phi2 := List(phi, line -> List(line, x -> [x[1], x[2]]));  # duplicate phi
            exchangeRows(grow, marked_rows[1]);
            grow := grow + 1;

            # Move cols left
            mat := List(mat2, line -> List(line, x -> x));
            phi := List(phi2, line -> List(line, x -> [x[1], x[2]]));
            gcolb := gcol;
            for j in marked_cols do
                exchangeCols(gcol, j);
                gcol := gcol + 1;
            od;
            column := Difference([gcolb..cols], marked_cols);
            j := 1;
            for i in [gcol..cols] do
                exchangeCols(i, column[j]);
                j := j + 1;
            od;
        fi;
    until Sum(seen_rows) = rows;
    
    
    return([mat, phi]);
end);
