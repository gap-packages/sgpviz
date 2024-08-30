#############################################################################
##  
##  PackageInfo.g for the package `SgpViz'                    Manuel Delgado
##  

SetPackageInfo( rec(

PackageName := "SgpViz",
Subtitle := "A package for semigroup visualization",
Version := "0.999.6",
Date := "30/08/2024", # dd/mm/yyyy format
License := "GPL-2.0-or-later",
#Version := "0.999.1 dev",
#Date := "> 13/09/2017",

##  Information about authors and maintainers.
Persons := [
 rec(
    LastName      := "Delgado",
    FirstNames    := "Manuel",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "mdelgado@fc.up.pt",
    WWWHome       := "http://www.fc.up.pt/cmup/mdelgado/",
    PostalAddress := Concatenation( [
                   "CMUP, Departamento de Matemática\n",
                   "Faculdade de Ciências, Universidade do Porto\n",
                   "Rua do Campo Alegre s/n\n",
                   "4169-007 Porto\n",
                   "Portugal" ] ),
    Place         := "Porto",
    Institution   := "Faculdade de Ciências"
  ),
  rec(
    LastName      := "Morais",
    FirstNames    := "Jose",
    IsAuthor      := true,
    IsMaintainer  := false,
    PostalAddress := "No address known"
  )
],
                   
Status := "deposited",       

SourceRepository := rec(
  Type := "git",
  URL := "https://github.com/gap-packages/sgpviz"
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://gap-packages.github.io/sgpviz",
README_URL      := Concatenation( ~.PackageWWWHome, "/README.md" ),
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "/PackageInfo.g" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", ~.PackageName, "-", ~.Version ),
ArchiveFormats := ".tar.gz",
                   
AbstractHTML := 
   "The <span class=\"pkgname\">SgpViz</span> package, is a package with some visualization features for finite semigroups.",

PackageDoc := rec(
  BookName  := "SgpViz",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0_mj.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "SgpViz, a GAP package for semigroup visualization",
),
                   
Dependencies := rec(
  GAP := ">=4.4",
  NeededOtherPackages := [["Automata", ">= 1.14"]],
##  NeededOtherPackages := [["semigroups", ">= 3"]],
  SuggestedOtherPackages := [],
##  ExternalConditions := [["Evince","http://www.gnome.org/projects/evince/"],["Graphviz","https://www.graphviz.org/"]]
                      
),
                  
AvailabilityTest := ReturnTrue,
 BannerString := Concatenation(
  "----------------------------------------------------------------\n",
  "Loading  SgpViz ", ~.Version, "(semigroup visualization)\n",
#  "by ", ~.Persons[1].FirstNames, " ", ~.Persons[1].LastName,
#        " (", ~.Persons[1].WWWHome, ")\n",
#  "   ", ~.Persons[2].FirstNames, " ", ~.Persons[2].LastName,"\n",
#        " (", ~.Persons[2].WWWHome, ")\n",
#  "   ", ~.Persons[3].FirstNames, " ", ~.Persons[3].LastName,
#        " (", ~.Persons[3].WWWHome, ")\n",
  "For help, type: ?SgpViz: \n",
  "----------------------------------------------------------------\n" ),
                  
TestFile := "tst/testall.g",
                   
Keywords := ["Semigroup", "D-Class", "Schutzenberger graphs", "Cayley graphs"]
  
                    ));
                


