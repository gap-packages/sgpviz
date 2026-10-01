| CHANGES of the SgpViz package |

## 0.999.7 (unreleased)

- Updates related to CI and Codecov (Thanks, Max)
- Fixed a bug in displaying color of some elements in D-classes (Thanks Vitor H. Fernandes for pointing out the bug.)

## 0.999.6 (2024-08-30)

- Updates related to CI and Codecov (Thanks, Max)
- Simplify-splash (Thanks, Max)
- Removing CSV leftovers (Thanks, Max)
- updating makedoc (Thanks, Max)

## 0.999.5 (2022-03-20)

- Switch CI to use GitHub Actions (Thanks Max)
- Add Travis & Codecov support (Thanks Max)
- Test file updated

## 0.999.4 (2018-10-29)

nothing really changed (the process of release failed due to not saving the Packageinfo.g file)

## 0.999.3 (2018-10-29)

test file updated for better code coverage (which revealed the need of some small fixes)
test file updated, to avoid differences cause by the use of different factorization algorithms (depending on whether the semigroups package is loaded)

## 0.999.2 (2018-09-26)

- Schutzenberger graphs are now produced in two steps, as the remaining drawings (see 0.998 -> 0.999.1)
- several changes to fix a strange behavior when the semigroups package is loaded (and a semigroup is entered before)

## 0.999.1 (2017-09-13)

-Removed the SuperFail (thanks Max H.)
-drawings are now produced in two steps: first the dot code (that is accessible to the user) and then the display
-added a test file
-fix the code broken by the change of IdentityTransformation in the GAP system
-updating the manual to be processed using makedoc, besides minor corresctions
-creating a GitHub repository
-update drawdclasses.gi
(IdentityTransformation(tlen) to IdentityTransformation)
(if String(el)[6] = '.' then  to  if el = [] then)
