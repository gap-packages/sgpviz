## The function "Splash" is temporarily borrowed from Viz, while it is in an early stage of development.
## 
## (I wrote this file during a visit I made to St Andrews University in January 2012)
#############################################################################

if not IsBound(VizOptionsForSplash) then 
  BindGlobal("VizOptionsForSplash",["path","directory","file","viewer","tikz","filetype","latexpoints","latexorientation","latexpapersize"]);
fi;


#############################################################################
# Splash ... 
# the input is
# * a record of options (may not be present) and
# * a string (dot) or a function that applied to the remaining argument produces a dot string
if not IsBound(VizViewers) then 
  if ARCH_IS_MAC_OS_X( ) then
    BindGlobal("VizViewers", ["xpdf","open","evince", "okular", "gv"]);
  elif ARCH_IS_UNIX( ) then
    BindGlobal("VizViewers", ["evince","xpdf","xdg-open","okular", "gv"]);
  elif ARCH_IS_WINDOWS( ) then
    BindGlobal("VizViewers", ["xpdf","evince", "okular", "gv"]);
  fi;
fi;

# if not IsBound(Splash) then 
#  BindGlobal("Splash",
if not IsBound(Splash_sv) then #to avoid conflicts with slightly modified "splash" copies in other packages
  BindGlobal("Splash_sv",
  function(arg)
    local opt, dotstring, f, s, path, dir, tdir, file, viewer, tikz, filetype, i, 
          latexstring, command;

    ##########
    # there are global warnings concerning the availability of software
    # there is no need to put them here
    ###############
    opt := First(arg, k -> IsRecord(k));
    if opt = fail then
      opt := rec();
    else
      if not IsSubset(VizOptionsForSplash,RecNames( opt)) then
        Info(InfoViz,1,"The options ", Difference(RecNames(opt),
         VizOptionsForSplash)," have no effect.");
      fi;
    fi;
    dotstring := First(arg, k -> IsString(k));
    if dotstring = fail then
      f := First(arg, k -> IsFunction(k));
      s := First(arg, k -> IsSemigroup(k));
      dotstring := f(s);
    fi;

    # begin options
    #path
    if IsBound(opt.path) then
      path := opt.path;
    else
      path := "~/";
    fi;

    #directory
    if IsBound(opt.directory) then
      if not opt.directory in DirectoryContents(path) then
        Exec(Concatenation("mkdir ",path,opt.directory));
        Info(InfoViz, 1, "The temporary directory ",path,opt.directory, 
         " has been created");
      fi;
      dir := Concatenation(path,opt.directory,"/");
    elif IsBound(opt.path) then
      if not "tmp.viz" in DirectoryContents(path) then
        tdir := Directory(Concatenation(path,"/","tmp.viz"));
        dir := Filename(tdir, "");
      fi;
    else
      tdir := DirectoryTemporary();
      dir := Filename(tdir, "");
    fi;
    #
    Info(InfoViz,1,"The temporary directory used is: ", dir,"\n");

    #file
    if IsBound(opt.file) then
      file := opt.file;
    else
      file := "vizpicture";
    fi;

    #viewer
    if IsBound(opt.viewer) then
      viewer := opt.viewer;
    else
      viewer := First(VizViewers, x ->
       Filename(DirectoriesSystemPrograms(),x)<>fail);
    fi;

    # latex
    if IsBound(opt.tikz) then
      tikz := opt.tikz;
    else
      tikz := false;
    fi;
    if IsBound(opt.filetype) then
      filetype := opt.filetype;
    else
      filetype := "pdf";
    fi;  
    ######################
    if tikz or dotstring{[1..5]}="%tikz" then
      if dotstring{[1..5]}="%tikz" then #the string is a latex string
        #process specific options
        #for i in RecNames(VizDefaultOptionsRecordForDisplayingWithLatex) do
        #  if not IsBound(opt.(i)) then
        #    opt.(i) := VizDefaultOptionsRecordForDisplayingWithLatex.(i);
        #  fi;
        #od;
      #  latexstring := "\\documentclass[";
      #  for i in RecNames(VizDefaultOptionsRecordForDisplayingWithLatex) do
      #    Append(latexstring,Concatenation(opt.(i),","));
      #  od;
      #  Append(latexstring,"]{article}\n");
      #  Append(latexstring,"\\usepackage[vmargin=2cm,hmargin=2cm]{geometry}\n");
      #  Append(latexstring,"\\usepackage[x11names, rgb]{xcolor}\n");
   #  #   Append(latexstring,"\\usepackage[utf8]{inputenc}\n");
      #  Append(latexstring,"\\usepackage{pgf}\n");
      #  Append(latexstring,"\\usepackage{tikz}\n");
      #  Append(latexstring,"\\usepgfmodule{plot}\n");
      #  Append(latexstring,"\\usepgflibrary{plothandlers}\n");
      #  Append(latexstring,"\\usetikzlibrary{shapes.geometric}\n");
      #  Append(latexstring,"\\usetikzlibrary{shadings}\n");
      #  Append(latexstring,"\\usepackage{amsmath}\n");
      #  Append(latexstring,"\%\n");
      #  Append(latexstring,"\\begin{document}\n");
      #  Append(latexstring,"\\pagestyle{empty}\n");
      #  Append(latexstring,"\\begin{center}\n");
      #  Append(latexstring,Concatenation("\\input{",file,"1}\n"));
      #  Append(latexstring,"\\end{center}\n");
      #  Append(latexstring,"\\end{document}\n");
        FileString(Concatenation(dir, file, ".tex"), dotstring);

        #FileString(Concatenation(dir,file,"1.tex"),dotstring);
      else

        FileString(Concatenation(dir,file,".dot"),dotstring);

        command := Concatenation("dot2tex -ftikz ",dir,file,".dot"," > ",
         dir,file,".tex");
        Exec(command);
      fi;

      command := Concatenation("cd ",dir,"; ","pdflatex ",dir,file, 
      " 2>/dev/null 1>/dev/null");
      Exec(command);

      Exec (Concatenation(viewer, " ",dir,file,".pdf 2>/dev/null 1>/dev/null &"));
      return;
    fi;

    FileString(Concatenation(dir,file,".dot"),dotstring);
    command := Concatenation("dot -T",filetype," ",dir,file,".dot"," -o ", dir,file,".",filetype);
    Exec(command);
    Exec (Concatenation(viewer, " ",dir,file,".",filetype," 2>/dev/null 1>/dev/null &"));
    return;

  end);
fi;
