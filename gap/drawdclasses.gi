############################################################################
##
#W  drawdclasses.gi                     Manuel Delgado <mdelgado@fc.up.pt>
#W                                      Jose Morais    <josejoao@fc.up.pt>
##
#H  @(#)$Id: drawdclasses.gi,v 0.998 $
##
#Y  Copyright (C)  2005,  CMUP, Universidade do Porto, Portugal
##
##
##--------------------------------------------------------------------------------
InstallGlobalFunction(DotForDrawingDClassOfElement, function(arg)
  local S,                          # The semigroup
        El,                         # The element whose D-class we'll draw
        dc,                         # one d-class
        cl, cl2, cl3,               # index of one certain d-class in dclasses
        el, el2,                    # one element of an H-class
        dclasses,
        len_dclasses,               # number of d-classes
        dc_number,                  # the number of the dot node of a D-class
        eggbox, eggbox2,
        idegg, idegg2,
        line, col,
        ident,
        existsPathFromAtoB,         # matrix with true in [i][j] iff
        # there is there is a path of arrows
        # from dclasses[i] to dclasses[j]
        phi,                        # phi[i][j] = [i', j'] where
        # mat_input[i'][j'] = mat[i][j]
        # where mat_input is the input matrix to
        # GrahamBlocks (it will
        # reference entries in eggbox!
        # and mat is graham_eggbox
        box4,                       # Defined where used
        box5,                       # Defined where used
        lenb,                       # Length of box5 which is the number of
        # levels in the drawing
        visited, list,              # auxiliary arrays
        greens_less_than,           # matrix with true in [i][j] iff
        # dclasses[i] <= dclasses[j]
        #siegen          file,                       # name of the file where dot code
        dotstring,                       # name of the string storing the dot code
        # will be written
        bag, bag2,                  # matrix such that bag[i][j] = L
        # where L is the list of elements of the
        # H-class currently being processed
        # ready for being written according to
        # whether we're writing as transformations
        # or words
        zero,                       # The "zero" on the transformations if partial
        is_partial,                 # whether the transformations are partial
        trans_list,				  # The list of lists of elements to be coloured
        len_trans_list,
        generators, generatorsx,
        genslen,
        colors, color,
        #       fich,                       # the name of the dot file given as argument
#        gv, dot, tdir,
        alphabet,
#        idempots,                   # Idempotents of the semigroup
        idempots2,                  # ImageListOfTransformation of idempots
        T,                          # whether we're displaying as transformations
        T__,                        # To hold the value of last argument (may be 1 or 2 or none)
        # to either display the transformations as transformations
        # or as an integer (like in the right Cayley Graph).
        elms__,                     # The elements of S
        idemps__,                   # Idempotents of the semigroup
        str, str1, str2,
        tlen,
        rows, cols, val,
        retels,
        i, j, k, k2, p, m, c, ret, px, map,
        powerizeWord;



  # ==========================================

  # if we're displaying as words this function
  # replaces 2 or more followd occurrences of
  # letter a by a^...
  powerizeWord := function(w)
    local w2, c, j, a;

    w2 := [];
    c := 0;
    for j in [1..Length(w)] do
      if c = 0 then
        a := w[j];
        c := 1;
      elif w[j] = a then
        c := c + 1;
      else
        if c = 1 then
          Add(w2, a);
        else
          w2 := Concatenation(w2, [a], "^", String(c));
        fi;
        c := 1;
        a := w[j];
      fi;
    od;
    if c = 1 then
      Add(w2, a);
    else
      w2 := Concatenation(w2, [a], "^", String(c));
    fi;
    return(w2);
  end;
  ##  End of powerizeWord()  --

  # alphabet for displaying as words
  alphabet := "abcdefghijklmnopqrstuvwxyz";

  colors := [ "brown", "burlywood", "cadetblue", "chartreuse", "chocolate", "coral", "cornflowerblue",
              "crimson", "cyan", "darkgoldenrod", "darkkhaki", "darkorange", "darkorchid",
              "darksalmon", "darkseagreen", "darkturquoise",
              "darkviolet", "deeppink", "deepskyblue", "dodgerblue", "firebrick",
              "forestgreen", "gold", "goldenrod", "green", "greenyellow", "grey",
              "hotpink", "indianred", "khaki", "lawngreen",
              "lightblue", "lightcoral",
              "lightpink", "lightsalmon", "lightseagreen", "lightskyblue", "lightslateblue",
              "lightslategrey", "limegreen", "magenta",
              "maroon", "mediumaquamarine", "mediumorchid", "mediumpurple", "mediumseagreen",
              "mediumspringgreen", "mediumturquoise", "mediumvioletred",
              "moccasin", "navajowhite", "olivedrab2", "orange", "orangered",
              "orchid", "palegreen", "paleturquoise", "palevioletred", "peachpuff", "peru",
              "pink", "plum", "powderblue", "purple", "red", "rosybrown", "royalblue1", "saddlebrown", "salmon",
              "sandybrown", "seagreen", "skyblue", "slateblue", "slategrey",
              "springgreen", "steelblue", "tan", "thistle", "tomato", "turquoise", "violet", "violetred",
              "wheat", "yellow", "yellowgreen" ];

  if not (IsBound(arg[1]) and IsBound(arg[2])) then
    Error("Two arguments must be given");
  fi;

  # to face the fact that semigroups behave differently depending on the use or not of the "semigroups" package, a fresh object is created 
  if IsMonoid(arg[1]) then 
    S := Monoid(GeneratorsOfMonoid(arg[1]));
  elif IsSemigroup(arg[1]) then
    S := Semigroup(GeneratorsOfSemigroup(arg[1]));
  else
    Error("The first argument must be a semigroup");
  fi;  

  if not arg[2] in arg[1] then
    Error("The second argument must be an element of the senigroup, which is given as first");
  else
    El := arg[2];
  fi;
  if not (IsTransformationMonoid(S) or IsTransformationSemigroup(S)) then
    Print("I will work with an isomorphic transformation semigroup instead\n");
    map := IsomorphismTransformationSemigroup(S);

    S:= Range(map);
    El := ImagesElm(map,El)[1];

    S := Semigroup(ReduceNumberOfGenerators(GeneratorsOfSemigroup(S)));
  fi;

  tlen := DegreeOfTransformationSemigroup(S);

  elms__ := Elements(S);
  idemps__ := Idempotents(S);
  idempots2 := List(idemps__, x -> ImageListOfTransformation(x,tlen));

  T := false;                          # Display as transformations
  trans_list := [];                    # the list of lists of elements
  # to draw in colors given by the user.

  for i in [3..Length(arg)] do
    if 
      IsList(arg[i]) then
      if not ForAll(arg[i], e -> IsTransformation(e)) then
        Error("The list of elements must be a list of Transformations ", arg[i]);
      fi;
      Add(trans_list, Set(List(arg[i], trans -> ImageListOfTransformation(trans))));
    elif i = Length(arg) and (arg[i] = 1 or arg[i] = 2) then
      T := true;
      T__ := arg[i];
    else
      Error("The arguments must be: <semigroup>, <element>, [, list of elements]* [, file name]");
    fi;
  od;
  len_trans_list := Length(trans_list);

  ##  We will check if the transformations are partial or total
  generators := GeneratorsOfSemigroup(S);
  genslen := Length(generators);
  generatorsx := [];
  for el in generators do
    if not el = IdentityTransformation then
      Add(generatorsx, el);
    fi;
  od;
  Sort(generatorsx);

  # Determine if transitions are partial
  # and determine the "zero" digit
  is_partial := ForAll(List(generators, g -> ImageListOfTransformation(g,tlen)), lx -> lx[tlen] = tlen);
  zero := tlen;

  # ============= Main Code ==================

  dclasses := [GreensDClassOfElement(S, El)];
  len_dclasses := Length(dclasses);
  dc_number := 1;

  if not T then
    retels := [Elements(dclasses[1]), SemigroupFactorization(S, Elements(dclasses[1])),[]];
  fi;

  #initializing the dotstring
  dotstring := "digraph  DClassOfElement {\ngraph [center=yes,ordering=out];\nnode [shape=plaintext];\nedge [color=cornflowerblue,arrowhead=none];\n";


  # For each d-class write the dot record node
  for dc in dclasses do
    eggbox := EggBoxOfDClass(dc);
    rows := Length(eggbox);
    cols := Length(eggbox[1]);

    idegg := List(eggbox, r->List(r,
                     function(h)
      if IsGroupHClass(h) then
        return 1;
      else
        return 0;
      fi;
    end));


    ##  Order the columns lexicographically
    line := List([1..cols], x -> [Representative(eggbox[1][x]), x]);
    Sort(line);
    eggbox2 := NullMat(rows, cols);
    idegg2 := NullMat(rows, cols);

    j := 1;
    for el in line do
      for i in [1..rows] do
        eggbox2[i][j] := ShallowCopy(eggbox[i][el[2]]);
        idegg2[i][j] := ShallowCopy(idegg[i][el[2]]);
      od;
      j := j + 1;
    od;

    ##  Order the rows lexicographically
    col := List([1..rows], x -> [Representative(eggbox[x][1]), x]);
    Sort(col);
    eggbox := NullMat(rows, cols);
    idegg := NullMat(rows, cols);
    i := 1;
    for el in col do
      for j in [1..cols] do
        eggbox[i][j] := ShallowCopy(eggbox2[el[2]][j]);
        idegg[i][j] := ShallowCopy(idegg2[el[2]][j]);
      od;
      i := i + 1;
    od;


    if IsRegularDClass(dc) then
      ret := GrahamBlocks(idegg);
      phi := ret[2];
    fi;

    bag := [];
    bag2 := [];
    for k in [1..rows] do
      bag[k] := [];
      bag2[k] := [];
      for p in [1..cols] do
        bag2[k][p] := [];
      od;
    od;

    #siegen: in the following, "AppendTo(file," was replaced by "Append(dotstring,"


    # Write the dot node definition of the current
    # D-class
    Append(dotstring, Concatenation(String(dc_number), " [label=<\n<TABLE BORDER=\"0\" CELLBORDER=\"0\" CELLPADDING=\"0\" CELLSPACING=\"0\" PORT=\"", String(dc_number), "\">\n"));  # opens the D-class and
    # first column for writing

    # Visit left column first, then second,... because of dot
    for i in [1..rows] do
      Append(dotstring, "<TR>");
      for j in [1..cols] do
        # Write H-class [i][j] from current eggbox
        # With the list of
        # elements of an H-class writes the
        # corresponding cell of the dot record node
        # in the current D-class node
        Append(dotstring, "<TD BORDER=\"0\">");  # opens h-class

        # bag2[i][j] is the list of elements
        # of eggbox[i'][j'] where i' = phi[i][j][1]
        # and j' = phi[i][j][2], formatted for being written
        # phi is needed because GrahamBlocks was called.
        if IsRegularDClass(dc) then
          # If we're displaying as transformations
          if T then
            bag[i][j] := List(Elements(eggbox[phi[i][j][1]][phi[i][j][2]]), x -> ImageListOfTransformation(x,tlen));
            if T__ = 1 then
              # if the transformations are partial
              if is_partial then
                for el in bag[i][j] do
                  # replace the "zero" by "_"
                  list := [];
                  for p in [1..zero-1] do
                    if el[p] = zero then
                      Add(list, "_");
                    elif el[p] > zero then
                      Add(list, el[p]-1);
                    else
                      Add(list, el[p]);
                    fi;
                  od;
                  for p in [zero+1..tlen] do
                    if el[p] = zero then
                      Add(list, "_");
                    elif el[p] > zero then
                      Add(list, el[p]-1);
                    else
                      Add(list, el[p]);
                    fi;
                  od;
                  if list = [] then
                    Add(list, "_");
                  fi;
                  # End of replace the "zero" by "_"

                  # str2 will be the written string
                  str := String(list);
                  # if it's an idempot put the "*"
                  if el in idempots2 then
                    str2 := ['*'];
                  else
                    str2 := [];
                  fi;
                  # Remove '"'
                  for c in str do
                    if not c = '"' then  #"
                       Add(str2, c);
                    fi;
                  od;
                  # add element for write
                  if str2[6] = '.' then
                    ident := List([1..tlen], x -> x);
                    if str2[1] = '*' then
                      str2 := Concatenation("*", String(ident));
                    else
                      str2 := String(ident);
                    fi;
                  fi;
                  Add(bag2[i][j], str2);
                od;
                # If the transformations are total
              else
                # Add '*' if it's an idempotent
                for el in bag[i][j] do
                  if el in idempots2 then
                    ##                                        if String(el)[6] = '.' then
                    if el = [] then
                      Add(bag2[i][j], Concatenation("*", String(List([1..tlen], x -> x))));
                    else
                      Add(bag2[i][j], Concatenation("*", String(el)));
                    fi;
                  else
                    Add(bag2[i][j], String(el));
                  fi;
                od;
              fi;
            else  # Display transformations as integers
              # Add '*' if it's an idempotent
              for el in Elements(eggbox[phi[i][j][1]][phi[i][j][2]]) do
                if el in idemps__ then
                  ##                                    if String(el)[6] = '.' then
                  if el = [] then
                    Add(bag2[i][j], Concatenation("*", String(List([1..tlen], x -> x))));
                  else
                    Add(bag2[i][j], Concatenation("*", String(Position(elms__, el))));
                  fi;
                else
                  Add(bag2[i][j], String(Position(elms__, el)));
                fi;
              od;
            fi;
            # If we're displaying as words
          else
            bag[i][j] := Elements(eggbox[phi[i][j][1]][phi[i][j][2]]);
            for el in bag[i][j] do
              if el = MultiplicativeNeutralElement(S) then
                str1 := "1";
                retels[3][Position(retels[1], el)] := "1";
              elif el = MultiplicativeZero(S) then
                str1 := "0";
                retels[3][Position(retels[1], el)] := "0";
              else
                px := Position(retels[1], el);
                ret := retels[2][px];
                str1 := [];
                if genslen > 26 then
                  for el2 in ret do
                    str1 := Concatenation(str1, "a", String(Position(generatorsx, el2)));
                  od;
                else
                  for el2 in ret do
                    Add(str1, alphabet[Position(generatorsx, el2)]);
                  od;
                fi;
                str1 := powerizeWord(str1);
                retels[3][px] := str1;
              fi;
              if el in idemps__ then
                Add(bag2[i][j], Concatenation("*", str1));
              else
                Add(bag2[i][j], str1);
              fi;
            od;
            # 	bag[i][j] := List(bag[i][j], x -> ImageListOfTransformation(x));
            bag[i][j] := List(bag[i][j], x -> ImageListOfTransformation(x,tlen));
          fi;
          # if it is not a regular d-class
        else
          # If we're displaying as transformations
          if T then
            # if it is not a regular d-class it has not been sorted by GrahamBlocks,
            # so pick the elements from eggbox in same (not mapped by phi) order
            bag[i][j] := List(Elements(eggbox[i][j]), x -> ImageListOfTransformation(x,tlen));
            if T__ = 1 then
              if is_partial then
                for el in bag[i][j] do
                  list := [];
                  for p in [1..zero-1] do
                    if el[p] = zero then
                      Add(list, "_");
                    elif el[p] > zero then
                      Add(list, el[p]-1);
                    else
                      Add(list, el[p]);
                    fi;
                  od;
                  for p in [zero+1..tlen] do
                    if el[p] = zero then
                      Add(list, "_");
                    elif el[p] > zero then
                      Add(list, el[p]-1);
                    else
                      Add(list, el[p]);
                    fi;
                  od;
                  str := String(list);
                  if el in idempots2 then
                    str2 := ['*'];
                  else
                    str2 := [];
                  fi;
                  for c in str do
                    if not c = '"' then #"
                       Add(str2, c);
                    fi;
                  od;
                  Add(bag2[i][j], str2);
                od;
                # If the transformations are total
              else
                # Add '*' if it's an idempotent
                for el in bag[i][j] do
                  if el in idempots2 then
                    Add(bag2[i][j], Concatenation("*", String(el)));
                  else
                    Add(bag2[i][j], String(el));
                  fi;
                od;
              fi;
            else  # Display transformations as integers
              # Add '*' if it's an idempotent
              for el in Elements(eggbox[i][j]) do
                if el in idemps__ then
                  Add(bag2[i][j], Concatenation("*", String(Position(elms__, el))));
                else
                  Add(bag2[i][j], String(Position(elms__, el)));
                fi;
              od;
            fi;
            # If we're displaying as words
          else
            bag[i][j] := Elements(eggbox[i][j]);
            for el in bag[i][j] do
              if el = MultiplicativeNeutralElement(S) then
                str1 := "1";
                retels[3][Position(retels[1], el)] := "1";
              elif el = MultiplicativeZero(S) then
                str1 := "0";
                retels[3][Position(retels[1], el)] := "0";
              else
                px := Position(retels[1], el);
                ret := retels[2][px];
                str1 := [];
                if genslen > 26 then
                  for el2 in ret do
                    str1 := Concatenation(str1, "a", String(Position(generatorsx, el2)));
                  od;
                else
                  for el2 in ret do
                    Add(str1, alphabet[Position(generatorsx, el2)]);
                  od;
                fi;
                str1 := powerizeWord(str1);
                retels[3][px] := str1;
              fi;
              if el in idemps__ then
                Add(bag2[i][j], Concatenation("*", str1));
              else
                Add(bag2[i][j], str1);
              fi;
            od;
            bag[i][j] := List(bag[i][j], x -> ImageListOfTransformation(x,tlen));
          fi;
        fi;

        # write the elements of current H-class
        Append(dotstring, "<TABLE CELLSPACING=\"0\">");
        for k in [1..Length(bag2[i][j])] do
          color := "white";
          el := bag[i][j][k];
          k2 := len_trans_list;
          while k2 > 0 do
            if el in trans_list[k2] then
              color := colors[k2];
              break;
            fi;
            k2 := k2 - 1;
          od;
          Append(dotstring, Concatenation("<TR><TD BGCOLOR=\"", color, "\" BORDER=\"0\">"));
          Append(dotstring, bag2[i][j][k]);
          Append(dotstring, "</TD></TR>\n");
        od;
        Append(dotstring, "</TABLE>");

        Append(dotstring, "</TD>");	# close H-class

      od;
      Append(dotstring, "</TR>\n");  # closes current row for writing
      # Current H-class written
    od;
    # Current D-class written

    # close current node (D-class)
    Append(dotstring, "</TABLE>>];\n");

    # Next D-class will have next number
    dc_number := dc_number + 1;
  od;

  # ===== write the arrows =====


  greens_less_than := [];
  for i in [1..len_dclasses] do
    greens_less_than[i] := [];
    greens_less_than[i][i] := false;
  od;

  box4 := [];  # This will be a list of lists
  # for poi3 will be
  # [ [ 3 ], [ 1, 3 ], [  ], [ 1, 2, 3 ] ],
  # meaning that dclasses[1] is only below dclasses[3],
  # dclasses[2] is only below dclasses[1] and dclasses[3],...
  for i in [1..len_dclasses] do
    box4[i] := [];
    list := [1..len_dclasses];
    RemoveSet(list, i);
    for j in list do
      if IsGreensLessThanOrEqual(dclasses[i], dclasses[j]) then
        Add(box4[i], j);
        greens_less_than[i][j] := true;
      else
        greens_less_than[i][j] := false;
      fi;
    od;
  od;
  visited := [];
  for i in [1..len_dclasses] do
    visited[i] := false;
  od;
  val := [];
  box5 := [];  # This variable will be a list of lists
  # of integers (indexes into dclasses) where
  # box5 = [ [ 1 ], [ 2, 3 ], [ 4, 5 ], [ 6 ] ]
  # means (from top to bottom) first row has dclasses[1],
  # second row has dclasses[2] and dclasses[3],...
  j := 1;
  while ForAny(visited, v -> v = false) do
    box5[j] := [];
    for i in [1..len_dclasses] do
      # If for all d-classes above dclasses[i]
      #
      if ForAll(box4[i], a -> a in val) then
        Add(box5[j], i);
        visited[i] := true;
      fi;
    od;
    val := box5[j];
    j := j + 1;
  od;
  lenb := j - 1;  # Length of box5
  list := ShallowCopy(box5[1]);
  for i in [2..lenb] do
    SubtractSet(box5[i], list);
    UniteSet(list, ShallowCopy(box5[i]));
  od;
  # box5 has been computed.


  # Write arrows
  existsPathFromAtoB := List([1..len_dclasses], x -> List([1..len_dclasses], y -> false));
  for i in [2..lenb] do
    for cl in box5[i] do
      j := i - 1;
      while j > 0 do
        for cl2 in box5[j] do
          if greens_less_than[cl][cl2] and
             not greens_less_than[cl2][cl] and
             not existsPathFromAtoB[cl2][cl] then
            # Draw arrow from node of dclasses[cl2] to node of
            # dclasses[cl] where map[i] is the number of dot's node
            # of d-class dclasses[i]
            Append(dotstring, Concatenation(String(cl2), ":", String(cl2), " -> ", String(cl), ":", String(cl), ";\n"));

            existsPathFromAtoB[cl2][cl] := true;
            m := j - 1;
            while m > 0 do
              for cl3 in box5[m] do
                if existsPathFromAtoB[cl3][cl2] then
                  existsPathFromAtoB[cl3][cl] := true;
                fi;
              od;
              m := m - 1;
            od;
          fi;
        od;
        j := j - 1;
      od;
    od;
  od;
  # Arrows written

  # Close the dot file
  Append(dotstring, "}\n");

  return dotstring;
end);


##--------------------------------------------------------------------------------

##--------------------------------------------------------------------------------


InstallGlobalFunction(DotForDrawingDClasses, function(arg)
  local S,                          # The semigroup
        dc,                         # one d-class
        cl, cl2, cl3,               # index of one certain d-class in dclasses
        el, el2,                    # one element of an H-class
        dclasses,
        len_dclasses,               # number of d-classes
        dc_number,                  # the number of the dot node of a D-class
        eggbox, eggbox2,
        idegg, idegg2,
        line, col,
        ident,
        existsPathFromAtoB,         # matrix with true in [i][j] iff
        # there is there is a path of arrows
        # from dclasses[i] to dclasses[j]
        phi,                        # phi[i][j] = [i', j'] where
        # mat_input[i'][j'] = mat[i][j]
        # where mat_input is the input matrix to
        # GrahamBlocks (it will
        # reference entries in eggbox!
        # and mat is graham_eggbox
        box4,                       # Defined where used
        box5,                       # Defined where used
        lenb,                       # Length of box5 which is the number of
        # levels in the drawing
        visited, list,              # auxiliary arrays
        greens_less_than,           # matrix with true in [i][j] iff
        # dclasses[i] <= dclasses[j]
        #siegen          file,                       # name of the file where dot code
        dotstring,                       # name of the string storing the dot code
        # will be written
        bag, bag2,                  # matrix such that bag[i][j] = L
        # where L is the list of elements of the
        # H-class currently being processed
        # ready for being written according to
        # whether we're writing as transformations
        # or words
        zero,                       # The "zero" on the transformations if partial
        is_partial,                 # whether the transformations are partial
        trans_list,				  # The list of lists of elements to be coloured
        len_trans_list,
        generators, generatorsx,
        genslen,
        colors, color,
        #siegen          fich,                       # the name of the dot file given as argument
 #       gv, dot, tdir,
        alphabet,
#        idempots,                   # Idempotents of the semigroup
        idempots2,                  # ImageListOfTransformation of idempots
        T,                          # whether we're displaying as transformations
        T__,                        # To hold the value of last argument (may be 1 or 2 or none)
        # to either display the transformations as transformations
        # or as an integer (like in the right Cayley Graph).
        elms__,                     # The elements of S
        idemps__,                   # Idempotents of the semigroup
        str, str1, str2,
        tlen,
        rows, cols, val,
        retels,
        i, j, k, k2, p, m, c, ret, px,
        powerizeWord;


  
  # ==========================================

  # if we're displaying as words this function
  # replaces 2 or more followed occurrences of
  # letter a by a^...
  powerizeWord := function(w)
    local w2, c, j, a;

    w2 := [];
    c := 0;
    for j in [1..Length(w)] do
      if c = 0 then
        a := w[j];
        c := 1;
      elif w[j] = a then
        c := c + 1;
      else
        if c = 1 then
          Add(w2, a);
        else
          w2 := Concatenation(w2, [a], "^", String(c));
        fi;
        c := 1;
        a := w[j];
      fi;
    od;
    if c = 1 then
      Add(w2, a);
    else
      w2 := Concatenation(w2, [a], "^", String(c));
    fi;
    return(w2);
  end;
  ##  End of powerizeWord()  --

  # alphabet for displaying as words
  alphabet := "abcdefghijklmnopqrstuvwxyz";

  colors := [ "brown", "burlywood", "cadetblue", "chartreuse", "chocolate", "coral", "cornflowerblue",
              "crimson", "cyan", "darkgoldenrod", "darkkhaki", "darkorange", "darkorchid",
              "darksalmon", "darkseagreen", "darkturquoise",
              "darkviolet", "deeppink", "deepskyblue", "dodgerblue", "firebrick",
              "forestgreen", "gold", "goldenrod", "green", "greenyellow", "grey",
              "hotpink", "indianred", "khaki", "lawngreen",
              "lightblue", "lightcoral",
              "lightpink", "lightsalmon", "lightseagreen", "lightskyblue", "lightslateblue",
              "lightslategrey", "limegreen", "magenta",
              "maroon", "mediumaquamarine", "mediumorchid", "mediumpurple", "mediumseagreen",
              "mediumspringgreen", "mediumturquoise", "mediumvioletred",
              "moccasin", "navajowhite", "olivedrab2", "orange", "orangered",
              "orchid", "palegreen", "paleturquoise", "palevioletred", "peachpuff", "peru",
              "pink", "plum", "powderblue", "purple", "red", "rosybrown", "royalblue1", "saddlebrown", "salmon",
              "sandybrown", "seagreen", "skyblue", "slateblue", "slategrey",
              "springgreen", "steelblue", "tan", "thistle", "tomato", "turquoise", "violet", "violetred",
              "wheat", "yellow", "yellowgreen" ];


  if not IsBound(arg[1]) or not IsSemigroup(arg[1]) then
    Error("The first argument must be a semigroup");
  fi;
  # to face the fact that semigroups behave differently depending on the use or not of the "semigroups" package, a fresh object is created 
  if IsMonoid(arg[1]) then
    S := Monoid(GeneratorsOfMonoid(arg[1]));
  elif IsSemigroup(arg[1]) then
    S := Semigroup(GeneratorsOfSemigroup(arg[1]));
  fi;  


  if not (IsTransformationMonoid(S) or IsTransformationSemigroup(S)) then
    Print("I will work with an isomorphic transformation semigroup instead\n");
    S:= Range(IsomorphismTransformationSemigroup(S));
    S := Semigroup(ReduceNumberOfGenerators(GeneratorsOfSemigroup(S)));
  fi;

  tlen := DegreeOfTransformationSemigroup(S);

  elms__ := Elements(S);
  idemps__ := Idempotents(S);
  idempots2 := List(idemps__, x -> ImageListOfTransformation(x,tlen));

  T := false;                          # Display as transformations
  trans_list := [];                    # the list of lists of elements
  # to draw in colors given by
  # the user.
  for i in [2..Length(arg)] do
    if  IsList(arg[i]) then
      if not ForAll(arg[i], e -> IsTransformation(e)) then
        Error("The list of elements must be a list of Transformations ", arg[i]);
      fi;
      Add(trans_list, Set(List(arg[i], trans -> ImageListOfTransformation(trans,tlen))));
    elif i = Length(arg) and (arg[i] = 1 or arg[i] = 2) then
      T := true;
      T__ := arg[i];
    else
      Error("The arguments must be: <semigroup> [, list of elements]* [, file name]");
    fi;
  od;
  len_trans_list := Length(trans_list);

  ##  We will check if the transformations are partial or total
  generators := GeneratorsOfSemigroup(S);
  genslen := Length(generators);
  generatorsx := [];
  for el in generators do
    if not el = IdentityTransformation then
      Add(generatorsx, el);
    fi;
  od;
  Sort(generatorsx);

  # Determine if transitions are partial
  # and determine the "zero" digit
  is_partial := ForAll(List(generators, g -> ImageListOfTransformation(g,tlen)), lx -> lx[tlen] = tlen);
  zero := tlen;

  # ============= Main Code ==================

  dclasses := GreensDClasses(S);
  len_dclasses := Length(dclasses);
  dc_number := 1;

  if not T then
    retels := [Elements(S), SemigroupFactorization(S, Elements(S)),[]];
  fi;

  #initializing the dotstring
  dotstring := "digraph  DClasses {\ngraph [center=yes,ordering=out];\nnode [shape=plaintext];\nedge [color=cornflowerblue,arrowhead=none];\n";


  # For each d-class write the dot record node
  for dc in dclasses do
    eggbox := EggBoxOfDClass(dc);
    rows := Length(eggbox);
    cols := Length(eggbox[1]);

    idegg := List(eggbox, r->List(r,
                     function(h)
      if IsGroupHClass(h) then
        return 1;
      else
        return 0;
      fi;
    end));


    ##  Order the columns lexicographically
    line := List([1..cols], x -> [Representative(eggbox[1][x]), x]);
    Sort(line);
    eggbox2 := NullMat(rows, cols);
    idegg2 := NullMat(rows, cols);

    j := 1;
    for el in line do
      for i in [1..rows] do
        eggbox2[i][j] := ShallowCopy(eggbox[i][el[2]]);
        idegg2[i][j] := ShallowCopy(idegg[i][el[2]]);
      od;
      j := j + 1;
    od;

    ##  Order the rows lexicographically
    col := List([1..rows], x -> [Representative(eggbox[x][1]), x]);
    Sort(col);
    eggbox := NullMat(rows, cols);
    idegg := NullMat(rows, cols);
    i := 1;
    for el in col do
      for j in [1..cols] do
        eggbox[i][j] := ShallowCopy(eggbox2[el[2]][j]);
        idegg[i][j] := ShallowCopy(idegg2[el[2]][j]);
      od;
      i := i + 1;
    od;


    if IsRegularDClass(dc) then
      ret := GrahamBlocks(idegg);
      ##    Print(idegg,"\n",ret,"\n");

      #            graham_eggbox := ret[1];
      phi := ret[2];
    fi;

    bag := [];
    bag2 := [];
    for k in [1..rows] do
      bag[k] := [];
      bag2[k] := [];
      for p in [1..cols] do
        bag2[k][p] := [];
      od;
    od;


    # Write the dot node definition of the current
    # D-class
    Append(dotstring, Concatenation(String(dc_number), " [label=<\n<TABLE BORDER=\"0\" CELLBORDER=\"0\" CELLPADDING=\"0\" CELLSPACING=\"0\" PORT=\"", String(dc_number), "\">\n"));  # opens the D-class and
    # first column for writing

    # Visit left column first, then second,... because of dot
    for i in [1..rows] do
      Append(dotstring, "<TR>");
      for j in [1..cols] do
        # Write H-class [i][j] from current eggbox
        # With the list of
        # elements of an H-class writes the
        # corresponding cell of the dot record node
        # in the current D-class node
        Append(dotstring, "<TD BORDER=\"0\">");  # opens h-class

        # bag2[i][j] is the list of elements
        # of eggbox[i'][j'] where i' = phi[i][j][1]
        # and j' = phi[i][j][2], formatted for being written
        # phi is needed because GrahamBlocks was called.
        if IsRegularDClass(dc) then
          # If we're displaying as transformations
          if T then
            bag[i][j] := List(Elements(eggbox[phi[i][j][1]][phi[i][j][2]]), x -> ImageListOfTransformation(x,tlen));
            if T__ = 1 then
              # if the transformations are partial
              if is_partial then
                for el in bag[i][j] do
                  # replace the "zero" by "_"
                  list := [];
                  for p in [1..zero-1] do
                    if el[p] = zero then
                      Add(list, "_");
                    elif el[p] > zero then
                      Add(list, el[p]-1);
                    else
                      Add(list, el[p]);
                    fi;
                  od;
                  for p in [zero+1..tlen] do
                    if el[p] = zero then
                      Add(list, "_");
                    elif el[p] > zero then
                      Add(list, el[p]-1);
                    else
                      Add(list, el[p]);
                    fi;
                  od;
                  if list = [] then
                    Add(list, "_");
                  fi;
                  # End of replace the "zero" by "_"

                  # str2 will be the written string
                  str := String(list);
                  # if it's an idempot put the "*"
                  if el in idempots2 then
                    str2 := ['*'];
                  else
                    str2 := [];
                  fi;
                  # Remove '"'
                  for c in str do
                    if not c = '"' then #"
                       Add(str2, c);
                    fi;
                  od;
                  # add element for write
                  if str2[6] = '.' then
                    ident := List([1..tlen], x -> x);
                    if str2[1] = '*' then
                      str2 := Concatenation("*", String(ident));
                    else
                      str2 := String(ident);
                    fi;
                  fi;
                  Add(bag2[i][j], str2);
                od;
                # If the transformations are total
              else
                # Add '*' if it's an idempotent
                for el in bag[i][j] do
                  if el in idempots2 then
                    ##                                        if String(el)[6] = '.' then
                    if el = [] then
                      Add(bag2[i][j], Concatenation("*", String(List([1..tlen], x -> x))));
                    else
                      Add(bag2[i][j], Concatenation("*", String(el)));
                    fi;
                  else
                    Add(bag2[i][j], String(el));
                  fi;
                od;
              fi;
            else  # Display transformations as integers
              # Add '*' if it's an idempotent
              for el in Elements(eggbox[phi[i][j][1]][phi[i][j][2]]) do
                if el in idemps__ then
                  if String(el)[6] = '.' then
                    Add(bag2[i][j], Concatenation("*", String(List([1..tlen], x -> x))));
                  else
                    Add(bag2[i][j], Concatenation("*", String(Position(elms__, el))));
                  fi;
                else
                  Add(bag2[i][j], String(Position(elms__, el)));
                fi;
              od;
            fi;
            # If we're displaying as words
          else
            bag[i][j] := Elements(eggbox[phi[i][j][1]][phi[i][j][2]]);
            for el in bag[i][j] do
              if el = MultiplicativeNeutralElement(S) then
                str1 := "1";
                retels[3][Position(retels[1], el)] := "1";
              elif el = MultiplicativeZero(S) then
                str1 := "0";
                retels[3][Position(retels[1], el)] := "0";
              else
##                    Error("..");
                    
                px := Position(retels[1], el);
                ret := retels[2][px];
                str1 := [];
                if genslen > 26 then
                  for el2 in ret do
                    str1 := Concatenation(str1, "a", String(Position(generatorsx, el2)));
                  od;
                else
                  for el2 in ret do
                    Add(str1, alphabet[Position(generatorsx, el2)]);
                  od;
                fi;
                str1 := powerizeWord(str1);
                retels[3][px] := str1;
              fi;
              if el in idemps__ then
                Add(bag2[i][j], Concatenation("*", str1));
              else
                Add(bag2[i][j], str1);
              fi;
            od;
            bag[i][j] := List(bag[i][j], x -> ImageListOfTransformation(x,tlen));
          fi;
          # if it is not a regular d-class
        else
          # If we're displaying as transformations
          if T then
            # if it is not a regular d-class it has not been sorted by GrahamBlocks,
            # so pick the elements from eggbox in same (not mapped by phi) order
            bag[i][j] := List(Elements(eggbox[i][j]), x -> ImageListOfTransformation(x,tlen));
            if T__ = 1 then
              if is_partial then
                for el in bag[i][j] do
                  list := [];
                  for p in [1..zero-1] do
                    if el[p] = zero then
                      Add(list, "_");
                    elif el[p] > zero then
                      Add(list, el[p]-1);
                    else
                      Add(list, el[p]);
                    fi;
                  od;
                  for p in [zero+1..tlen] do
                    if el[p] = zero then
                      Add(list, "_");
                    elif el[p] > zero then
                      Add(list, el[p]-1);
                    else
                      Add(list, el[p]);
                    fi;
                  od;
                  str := String(list);
                  if el in idempots2 then
                    str2 := ['*'];
                  else
                    str2 := [];
                  fi;
                  for c in str do
                    if not c = '"' then  #"
                       Add(str2, c);
                    fi;
                  od;
                  Add(bag2[i][j], str2);
                od;
                # If the transformations are total
              else
                # Add '*' if it's an idempotent
                for el in bag[i][j] do
                  if el in idempots2 then
                    Add(bag2[i][j], Concatenation("*", String(el)));
                  else
                    Add(bag2[i][j], String(el));
                  fi;
                od;
              fi;
            else  # Display transformations as integers
              # Add '*' if it's an idempotent
              for el in Elements(eggbox[i][j]) do
                if el in idemps__ then
                  Add(bag2[i][j], Concatenation("*", String(Position(elms__, el))));
                else
                  Add(bag2[i][j], String(Position(elms__, el)));
                fi;
              od;
            fi;
            # If we're displaying as words
          else
            bag[i][j] := Elements(eggbox[i][j]);
            for el in bag[i][j] do
              if el = MultiplicativeNeutralElement(S) then
                str1 := "1";
                retels[3][Position(retels[1], el)] := "1";
              elif el = MultiplicativeZero(S) then
                str1 := "0";
                retels[3][Position(retels[1], el)] := "0";
              else
                px := Position(retels[1], el);
                ret := retels[2][px];
                str1 := [];
                if genslen > 26 then
                  for el2 in ret do
                    str1 := Concatenation(str1, "a", String(Position(generatorsx, el2)));
                  od;
                else
                  for el2 in ret do
                    Add(str1, alphabet[Position(generatorsx, el2)]);
                  od;
                fi;
                str1 := powerizeWord(str1);
                retels[3][px] := str1;
              fi;
              if el in idemps__ then
                Add(bag2[i][j], Concatenation("*", str1));
              else
                Add(bag2[i][j], str1);
              fi;
            od;
            bag[i][j] := List(bag[i][j], x -> ImageListOfTransformation(x,tlen));
          fi;
        fi;

        # write the elements of current H-class
        Append(dotstring, "<TABLE CELLSPACING=\"0\">");
        for k in [1..Length(bag2[i][j])] do
          color := "white";
          el := bag[i][j][k];
          k2 := len_trans_list;
          while k2 > 0 do
            if el in trans_list[k2] then
              color := colors[k2];
              break;
            fi;
            k2 := k2 - 1;
          od;
          Append(dotstring, Concatenation("<TR><TD BGCOLOR=\"", color, "\" BORDER=\"0\">"));
          Append(dotstring, bag2[i][j][k]);
          Append(dotstring, "</TD></TR>\n");
        od;
        Append(dotstring, "</TABLE>");

        Append(dotstring, "</TD>");	# close H-class

      od;
      Append(dotstring, "</TR>\n");  # closes current row for writing
      # Current H-class written
    od;
    # Current D-class written

    # close current node (D-class)
    Append(dotstring, "</TABLE>>];\n");

    # Next D-class will have next number
    dc_number := dc_number + 1;
  od;

  # ===== write the arrows =====

  greens_less_than := [];
  for i in [1..len_dclasses] do
    greens_less_than[i] := [];
    greens_less_than[i][i] := false;
  od;

  box4 := [];  # This will be a list of lists
  # for poi3 will be
  # [ [ 3 ], [ 1, 3 ], [  ], [ 1, 2, 3 ] ],
  # meaning that dclasses[1] is only below dclasses[3],
  # dclasses[2] is only below dclasses[1] and dclasses[3],...
  for i in [1..len_dclasses] do
    box4[i] := [];
    list := [1..len_dclasses];
    RemoveSet(list, i);
    for j in list do
      if IsGreensLessThanOrEqual(dclasses[i], dclasses[j]) then
        Add(box4[i], j);
        greens_less_than[i][j] := true;
      else
        greens_less_than[i][j] := false;
      fi;
    od;
  od;
  visited := [];
  for i in [1..len_dclasses] do
    visited[i] := false;
  od;
  val := [];
  box5 := [];  # This variable will be a list of lists
  # of integers (indexes into dclasses) where
  # box5 = [ [ 1 ], [ 2, 3 ], [ 4, 5 ], [ 6 ] ]
  # means (from top to bottom) first row has dclasses[1],
  # second row has dclasses[2] and dclasses[3],...
  j := 1;
  while ForAny(visited, v -> v = false) do
    box5[j] := [];
    for i in [1..len_dclasses] do
      # If for all d-classes above dclasses[i]
      #
      if ForAll(box4[i], a -> a in val) then
        Add(box5[j], i);
        visited[i] := true;
      fi;
    od;
    val := box5[j];
    j := j + 1;
  od;
  lenb := j - 1;  # Length of box5
  list := ShallowCopy(box5[1]);
  for i in [2..lenb] do
    SubtractSet(box5[i], list);
    UniteSet(list, ShallowCopy(box5[i]));
  od;
  # box5 has been computed.


  # Write arrows
  existsPathFromAtoB := List([1..len_dclasses], x -> List([1..len_dclasses], y -> false));
  for i in [2..lenb] do
    for cl in box5[i] do
      j := i - 1;
      while j > 0 do
        for cl2 in box5[j] do
          if greens_less_than[cl][cl2] and
             not greens_less_than[cl2][cl] and
             not existsPathFromAtoB[cl2][cl] then
            # Draw arrow from node of dclasses[cl2] to node of
            # dclasses[cl] where map[i] is the number of dot's node
            # of d-class dclasses[i]
            Append(dotstring, Concatenation(String(cl2), ":", String(cl2), " -> ", String(cl), ":", String(cl), ";\n"));
            ##Append(dotstring, Concatenation(cl2, ":", cl2, " -> ", cl, ":", cl, ";\n"));

            existsPathFromAtoB[cl2][cl] := true;
            m := j - 1;
            while m > 0 do
              for cl3 in box5[m] do
                if existsPathFromAtoB[cl3][cl2] then
                  existsPathFromAtoB[cl3][cl] := true;
                fi;
              od;
              m := m - 1;
            od;
          fi;
        od;
        j := j - 1;
      od;
    od;
  od;
  # Arrows written

  # Close the dot file
  Append(dotstring, "}\n");
  return dotstring;
end);



##--------------------------------------------------------------------------------
##--------------------------------------------------------------------------------
