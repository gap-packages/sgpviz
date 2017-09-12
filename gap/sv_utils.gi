#######################################################################
InstallGlobalFunction(SgpVizTest,
        function()
  Test(Concatenation(PackageInfo("sgpviz")[1]!.
          InstallationPath, "/tst/testall.tst"), rec( compareFunction := "uptowhitespace" ));
end);
