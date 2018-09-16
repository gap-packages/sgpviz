LoadPackage("sgpviz");
dir := DirectoriesPackageLibrary("sgpviz", "tst");
TestDirectory(dir, rec(exitGAP := true) );

FORCE_QUIT_GAP(1);
