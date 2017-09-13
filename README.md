# sgpviz
SgpViz is a GAP package for (finite) semigroup visualisation
============================================================
Introduction
------------

This is release 0.999 of  the package `SgpViz'.

The features of this package include

         - drawing the D-Classes of a semigroup and the
	   D-Class of an element of a semigroup;
	 - computing a minimal factorization of an element
	   of semigroup in the generators;
         - drawing the Schutzenberger graphs of an inverse
	   semigroup;
         - computing the right Cayley graph of a semigroup;
         - a Tcl/Tk interface to specify a semigroup;

There is a manual in the sub-directory 'doc' written using the GAP package
gapdoc which describes the available functions in detail. The dvi, pdf, html
versions of the manual are also available there.


If you have used this package, please let us know by sending
us an email.  If you  have found important features missing or if there is a
bug, we would appreciate it very much if you send us an email.

Manuel Delgado   <mdelgado@fc.up.pt>
José Morais	 <josejoao@fc.up.pt>

Contents
--------
With this version you should have obtained the following files and
directories:

        README          this file

	EXAMPLES	some examples

        doc             the manual
    
        gap             the GAP code

        init.g          the file that initializes this package

        read.g          the file that reads in the package     

	PackageInfo.g	information file for automatic processing

	version		the version number   

Usage
-----
The package shall be distributed with the main GAP archive. In this case, in
order to use it you just have to start GAP and type

      LoadPackage( "intpic" );

------------------------------
------------------------------
For updates between releases of GAP itself or in case it is not distributed
with the main GAP archive, check the package Web page

    https://gap-packages.github.io/sgpviz/

For the development version, please visit the repository in GitHub (https://github.com/gap-packages/sgpviz/)

You may get `SgpViz' as a compressed tar archive (file name ends with
.tar.gz). Use the appropriate command on your system to unpack the
archive.

On UNIX systems the compressed tar archive may be unpacked by

    tar xzf sgpviz-<version>.tar.gz

or, if tar on your system does not understand the option z, by

    gunzip sgpviz-<version>.tar.gz
    tar xf sgpviz-<version>.tar

which will in each case unpack the code into a directory 'sgpviz'
in the current directory. We assume that the current directory is the
directory /usr/local/lib/gap4r8/pkg/.

Installation
------------

Important:
----------

This package needs the package `Automata' (http://www.gap-system.org/~gap/Packages/automata.html).
-----------------------------------------


You may have to start GAP with the -l option, for instance,

gap -l "/usr/local/lib/gap4r4"

Then try the following

gap> LoadPackage( "sgpviz" ); 
true
gap>

Good luck!

If you use a LINUX system, you may have to, in order to save typing, write
aliases: 

in the file `.bashrc' (or something equivalent, maybe with another syntax): 

alias gap='gap -l "/usr/local/lib/gap4r8;"'

and in the file `.gaprc'

LoadPackage( "sgpviz" ); 



GraphViz (http://www.graphviz.org/)
should be installed.

Tcl/Tk should also be installed.

----------
In other systems, there are equivalent ways to do the same.
