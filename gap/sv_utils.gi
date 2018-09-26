#######################################################################
InstallGlobalFunction(SgpVizTest,
        function()
  Test(Concatenation(PackageInfo("sgpviz")[1]!.
          InstallationPath, "/tst/testall.tst"), rec( compareFunction := "uptowhitespace" ));
end);
#######################################################################
InstallGlobalFunction(SgpVizInfo,
        function(n)
     SetInfoLevel(InfoSgpViz, n);
     
    Print("Info Level for InfoSgpViz is set to ",n, "\n");
end);
