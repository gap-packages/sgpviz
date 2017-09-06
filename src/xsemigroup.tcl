
#-----------------------------------------------------
#------ Procedures -----------------------------------
#-----------------------------------------------------

proc proceed [] {
    global type

    if {$type == 1} {
	displayType1
    } elseif {$type == 2} {
	displayType2
    } elseif {$type == 3} {
	displayType3
    } elseif {$type == 4} {
	displayType4
    }
}


proc displayType1 [] {
    global monoid

    destroyWindows2

    frame .type1
    pack  .type1 -expand 1 -fill both

    frame .type1.up -relief groove -bd 1
    frame .type1.down -relief groove -bd 1
    pack  .type1.up .type1.down -expand 1 -fill both

    frame .type1.up.frame
    frame .type1.down.frame
    pack  .type1.up.frame .type1.down.frame

    frame .type1.up.frame.left
    frame .type1.up.frame.right
    pack  .type1.up.frame.left .type1.up.frame.right -side left

    frame .type1.up.frame.left.l0
    frame .type1.up.frame.left.l1
    frame .type1.up.frame.left.l2
    frame .type1.up.frame.left.l3
    frame .type1.up.frame.left.l4
    pack  .type1.up.frame.left.l0 .type1.up.frame.left.l1 .type1.up.frame.left.l2 \
	  .type1.up.frame.left.l3 .type1.up.frame.left.l4 -anchor w -expand 1 -fill x

    label .type1.up.frame.left.l0.label -text "GAP variable:"
    label .type1.up.frame.left.l1.label -text "Number of generators:"
    label .type1.up.frame.left.l2.label -text "Number of relations:"
    label .type1.up.frame.left.l3.label -text "Monoid:"
    label .type1.up.frame.left.l4.label -text "Semigroup:"
    pack  .type1.up.frame.left.l0.label .type1.up.frame.left.l1.label .type1.up.frame.left.l2.label \
	  .type1.up.frame.left.l3.label .type1.up.frame.left.l4.label -anchor w

    frame .type1.up.frame.right.l0
    frame .type1.up.frame.right.l1
    frame .type1.up.frame.right.l2
    frame .type1.up.frame.right.l3
    frame .type1.up.frame.right.l4
    pack  .type1.up.frame.right.l0 .type1.up.frame.right.l1 .type1.up.frame.right.l2 \
	  .type1.up.frame.right.l3 .type1.up.frame.right.l4 -anchor w

    entry .type1.up.frame.right.l0.entry -width 8
    entry .type1.up.frame.right.l1.entry -width 8
    entry .type1.up.frame.right.l2.entry -width 8
    radiobutton .type1.up.frame.right.l3.rb1 -variable monoid -value 1
    .type1.up.frame.right.l3.rb1 select
    radiobutton .type1.up.frame.right.l3.rb2 -variable monoid -value 0
    pack  .type1.up.frame.right.l0.entry .type1.up.frame.right.l1.entry .type1.up.frame.right.l2.entry \
	  .type1.up.frame.right.l3.rb1 .type1.up.frame.right.l3.rb2

    button .type1.down.frame.proceedt1 -command proceedt1 -text Proceed
    pack   .type1.down.frame.proceedt1 -padx 2 -pady 2

    bind .type1.up.frame.right.l0.entry <Return> {.type1.down.frame.proceedt1 invoke}
    bind .type1.up.frame.right.l1.entry <Return> {.type1.down.frame.proceedt1 invoke}
    bind .type1.up.frame.right.l2.entry <Return> {.type1.down.frame.proceedt1 invoke}
    bind .type1.down.frame.proceedt1 <Return> {.type1.down.frame.proceedt1 invoke}

    focus .type1.up.frame.right.l0.entry
}


proc displayType2 [] {
    global monoid

    destroyWindows2

    frame .type2
    pack  .type2 -expand 1 -fill both

    frame .type2.up -relief groove -bd 1
    frame .type2.down -relief groove -bd 1
    pack  .type2.up .type2.down -expand 1 -fill both

    frame .type2.up.frame
    frame .type2.down.frame
    pack  .type2.up.frame .type2.down.frame

    frame .type2.up.frame.left
    frame .type2.up.frame.right
    pack  .type2.up.frame.left .type2.up.frame.right -side left

    frame .type2.up.frame.left.l0
    frame .type2.up.frame.left.l1
    frame .type2.up.frame.left.l2
    frame .type2.up.frame.left.l3
    frame .type2.up.frame.left.l4
    pack  .type2.up.frame.left.l0 .type2.up.frame.left.l1 .type2.up.frame.left.l2 \
	  .type2.up.frame.left.l3 .type2.up.frame.left.l4 -anchor w -expand 1 -fill x

    label .type2.up.frame.left.l0.label -text "GAP variable:"
    label .type2.up.frame.left.l1.label -text "Number of generators:"
    label .type2.up.frame.left.l2.label -text "Degree of the transformations:"
    label .type2.up.frame.left.l3.label -text "Monoid:"
    label .type2.up.frame.left.l4.label -text "Semigroup:"
    pack  .type2.up.frame.left.l0.label .type2.up.frame.left.l1.label .type2.up.frame.left.l2.label \
	  .type2.up.frame.left.l3.label .type2.up.frame.left.l4.label -anchor w

    frame .type2.up.frame.right.l0
    frame .type2.up.frame.right.l1
    frame .type2.up.frame.right.l2
    frame .type2.up.frame.right.l3
    frame .type2.up.frame.right.l4
    pack  .type2.up.frame.right.l0 .type2.up.frame.right.l1 .type2.up.frame.right.l2 \
	  .type2.up.frame.right.l3 .type2.up.frame.right.l4 -anchor w

    entry .type2.up.frame.right.l0.entry -width 8
    entry .type2.up.frame.right.l1.entry -width 8
    entry .type2.up.frame.right.l2.entry -width 8
    radiobutton .type2.up.frame.right.l3.rb1 -variable monoid -value 1
    .type2.up.frame.right.l3.rb1 select
    radiobutton .type2.up.frame.right.l3.rb2 -variable monoid -value 0
    pack  .type2.up.frame.right.l0.entry .type2.up.frame.right.l1.entry .type2.up.frame.right.l2.entry \
	  .type2.up.frame.right.l3.rb1 .type2.up.frame.right.l3.rb2

    button .type2.down.frame.proceedt2 -command proceedt2 -text Proceed
    pack   .type2.down.frame.proceedt2 -padx 2 -pady 2

    bind .type2.up.frame.right.l0.entry <Return> {.type2.down.frame.proceedt2 invoke}
    bind .type2.up.frame.right.l1.entry <Return> {.type2.down.frame.proceedt2 invoke}
    bind .type2.up.frame.right.l2.entry <Return> {.type2.down.frame.proceedt2 invoke}
    bind .type2.down.frame.proceedt2 <Return> {.type2.down.frame.proceedt2 invoke}

    focus .type2.up.frame.right.l0.entry
}


proc displayType4 [] {
    global monoid

    destroyWindows2

    frame .type4
    pack  .type4 -expand 1 -fill both

    frame .type4.up -relief groove -bd 1
    frame .type4.down -relief groove -bd 1
    pack  .type4.up .type4.down -expand 1 -fill both

    frame .type4.up.frame
    frame .type4.down.frame
    pack  .type4.up.frame .type4.down.frame

    frame .type4.up.frame.left
    frame .type4.up.frame.right
    pack  .type4.up.frame.left .type4.up.frame.right -side left

    frame .type4.up.frame.left.l0
    frame .type4.up.frame.left.l1
    frame .type4.up.frame.left.l2
    frame .type4.up.frame.left.l3
    frame .type4.up.frame.left.l4
    pack  .type4.up.frame.left.l0 .type4.up.frame.left.l1 .type4.up.frame.left.l2 \
	  .type4.up.frame.left.l3 .type4.up.frame.left.l4 -anchor w -expand 1 -fill x

    label .type4.up.frame.left.l0.label -text "GAP variable:"
    label .type4.up.frame.left.l1.label -text "Number of generators:"
    label .type4.up.frame.left.l2.label -text "Degree of the transformations:"
    label .type4.up.frame.left.l3.label -text "Monoid:"
    label .type4.up.frame.left.l4.label -text "Semigroup:"
    pack  .type4.up.frame.left.l0.label .type4.up.frame.left.l1.label .type4.up.frame.left.l2.label \
	  .type4.up.frame.left.l3.label .type4.up.frame.left.l4.label -anchor w

    frame .type4.up.frame.right.l0
    frame .type4.up.frame.right.l1
    frame .type4.up.frame.right.l2
    frame .type4.up.frame.right.l3
    frame .type4.up.frame.right.l4
    pack  .type4.up.frame.right.l0 .type4.up.frame.right.l1 .type4.up.frame.right.l2 \
	  .type4.up.frame.right.l3 .type4.up.frame.right.l4 -anchor w

    entry .type4.up.frame.right.l0.entry -width 8
    entry .type4.up.frame.right.l1.entry -width 8
    entry .type4.up.frame.right.l2.entry -width 8
    radiobutton .type4.up.frame.right.l3.rb1 -variable monoid -value 1
    .type4.up.frame.right.l3.rb1 select
    radiobutton .type4.up.frame.right.l3.rb2 -variable monoid -value 0
    pack  .type4.up.frame.right.l0.entry .type4.up.frame.right.l1.entry .type4.up.frame.right.l2.entry \
	  .type4.up.frame.right.l3.rb1 .type4.up.frame.right.l3.rb2

    button .type4.down.frame.proceedt4 -command proceedt4 -text Proceed
    pack   .type4.down.frame.proceedt4 -padx 2 -pady 2

    bind .type4.up.frame.right.l0.entry <Return> {.type4.down.frame.proceedt4 invoke}
    bind .type4.up.frame.right.l1.entry <Return> {.type4.down.frame.proceedt4 invoke}
    bind .type4.up.frame.right.l2.entry <Return> {.type4.down.frame.proceedt4 invoke}
    bind .type4.down.frame.proceedt4 <Return> {.type4.down.frame.proceedt4 invoke}

    focus .type4.up.frame.right.l0.entry
}


proc displayType3 [] {

    destroyWindows2

    frame .type3
    pack  .type3 -expand 1 -fill both

    frame .type3.up -relief groove -bd 1
    frame .type3.down -relief groove -bd 1
    pack  .type3.up .type3.down -expand 1 -fill both

    frame .type3.up.frame
    frame .type3.down.frame
    pack  .type3.up.frame .type3.down.frame

    frame .type3.up.frame.left
    frame .type3.up.frame.right
    pack  .type3.up.frame.left .type3.up.frame.right -side left

    frame .type3.up.frame.left.l0
    pack  .type3.up.frame.left.l0 -anchor w -expand 1 -fill x

    label .type3.up.frame.left.l0.label -text "GAP variable:"
    pack  .type3.up.frame.left.l0.label -anchor w

    frame .type3.up.frame.right.l0
    pack  .type3.up.frame.right.l0 -anchor w

    entry .type3.up.frame.right.l0.entry -width 8
    pack  .type3.up.frame.right.l0.entry

    button .type3.down.frame.re -command ratExp -text "Rational expression"
    button .type3.down.frame.aut -command xAut -text "Automaton"
    pack  .type3.down.frame.re .type3.down.frame.aut -padx 2 -pady 2 -side left

    bind .type3.down.frame.re <Return> {.type3.down.frame.re invoke}
    bind .type3.down.frame.aut <Return> {.type3.down.frame.aut invoke}

    focus .type3.up.frame.right.l0.entry

}


#-----------------------------------------------------
#------ Proceed --------------------------------------
#-----------------------------------------------------

proc proceedt1 [] {

    destroyWindows

    set var   [.type1.up.frame.right.l0.entry get]
    set ngens [.type1.up.frame.right.l1.entry get]
    set nrels [.type1.up.frame.right.l2.entry get]

    if {$var == ""} {
	error "Please specify the GAP variable\n to which the semigroup will be associated"
    }
    if {[string is integer $var]} {
	error "The GAP variable must be a string,\n not an integer"
    }
    if {![string is integer $ngens] || $ngens > 26 || $ngens < 1} {
	error "The number of generators must be\n a positive integer less than 27"
    }
    if {![string is integer $nrels] || $nrels < 1} {
	error "The number of relations must be\n a positive integer"
    }


    frame .type12 -relief groove -bd 1
    pack  .type12 -expand 1 -fill both
    frame .type12.frame
    pack  .type12.frame

    frame .type12.frame.left
    frame .type12.frame.middle -relief groove -bd 2 -bg aquamarine2
    frame .type12.frame.right
    pack  .type12.frame.left .type12.frame.middle .type12.frame.right -side left -anchor n -expand 1 -fill y

    label .type12.frame.middle.label -text "    " -bg aquamarine2
    pack  .type12.frame.middle.label

    frame .type12.down -relief groove -bd 1
    pack  .type12.down -expand 1 -fill both
    frame .type12.down.frame
    pack  .type12.down.frame

    button .type12.down.frame.another  -command another12 -text "Another relation"
    button .type12.down.frame.done  -command done12 -text "Done"

    bind .type12.down.frame.another <Return> {.type12.down.frame.another invoke}
    bind .type12.down.frame.done <Return> {.type12.down.frame.done invoke}

    menubutton .type12.down.frame.functions -text Functions -menu .type12.down.frame.functions.menu -takefocus 1

    pack .type12.down.frame.functions .type12.down.frame.another .type12.down.frame.done -padx 2 -pady 2 -side left

    menu .type12.down.frame.functions.menu


    .type12.down.frame.functions.menu add command -label "Add a function to this menu" -command "addFunc 1"
    .type12.down.frame.functions.menu add command -label "Remove an added function" -command "remFunc 1"
    .type12.down.frame.functions.menu add separator



    .type12.down.frame.functions.menu add command -label "Draw Cayley Graph" -command "drawCayley 1"
    .type12.down.frame.functions.menu add command -label "Draw D-Classes" -command "drawDClasses 1"
    .type12.down.frame.functions.menu add command -label "Draw D-Classes (Transformations)" -command "drawDClassesT 1"
    .type12.down.frame.functions.menu add command -label "Draw Schutzenberger Graphs" -command "drawSchut 1"
.type12.down.frame.functions.menu add command -label "Size" -command "callSize 1"
.type12.down.frame.functions.menu add separator
set fl [open "xsemi_new_funcs.tcl.menu1" r]
    set cmd [read $fl]
    eval $cmd
    if {[catch {close $fl} err]} {
    }




    for {set i 1} {$i <= $nrels} {incr i 1} {
	insertRelation $i
    }

    focus .type12.frame.left.line1.f1.e1
}


proc proceedt2 [] {

    destroyWindows

    set var   [.type2.up.frame.right.l0.entry get]
    set ngens [.type2.up.frame.right.l1.entry get]
    set dgtrs [.type2.up.frame.right.l2.entry get]

    if {$var == ""} {
	error "Please specify the GAP variable\n to which the semigroup will be associated"
    }
    if {[string is integer $var]} {
	error "The GAP variable must be a string,\n not an integer"
    }
    if {![string is integer $ngens] || $ngens > 26 || $ngens < 1} {
	error "The number of generators must be\n a positive integer less than 27"
    }
    if {![string is integer $dgtrs] || $dgtrs < 1} {
	error "The degree of the transformations must be\n a positive integer"
    }


    frame .type22 -relief groove -bd 1
    pack  .type22 -expand 1 -fill both
    frame .type22.frame
    pack  .type22.frame

    frame .type22.down -relief groove -bd 1
    pack  .type22.down -expand 1 -fill both
    frame .type22.down.frame
    pack  .type22.down.frame

    button .type22.down.frame.another  -command another22 -text "Another transformation"
    button .type22.down.frame.done  -command done22 -text "Done"

    bind .type22.down.frame.another <Return> {.type22.down.frame.another invoke}
    bind .type22.down.frame.done <Return> {.type22.down.frame.done invoke}

    menubutton .type22.down.frame.functions -text Functions -menu .type22.down.frame.functions.menu -takefocus 1

    pack .type22.down.frame.functions .type22.down.frame.another .type22.down.frame.done -padx 2 -pady 2 -side left

    menu .type22.down.frame.functions.menu

    .type22.down.frame.functions.menu add command -label "Add a function to this menu" -command "addFunc 2"
.type22.down.frame.functions.menu add command -label "Remove an added function" -command "remFunc 2"

    .type22.down.frame.functions.menu add separator



    .type22.down.frame.functions.menu add command -label "Draw Cayley Graph" -command "drawCayley 2"
    .type22.down.frame.functions.menu add command -label "Draw D-Classes" -command "drawDClasses 2"
.type22.down.frame.functions.menu add command -label "Draw D-Classes (Transformations)" -command "drawDClassesT 2"
    .type22.down.frame.functions.menu add command -label "Draw Schutzenberger Graphs" -command "drawSchut 2"
    .type22.down.frame.functions.menu add command -label "Size" -command "callSize 2"
.type22.down.frame.functions.menu add separator
set fl [open "xsemi_new_funcs.tcl.menu2" r]
    set cmd [read $fl]
    eval $cmd
    if {[catch {close $fl} err]} {
    }



    for {set j 1} {$j <= $dgtrs} {incr j 1} {

    }

    for {set i 1} {$i <= $ngens} {incr i 1} {
	insertTransformation $i $dgtrs
    }

    focus .type22.frame.line1.right.entry1
}


proc proceedt4 [] {

    destroyWindows

    set var   [.type4.up.frame.right.l0.entry get]
    set ngens [.type4.up.frame.right.l1.entry get]
    set dgtrs [.type4.up.frame.right.l2.entry get]

    if {$var == ""} {
	error "Please specify the GAP variable\n to which the semigroup will be associated"
    }
    if {[string is integer $var]} {
	error "The GAP variable must be a string,\n not an integer"
    }
    if {![string is integer $ngens] || $ngens > 26 || $ngens < 1} {
	error "The number of generators must be\n a positive integer less than 27"
    }
    if {![string is integer $dgtrs] || $dgtrs < 1} {
	error "The degree of the transformations must be\n a positive integer"
    }


    frame .type42 -relief groove -bd 1
    pack  .type42 -expand 1 -fill both
    frame .type42.frame
    pack  .type42.frame

    frame .type42.down -relief groove -bd 1
    pack  .type42.down -expand 1 -fill both
    frame .type42.down.frame
    pack  .type42.down.frame

    button .type42.down.frame.another  -command another42 -text "Another transformation"
    button .type42.down.frame.done  -command done42 -text "Done"

    bind .type42.down.frame.another <Return> {.type42.down.frame.another invoke}
    bind .type42.down.frame.done <Return> {.type42.down.frame.done invoke}

    menubutton .type42.down.frame.functions -text Functions -menu .type42.down.frame.functions.menu -takefocus 1

    pack .type42.down.frame.functions .type42.down.frame.another .type42.down.frame.done -padx 2 -pady 2 -side left

    menu .type42.down.frame.functions.menu

    .type42.down.frame.functions.menu add command -label "Add a function to this menu" -command "addFunc 4"
.type42.down.frame.functions.menu add command -label "Remove an added function" -command "remFunc 4"

    .type42.down.frame.functions.menu add separator



    .type42.down.frame.functions.menu add command -label "Draw Cayley Graph" -command "drawCayley 4"
    .type42.down.frame.functions.menu add command -label "Draw D-Classes" -command "drawDClasses 4"
.type42.down.frame.functions.menu add command -label "Draw D-Classes (Transformations)" -command "drawDClassesT 4"

    .type42.down.frame.functions.menu add command -label "Draw Schutzenberger Graphs" -command "drawSchut 4"
.type42.down.frame.functions.menu add command -label "Size" -command "callSize 4"
.type42.down.frame.functions.menu add separator
set fl [open "xsemi_new_funcs.tcl.menu4" r]
    set cmd [read $fl]
    eval $cmd
    if {[catch {close $fl} err]} {
    }




    for {set i 1} {$i <= $ngens} {incr i 1} {
	insertPTransformation $i $dgtrs
    }

    focus .type42.frame.line1.right.entry1
}


proc ratExp [] {
    global varS

    destroyWindows

    set varS   [.type3.up.frame.right.l0.entry get]

    if {$varS == ""} {
	error "Please specify the GAP variable\n to which the semigroup will be associated"
    }

    toplevel .xre

    frame .xre.frame
    pack  .xre.frame

    frame .xre.frame.up
    frame .xre.frame.down
    pack .xre.frame.up .xre.frame.down

    frame .xre.frame.up.left
    frame .xre.frame.up.right
    pack  .xre.frame.up.left .xre.frame.up.right -side left

    label .xre.frame.up.left.label -text "Rational expression:"
    pack  .xre.frame.up.left.label

    entry .xre.frame.up.right.entry -width 40
    pack  .xre.frame.up.right.entry

    button .xre.frame.down.ok -command doneRE -text Ok
    pack   .xre.frame.down.ok -padx 2 -pady 2

    focus .xre.frame.up.right.entry
    bind .xre.frame.up.right.entry <Return> {.xre.frame.down.ok invoke}

}

proc xAut [] {
    global varS

    destroyWindows

    set varS   [.type3.up.frame.right.l0.entry get]

    if {$varS == ""} {
	error "Please specify the GAP variable\n to which the semigroup will be associated"
    }

    toplevel .xa

    #-----------------------------------------------------
    #------ XAutomaton Procedures ------------------------
    #-----------------------------------------------------

    proc matrix [] {
	global last_states last_nalph
	if {[winfo exists .xa.matrix]} {
	    .xa.matrix.down.cancel invoke
	}

	set var [.xa.up.var.down.entry get]
	set states [.xa.up.states.down.entry get]
	set alph [.xa.up.alph.down.entry get]

	if {$var == ""} {
	    error "Please fill the Var field with the name of the\nGAP variable that will refer to this Automaton"
	}
	if {$states == ""} {
	    error "Please fill the States field with the number of\nstates of the Automaton"
	}
	if {$alph == ""} {
	    error "Please fill the Alphabet field with the number of\nletters of the alphabet of the Automaton\nor with the sequence of symbols of the alphabet enclosed in double quotes"
	}

	if {[string is integer $var]} {
	    error "The Var field must be filled with a GAP variable\n name, not an integer"
	}
	if {![string is integer $states]} {
	    error "The States field must be filled with an integer"
	}

	if {[string is integer $alph]} {
	    set nalph $alph
	    set flag_alph 0
	} else {
	    set len [string length $alph]
	    incr len -1
	    if {!([string index $alph 0] == {"}) || !([string index $alph $len] == {"})} {
		error "When the alphabet is not an integer\nit must be enclosed in double quotes"
	    }
	    incr len -1
	    set nalph $len
	    set flag_alph 1
	}

	displayMatrix $var $states $alph $nalph $flag_alph
    }


    proc displayMatrix {var states alph nalph flag_alph} {
	global last_matrix last_states last_nalph

	frame .xa.matrix
	frame .xa.matrix.up
	frame .xa.matrix.down
	pack .xa.matrix .xa.matrix.up .xa.matrix.down
	for {set a 1} {$a <= $nalph} {incr a 1} {
	    set lab [format "label%i" $a]
	    set cmd "label .xa.matrix.up."
	    append cmd $lab
	    eval $cmd
	    set cmd "pack .xa.matrix.up."
	    append cmd $lab
	    eval $cmd
	    set lcmd "pack "
	    for {set q 1} {$q <= $states} {incr q 1} {
		set box [format "box%i%i" $a $q]
		set cmd "entry .xa.matrix.up."
		append cmd $lab "." $box " -width 5"
		eval $cmd
		append lcmd ".xa.matrix.up." $lab "." $box " "
	    }
	    append lcmd "-side left"
	    eval $lcmd
	}

	set list [array get last_matrix]
	if {!($list == [])} {
	    for {set a 1} {$a <= $nalph} {incr a 1} {
		set lab [format ".xa.matrix.up.label%i" $a]
		for {set q 1} {$q <= $states} {incr q 1} {
		    if {$a <= $last_nalph && $q <= $last_states} {
			set box [format ".box%i%i" $a $q]
			set cmd ""
			set i [expr ($a-1)*$last_states + $q]
			if {! ($last_matrix($i) == "")} {
			    append cmd $lab $box " insert 0 " $last_matrix($i)
			    eval $cmd
			}
		    }
		}
	    }
	}
	set last_states $states
	set last_nalph $nalph


	menubutton .xa.matrix.down.functions -text Functions -menu .xa.matrix.down.functions.menu -takefocus 1

	button .xa.matrix.down.view -text View -command "view $var $states $alph $nalph $flag_alph"
	button .xa.matrix.down.ok -text Ok -command "finish $var $states $alph $nalph $flag_alph"
	button .xa.matrix.down.clear -text Clear -command clearMatrix
	button .xa.matrix.down.cancel -text Cancel -command destroyMatrix
	pack .xa.matrix.down.functions .xa.matrix.down.view .xa.matrix.down.ok .xa.matrix.down.clear .xa.matrix.down.cancel -side left

	menu .xa.matrix.down.functions.menu
	.xa.matrix.down.functions.menu add command -label "Get rational expression" -command "getRatExp $var $states $alph $nalph $flag_alph"
	.xa.matrix.down.functions.menu add command -label "View minimalized automaton" -command "viewMinAut $var $states $alph $nalph $flag_alph"
	.xa.matrix.down.functions.menu add command -label "Edit minimalized automaton" -command "editMinAut $var $states $alph $nalph $flag_alph"
	.xa.matrix.down.functions.menu add command -label "Syntatic semigroup" -command "transitionSemigroup $var $states $alph $nalph $flag_alph"


	for {set a 1} {$a <= $nalph} {incr a 1} {
	    set lab [format "bind .xa.matrix.up.label%i" $a]
	    for {set q 1} {$q <= $states} {incr q 1} {
		set box [format "%s.box%i%i %s" $lab $a $q {<Return> {.xa.matrix.down.ok invoke}}]
		eval $box
	    }
	}

	bind .xa.matrix.down.view   <Return> {.xa.matrix.down.view invoke}
	bind .xa.matrix.down.ok     <Return> {.xa.matrix.down.ok invoke}
	bind .xa.matrix.down.clear  <Return> {.xa.matrix.down.clear invoke}
	bind .xa.matrix.down.cancel <Return> {.xa.matrix.down.cancel invoke}
	focus .xa.matrix.up.label1.box11
    }


    proc finish {var states alph nalph flag_alph} {
	global varS

	set str "$var:="
	append str [getAutomaton $var $states $alph $nalph $flag_alph] ";"
	puts $str
	puts "$varS:=TransitionSemigroup($var);"
	puts "end"
	destroyMatrix
	destroy .xa
	.middle.frame.rb3 select

	if {![winfo exists .type3.down.frame.functions]} {
	    menubutton .type3.down.frame.functions -text Functions -menu .type3.down.frame.functions.menu -takefocus 1

	    pack .type3.down.frame.functions -padx 2 -pady 2

	    menu .type3.down.frame.functions.menu

.type3.down.frame.functions.menu add command -label "Add a function to this menu" -command "addFunc 3"
.type3.down.frame.functions.menu add command -label "Remove an added function" -command "remFunc 3"

    .type3.down.frame.functions.menu add separator



	    .type3.down.frame.functions.menu add command -label "Draw Cayley Graph" -command "drawCayley 3"
	    .type3.down.frame.functions.menu add command -label "Draw D-Classes" -command "drawDClasses 3"
.type3.down.frame.functions.menu add command -label "Draw D-Classes (Transformations)" -command "drawDClassesT 3"

	    .type3.down.frame.functions.menu add command -label "Draw Schutzenberger Graphs" -command "drawSchut 3"
.type3.down.frame.functions.menu add command -label "Size" -command "callSize 3"
.type3.down.frame.functions.menu add separator
set fl [open "xsemi_new_funcs.tcl.menu3" r]
    set cmd [read $fl]
    eval $cmd
    if {[catch {close $fl} err]} {
    }



	}
    }



    proc view {var states alph nalph flag_alph} {
	set str "DrawAutomaton("
	append str [getAutomaton $var $states $alph $nalph $flag_alph] ");"
	puts $str
	puts "end"
    }


    proc getRatExp {var states alph nalph flag_alph} {
	set str "re:=FAtoRatExp("
	append str [getAutomaton $var $states $alph $nalph $flag_alph] ");"
	puts $str
	puts "end"
    }


    proc viewMinAut {var states alph nalph flag_alph} {
	set str "min:=MinimalAutomaton("
	append str [getAutomaton $var $states $alph $nalph $flag_alph] ");"
	puts $str
	set str "DrawAutomaton(min);"
	puts $str
	puts "end"
    }


    proc editMinAut {var states alph nalph flag_alph} {
	set str "min:=MinimalAutomaton("
	append str [getAutomaton $var $states $alph $nalph $flag_alph] ");"
	puts $str
	set str {XAutomaton(min,"min");}
	puts $str
	puts "end"
    }


    proc transitionSemigroup {var states alph nalph flag_alph} {
	global type

	if {!($type == "det")} {
	    error "To compute the transition semigroup\nthe automaton must be deterministic"
	}
	set str "ts:=TransitionSemigroup("
	append str [getAutomaton $var $states $alph $nalph $flag_alph] ");"
	puts $str
	puts "end"
    }



    proc cancel [] {
	puts "end"
	destroy .xa
	.middle.frame.rb3 select
    }

    proc destroyMatrix [] {
	global last_matrix last_states last_nalph

	set list []
	set i 1
	for {set a 1} {$a <= $last_nalph} {incr a 1} {
	    set lab [format ".xa.matrix.up.label%i" $a]
	    for {set q 1} {$q <= $last_states} {incr q 1} {
		set box [format ".box%i%i" $a $q]
		set cmd {set val [}
		    append cmd $lab $box { get]}
		eval $cmd
		lappend list $i $val
		incr i 1
	    }
	}

	array set last_matrix $list
	destroy .xa.matrix
    }


    proc clearMatrix [] {
	global last_matrix last_states last_nalph

	array set last_matrix []
	set last_states -1
	set last_nalph -1
	.xa.down.matrix invoke
    }



    proc testAut {states nalph} {
	global type

	for {set a 1} {$a <= $nalph} {incr a 1} {
	    set lab [format ".xa.matrix.up.label%i" $a]
	    for {set q 1} {$q <= $states} {incr q 1} {
		set box [format ".box%i%i" $a $q]
		set cmd {set res [}
		    append cmd $lab $box { get]}
		eval $cmd
		set ares [split $res ,]
		if {$type == "det" && [llength $ares] > 1} {
		    error "For a deterministic Automaton, each entry in the\ntransition matrix must be a single integer\nbetween 0 and the number of states of the Automaton"
		}
		foreach s $ares {
		    if {![string is integer $s]} {
			error "The entries in the transition matrix must be integers\nor a comma separated list of integers\nbetween 0 and the number of states of the Automaton"
		    }
		    if {$s < 0 || $s > $states} {
			error "The entries in the transition matrix must be integers\nor a comma separated list of integers\nbetween 0 and the number of states of the Automaton"
		    }
		}
	    }
	}
    }


    proc getAutomaton {var states alph nalph flag_alph} {
	global type

	testAut $states $nalph
	set T {[}
	    if {$type == "det"} {
		for {set a 1} {$a <= $nalph} {incr a 1} {
		    append T {[}
			set lab [format ".xa.matrix.up.label%i" $a]
			for {set q 1} {$q <= $states} {incr q 1} {
			    set box [format ".box%i%i" $a $q]
			    set cmd {set res [}
			    append cmd $lab $box { get]}
			    eval $cmd
			    if {$q == $states} {
				append T $res
			    } else {
				append T $res ","
			    }
			}
			if {$a == $nalph} {
			    append T {]}
		    } else {
			append T {],}
		}
	    }
	    append T {]}
            } else {
		for {set a 1} {$a <= $nalph} {incr a 1} {
		    append T {[}
		    set lab [format ".xa.matrix.up.label%i" $a]
		    for {set q 1} {$q <= $states} {incr q 1} {
			append T {[}
			    set box [format ".box%i%i" $a $q]
			    set cmd {set res [}
				append cmd $lab $box { get]}
			    eval $cmd
			    if {$q == $states} {
				append T $res {]}
			} else {
			    append T $res {],}
		    }
		    }
		    if {$a == $nalph} {
			append T {]}
		} else {
		    append T {],}
            }
            }
            append T {]}
            }


            set ini [.xa.up.ini.down.entry get]
            set fin [.xa.up.fin.down.entry get]


    set str ""
    append str {Automaton("}
    if {$flag_alph == 0} {
	append str $type {",} $states "," $alph "," $T {,[} $ini {],[} $fin {])}
    } else {
	append str $type {",} $states {,"} $alph {",} $T {,[} $ini {],[} $fin {])}
    }
    return $str
#"
	}


	#-----------------------------------------------------
	#------ Up -------------------------------------------
	#-----------------------------------------------------

	frame .xa.up -relief groove -bd 1
	frame .xa.down
	pack .xa.up
	pack .xa.down

	frame .xa.up.var -relief groove -bd 1
	frame .xa.up.type -relief groove -bd 1
	frame .xa.up.states -relief groove -bd 1
	frame .xa.up.alph -relief groove -bd 1
	frame .xa.up.ini -relief groove -bd 1
	frame .xa.up.fin -relief groove -bd 1
	pack .xa.up.var .xa.up.type .xa.up.states .xa.up.alph .xa.up.ini .xa.up.fin -side left -anchor n -expand yes -fill y


	frame .xa.up.var.up
	frame .xa.up.var.down
	frame .xa.up.type.up
	frame .xa.up.type.down
	frame .xa.up.states.up
	frame .xa.up.states.down
	frame .xa.up.alph.up
	frame .xa.up.alph.down
	frame .xa.up.ini.up
	frame .xa.up.ini.down
	frame .xa.up.fin.up
	frame .xa.up.fin.down
	pack .xa.up.var.up   .xa.up.type.up   .xa.up.states.up   .xa.up.alph.up   .xa.up.ini.up   .xa.up.fin.up   -anchor n
	pack .xa.up.var.down .xa.up.type.down .xa.up.states.down .xa.up.alph.down .xa.up.ini.down .xa.up.fin.down -anchor n -expand yes -fill y


	label .xa.up.var.up.label -text "Var"
	label .xa.up.type.up.label -text "Type"
	label .xa.up.states.up.label -text "States"
	label .xa.up.alph.up.label -text "Alphabet"
	label .xa.up.ini.up.label -text "Initial"
	label .xa.up.fin.up.label -text "Final"
	pack .xa.up.var.up.label .xa.up.type.up.label .xa.up.states.up.label .xa.up.alph.up.label .xa.up.ini.up.label .xa.up.fin.up.label


	entry .xa.up.var.down.entry -width 6
	pack .xa.up.var.down.entry

	radiobutton .xa.up.type.down.rb1 -variable type -value det -text det -justify left
	.xa.up.type.down.rb1 select
	radiobutton .xa.up.type.down.rb2 -variable type -value nondet -text nondet -justify left
	radiobutton .xa.up.type.down.rb3 -variable type -value epsilon -text epsilon -justify left
	pack .xa.up.type.down.rb1 .xa.up.type.down.rb2 .xa.up.type.down.rb3 -anchor w

	entry .xa.up.states.down.entry -width 6
	pack .xa.up.states.down.entry

	entry .xa.up.alph.down.entry -width 16
	pack .xa.up.alph.down.entry

	entry .xa.up.ini.down.entry -width 16
	pack .xa.up.ini.down.entry

	entry .xa.up.fin.down.entry -width 16
	pack .xa.up.fin.down.entry


	#-----------------------------------------------------
	#------ Down -----------------------------------------
	#-----------------------------------------------------

	button .xa.down.matrix -command matrix -text "Transition Matrix"
	button .xa.down.cancel -command cancel -text Quit
	pack .xa.down.matrix .xa.down.cancel -side left


	#-----------------------------------------------------
	#------ Bindings -------------------------------------
	#-----------------------------------------------------

#	bind .xa.up.var.up.label <Destroy> {.xa.down.cancel invoke}

	bind .xa.down.matrix <Return> {.xa.down.matrix invoke}
	bind .xa.down.cancel <Return> {.xa.down.cancel invoke}

	bind .xa.up.var.down.entry    <KeyPress-Return> {.xa.down.matrix invoke}
	bind .xa.up.states.down.entry <KeyPress-Return> {.xa.down.matrix invoke}
	bind .xa.up.alph.down.entry   <KeyPress-Return> {.xa.down.matrix invoke}
	bind .xa.up.ini.down.entry    <KeyPress-Return> {.xa.down.matrix invoke}
	bind .xa.up.fin.down.entry    <KeyPress-Return> {.xa.down.matrix invoke}

	bind .xa       <Control-q> {.xa.down.cancel invoke}


	#-----------------------------------------------------
	#------ Finalization/Initialization ------------------
	#-----------------------------------------------------

	focus .xa.up.var.down.entry
	wm title .xa "XAutomaton - GAP Interface"

	#-----------------------------------------------------
	#------ End of XAutomaton ----------------------------
	#-----------------------------------------------------



}


#-----------------------------------------------------
#------ Another --------------------------------------
#-----------------------------------------------------

proc another12 [] {

    set nrels [.type1.up.frame.right.l2.entry get]

    .type1.up.frame.right.l2.entry delete 0 [string length $nrels]
    incr nrels 1
    .type1.up.frame.right.l2.entry insert 0 $nrels

    set e1 [insertRelation $nrels]
    focus $e1
}


proc another22 [] {

    set ngens [.type2.up.frame.right.l1.entry get]
    set dgtrs [.type2.up.frame.right.l2.entry get]

    .type2.up.frame.right.l1.entry delete 0 [string length $ngens]
    incr ngens 1
    .type2.up.frame.right.l1.entry insert 0 $ngens

    insertTransformation $ngens $dgtrs

    focus ".type22.frame.line$ngens.right.entry1"

}


proc another42 [] {

    set ngens [.type4.up.frame.right.l1.entry get]
    set dgtrs [.type4.up.frame.right.l2.entry get]

    .type4.up.frame.right.l1.entry delete 0 [string length $ngens]
    incr ngens 1
    .type4.up.frame.right.l1.entry insert 0 $ngens

    insertPTransformation $ngens $dgtrs

    focus ".type42.frame.line$ngens.right.entry1"
}


#-----------------------------------------------------
#------ Insert Another -------------------------------
#-----------------------------------------------------

proc insertRelation {i} {

    set line [format "line%i" $i]
    set cmd ""
    if {[expr $i % 2] == 1} {
	append cmd ".type12.frame.left." $line
    } else {
	append cmd ".type12.frame.right." $line
    }
    frame $cmd
    pack $cmd
    set f1 ""
    set f2 ""
    set f3 ""
    append f1 $cmd ".f1"
    append f2 $cmd ".f2"
    append f3 $cmd ".f3"
    frame $f1
    frame $f2
    frame $f3
    pack $f1 $f2 $f3 -side left

    set e1 ""
    set e12 ""
    set lab ""
    set lab2 ""
    set e2 ""
    set e22 ""

    append e1 $f1 ".e1"
    append e12 $e1 " -width 10"
    set cmd "entry "
    append cmd $e12
    eval $cmd
    pack $e1
    bind $e1 <Return> {.type12.down.frame.done invoke}

    append lab $f2 ".label"
    append lab2 $lab " -text ="
    set cmd "label "
    append cmd $lab2
    eval $cmd
    pack $lab

    append e2 $f3 ".e2"
    append e22 $e2 " -width 10"
    set cmd "entry "
    append cmd $e22
    eval $cmd
    pack $e2
    bind $e2 <Return> {.type12.down.frame.done invoke}

    return $e1
}


proc insertTransformation {i dgtrs} {


    if {$i == 1} {
	frame .type22.frame.line0
	pack .type22.frame.line0  -expand 1 -fill both  -anchor w
    }

    set line [format "line%i" $i]
    set cmd ""
    set cmd2 "frame "
    append cmd ".type22.frame." $line
    append cmd2 $cmd
    eval $cmd2
    pack $cmd -expand 1 -fill both  -anchor w

    set left ""
    set right ""
    append left  $cmd ".left"
    append right $cmd ".right"
    frame $left
    frame $right
    pack $left $right -side left


    if {$i == 1} {
	frame .type22.frame.line0.left
	frame .type22.frame.line0.right
	pack .type22.frame.line0.left .type22.frame.line0.right -side left
	label .type22.frame.line0.left.label -width 16
	pack .type22.frame.line0.left.label
    }

    if {$i < 10} {
	set txt [format "Transformation 0%i:" $i]
    } else {
	set txt [format "Transformation %i:" $i]
    }
    set lab ""
    set lab2 "label "
    append lab $left ".label"
    append lab2 $lab { -text "} $txt {"}
    eval $lab2
    pack $lab

    for {set j 1} {$j <= $dgtrs} {incr j 1} {
	if {$i == 1} {
	    set ent ""
	    set ent2 "label "
	    append ent ".type22.frame.line0.right.label" $j
	    append ent2 $ent "  -text $j -width 3"
	    eval $ent2
	    pack $ent -side left
	}
	set ent ""
	set ent2 "entry "
	append ent $right ".entry" $j
	append ent2 $ent " -width 3"
	eval $ent2
	pack $ent -side left
	bind $ent <Return> {.type22.down.frame.done invoke}
    }

}


proc insertPTransformation {i dgtrs} {

    if {$i == 1} {
	frame .type42.frame.line0
	pack .type42.frame.line0  -expand 1 -fill both  -anchor w
    }

    set line [format "line%i" $i]
    set cmd ""
    set cmd2 "frame "
    append cmd ".type42.frame." $line
    append cmd2 $cmd
    eval $cmd2
    pack $cmd -expand 1 -fill both  -anchor w

    set left ""
    set right ""
    append left  $cmd ".left"
    append right $cmd ".right"
    frame $left
    frame $right
    pack $left $right -side left

    if {$i == 1} {
	frame .type42.frame.line0.left
	frame .type42.frame.line0.right
	pack .type42.frame.line0.left .type42.frame.line0.right -side left
	label .type42.frame.line0.left.label -width 16
	pack .type42.frame.line0.left.label
    }


    if {$i < 10} {
	set txt [format "Transformation 0%i:" $i]
    } else {
	set txt [format "Transformation %i:" $i]
    }
    set lab ""
    set lab2 "label "
    append lab $left ".label"
    append lab2 $lab { -text "} $txt {"}
    eval $lab2
    pack $lab

    for {set j 1} {$j <= $dgtrs} {incr j 1} {
	if {$i == 1} {
	    set ent ""
	    set ent2 "label "
	    append ent ".type42.frame.line0.right.label" $j
	    append ent2 $ent "  -text $j -width 3"
	    eval $ent2
	    pack $ent -side left
	}
	set ent ""
	set ent2 "entry "
	append ent $right ".entry" $j
	append ent2 $ent " -width 3"
	eval $ent2
	pack $ent -side left

	bind $ent <Return> {.type42.down.frame.done invoke}
    }
}


#-----------------------------------------------------
#------ Done -----------------------------------------
#-----------------------------------------------------

proc done12 [] {
    global monoid generators

    set var   [.type1.up.frame.right.l0.entry get]
    set ngens [.type1.up.frame.right.l1.entry get]
    set nrels [.type1.up.frame.right.l2.entry get]

    if {$monoid == 1} {
	set str {fxsgp:=FreeMonoid(}
    } else {
	set str {fxsgp:=FreeSemigroup(}
    }
    for {set i 0} {$i < $ngens} {incr i 1} {
	if {$i == 0} {
	    append str {"} [lindex $generators $i] {"}
	} else {
	    append str "," {"} [lindex $generators $i] {"}
	}
    }
    append str ");;"
    puts $str
    if {$monoid == 1} {
	for {set i 0} {$i < $ngens} {incr i 1} {
	    set str ""
	    append str [lindex $generators $i] {:=GeneratorsOfMonoid( fxsgp )[ } [expr $i+1] { ];;}
	    puts $str
	}
    } else {
	for {set i 0} {$i < $ngens} {incr i 1} {
	    set str ""
	    append str [lindex $generators $i] {:=GeneratorsOfSemigroup( fxsgp )[ } [expr $i+1] { ];;}
	    puts $str
	}
    }
    set str ""
    append str {rxsgp:=[}
    set flag 1

    for {set i 1} {$i <= $nrels} {incr i 1} {
	if {[expr $i % 2] == 1} {
	    set obj1 [format ".type12.frame.left.line%i.f1.e1" $i]
	    set obj2 [format ".type12.frame.left.line%i.f3.e2" $i]
	} else {
	    set obj1 [format ".type12.frame.right.line%i.f1.e1" $i]
	    set obj2 [format ".type12.frame.right.line%i.f3.e2" $i]
	}
	set lh [$obj1 get]
	set rh [$obj2 get]

	set len1 [string length $lh]
	set len2 [string length $rh]
	if {$len1 == 0 && $len2 == 0} {

	} elseif {$len1 == 0 && $len2 != 0} {
	    error "There's one relation with one empty side ($lh = $rh)"
	} elseif {$len1 != 0 && $len2 == 0} {
	    error "There's one relation with one empty side ($lh = $rh)"
	} elseif {$lh == 0} {
	    error "Please use the abbreviation 0 or 1\n only on the right hand side of the relation ($lh = $rh)"
	} elseif {$lh == 1} {
	    error "Please use the abbreviation 0 or 1\n only on the right hand side of the relation ($lh = $rh)"
	} elseif {$rh == 0} {
	    set left  [parseRelation $ngens $nrels $lh $len1 "$lh = $rh"]
	    for {set j 0} {$j < $ngens} {incr j 1} {
		set g [lindex $generators $j]
		if {$j == 0} {
		    if {$flag == 1} {
			append str {[} $left "*$g," $left {]}
			set flag 0
		    } else {
			append str {,[} $left "*$g," $left {]}
		    }
		    append str {,[} "$g*" $left "," $left {]}
		} else {
		    append str {,[} $left "*$g," $left {]}
		    append str {,[} "$g*" $left "," $left {]}
		}
	    }
	} elseif {$rh == 1} {
	    set left  [parseRelation $ngens $nrels $lh $len1 "$lh = $rh"]
	    for {set j 0} {$j < $ngens} {incr j 1} {
		set g [lindex $generators $j]
		if {$j == 0} {
		    if {$flag == 1} {
			append str {[} $left "*$g," $g {]}
			set flag 0
		    } else {
			append str {,[} $left "*$g," $g {]}
		    }
		    append str {,[} "$g*" $left "," $g {]}
		} else {
		    append str {,[} $left "*$g," $g {]}
		    append str {,[} "$g*" $left "," $g {]}
		}
	    }
	} else {
	    set left  [parseRelation $ngens $nrels $lh $len1 "$lh = $rh"]
	    set right [parseRelation $ngens $nrels $rh $len2 "$lh = $rh"]

	    if {$flag == 1} {
		append str {[} $left "," $right {]}
		set flag 0
	    } else {
		append str {,[} $left "," $right {]}
	    }
	}
    }
    append str {];;}
    puts $str
    puts "$var:=fxsgp/rxsgp;"
    puts "end"
}


proc parseRelation {ngens nrels lh len1 rel} {
    global generators


    set left  ""
    set flag 0
    for {set i 0} {$i < $len1} {incr i 1} {
	set c [string index $lh $i]
	if {[string is integer $c]} {
	    if {$i == 0} {
		error "Left hand side of relation starts with an integer $rel"
	    } elseif {$flag == 1} {
		append left $c
	    } else {
		append left "^" $c
		set flag 1
	    }
	} else {
	    set p [lsearch -exact $generators $c]
	    if {$p == -1} {
		error "Invalid character in relation $rel"
	    } elseif {$p > [expr $ngens - 1]} {
		error "Letter $c is bigger than the number of generators ($ngens)"
	    }
	    if {$i == 0} {
		append left $c
	    } else {
		append left "*" $c
	    }
	    set flag 0
	}
    }
    return $left
}


proc done22 [] {
    global monoid

    set var   [.type2.up.frame.right.l0.entry get]
    set ngens [.type2.up.frame.right.l1.entry get]
    set dgtrs [.type2.up.frame.right.l2.entry get]

    if {$monoid == 1} {
	set str "$var:=Monoid("
    } else {
	set str "$var:=Semigroup("
    }
    for {set i 1} {$i <= $ngens} {incr i 1} {
	set trans {Transformation([}
	for {set j 1} {$j <= $dgtrs} {incr j 1} {
	    set obj [format ".type22.frame.line%i.right.entry%i" $i $j]
	    set val [$obj get]
	    if {![string is integer $val] || $val > $dgtrs || $val < 1} {
		error "The value in Transformation $i,\n column $j must be a positive integer less than or equal to $dgtrs"
	    }
	    if {$j == 1} {
		append trans $val
	    } else {
		append trans "," $val
	    }
	}
	append trans {])}
	if {$i == 1} {
	    append str $trans
	} else {
	    append str "," $trans
	}
    }
    append str ");"
    puts $str
    puts "end"
}


proc done42 [] {
    global monoid

    set var   [.type4.up.frame.right.l0.entry get]
    set ngens [.type4.up.frame.right.l1.entry get]
    set dgtrs [.type4.up.frame.right.l2.entry get]

    if {$monoid == 1} {
	set str "$var:=Monoid("
    } else {
	set str "$var:=Semigroup("
    }
    for {set i 1} {$i <= $ngens} {incr i 1} {
	set trans {PartialTransformation([}
	for {set j 1} {$j <= $dgtrs} {incr j 1} {
	    set obj [format ".type42.frame.line%i.right.entry%i" $i $j]
	    set val [$obj get]
	    if {$val == ""} {
		set val 0
	    } elseif {![string is integer $val] || $val > $dgtrs || $val < 1} {
		error "The value in Transformation $i,\n column $j must be a positive integer less than or equal to $dgtrs"
	    }
	    if {$j == 1} {
		append trans $val
	    } else {
		append trans "," $val
	    }
	}
	append trans {])}
	if {$i == 1} {
	    append str $trans
	} else {
	    append str "," $trans
	}
    }
    append str ");"
    puts $str
    puts "end"
}


proc doneRE [] {
    global generators varS

    set S [.xre.frame.up.right.entry get]
    set len [string length $S]
    set op 0
    set nums {0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0}

    for {set i 0} {$i < $len} {incr i 1} {
	set c [string index $S $i]
	if {$c == "("} {
	    incr op 1
	} elseif {$c == ")"} {
	    incr op -1
	    if {$op < 0} {
		error "Mismatched parenthesis at position $i"
	    }
	} elseif {$c == "*" || $c == "U"} {

	} else {
	    set p [lsearch -exact $generators $c]
	    if {$p == -1} {
		error "Invalid character at position $i"
	    } else {
		set nums [lreplace $nums $p $p 1]
	    }
	}
    }
    if {$op != 0} {
	error "Mismatched parenthesis"
    }
    set flag 0
    for {set i 0} {$i < 26} {incr i 1} {
	set c [lindex $nums $i]
	if {$c == 0} {
	    set flag 1
	} elseif {$c == $flag} {
	    error "Letter [lindex $generators $i] is out of order"
	}
    }

    set c [string index $S 0]
    if {$c != "("} {
	set p [lsearch -exact $generators $c]
	if {$p == -1} {
	    error "Ilegal first character"
	} else {
	    set last $c
	}
    } else {
	set last $c
    }


    for {set i 1} {$i < $len} {incr i 1} {
	set c [string index $S $i]

	if {$c == ")" || $c == "U"} {
	    if {$last == "(" || $last == "U"} {
		error "Malformed expression at position $i"
	    }
	} elseif {$c == "*"} {
	    if {$last == "(" || $last == "U" || $last == "*"} {
		error "Malformed expression at position $i"
	    }
	}
	set last $c
    }

    if {$last == "U"} {
	error "Ilegal last character"
    }

    puts "rexsgp:=RationalExpression(\"$S\");"
    puts "autxsgp:=RatExpToAut(rexsgp);"
    puts "$varS:=TransitionSemigroup(autxsgp);"
    puts "end"

    destroy .xre
    .middle.frame.rb3 select

    if {![winfo exists .type3.down.frame.functions]} {
	menubutton .type3.down.frame.functions -text Functions -menu .type3.down.frame.functions.menu -takefocus 1

	pack .type3.down.frame.functions -padx 2 -pady 2

	menu .type3.down.frame.functions.menu

.type3.down.frame.functions.menu add command -label "Add a function to this menu" -command "addFunc 3"
.type3.down.frame.functions.menu add command -label "Remove an added function" -command "remFunc 3"

    .type3.down.frame.functions.menu add separator


	.type3.down.frame.functions.menu add command -label "Draw Cayley Graph" -command "drawCayley 3"
	.type3.down.frame.functions.menu add command -label "Draw D-Classes" -command "drawDClasses 3"
.type3.down.frame.functions.menu add command -label "Draw D-Classes (Transformations)" -command "drawDClassesT 3"

	.type3.down.frame.functions.menu add command -label "Draw Schutzenberger Graphs" -command "drawSchut 3"
.type3.down.frame.functions.menu add command -label "Size" -command "callSize 3"
.type3.down.frame.functions.menu add separator
set fl [open "xsemi_new_funcs.tcl.menu3" r]
    set cmd [read $fl]
    eval $cmd
    if {[catch {close $fl} err]} {
    }



    }
}

#-----------------------------------------------------
#------ Functions ------------------------------------
#-----------------------------------------------------

proc addFunc {var} {

    if {[winfo exists .addfunc]} {
	destroy .addfunc
    }
    toplevel .addfunc

    frame .addfunc.frame
    pack  .addfunc.frame

    frame .addfunc.frame.top
    frame .addfunc.frame.bot
    pack  .addfunc.frame.top .addfunc.frame.bot

    frame .addfunc.frame.top.left
    frame .addfunc.frame.top.right
    pack  .addfunc.frame.top.left .addfunc.frame.top.right -side left

    label .addfunc.frame.top.left.label -text "Function name:"
    pack  .addfunc.frame.top.left.label

    entry .addfunc.frame.top.right.entry -width 40
    pack  .addfunc.frame.top.right.entry

    button .addfunc.frame.bot.ok -command "doneaddFunc $var" -text Ok
    pack   .addfunc.frame.bot.ok -padx 2 -pady 2

    bind .addfunc.frame.top.right.entry <Return> {.addfunc.frame.bot.ok invoke}
    bind .addfunc.frame.bot.ok <Return> {.addfunc.frame.bot.ok invoke}

    focus .addfunc.frame.top.right.entry
}

proc doneaddFunc {var} {
    global new_funcs


    set name   [.addfunc.frame.top.right.entry get]

    set len [string length $name]

    for {set i 0} {$i < $len} {incr i} {
	set c [string index $name $i]
	if {$c == " " } {
	    error "The function's name must contain no spaces"
	    return
	}
    }

    set fl [open "xsemi_new_funcs.tcl.procs" a]
    set str "proc $name {var} {\ninvokeDone\nset obj \[\".type\$var.up.frame.right.l0.entry\" get\]\nputs \"$name"
    append str "(\$obj);\"\nputs \"end\"   \n}\n"
    puts $fl $str
    if {[catch {close $fl} err]} {
    }
    eval $str

    set fl [open "xsemi_new_funcs.tcl.menu1" a]
    set str ".type12.down.frame.functions.menu add command -label \"$name\" -command \"$name 1\""
    puts $fl $str
    if {[catch {close $fl} err]} {
    }
    if {$var == 1} {
	eval $str
    }

    set fl [open "xsemi_new_funcs.tcl.menu2" a]
    set str ".type22.down.frame.functions.menu add command -label \"$name\" -command \"$name 2\""
    puts $fl $str
    if {[catch {close $fl} err]} {
    }
    if {$var == 2} {
	eval $str
    }

    set fl [open "xsemi_new_funcs.tcl.menu4" a]
    set str ".type42.down.frame.functions.menu add command -label \"$name\" -command \"$name 4\""
    puts $fl $str
    if {[catch {close $fl} err]} {
    }
    if {$var == 4} {
	eval $str
    }

    set fl [open "xsemi_new_funcs.tcl.menu3" a]
    set str ".type3.down.frame.functions.menu add command -label \"$name\" -command \"$name 3\""
    puts $fl $str
    if {[catch {close $fl} err]} {
    }
    if {$var == 3} {
	eval $str
    }

    set fl [open "xsemi_new_funcs.tcl.names" a]
    puts $fl $name
    if {[catch {close $fl} err]} {
    }
    lappend new_funcs $name

    set new_list []
    foreach {name} $new_funcs {
	if {$name != ""} {
	    lappend new_list $name
}
}
    set new_funcs $new_list

    destroy .addfunc
}


proc remFunc {var} {
    global new_funcs

    if {[winfo exists .remfunc]} {
	destroy .remfunc
    }
    toplevel .remfunc

    frame .remfunc.frame
    pack  .remfunc.frame

    frame .remfunc.frame.top
    frame .remfunc.frame.bot
    pack  .remfunc.frame.top .remfunc.frame.bot

    listbox .remfunc.frame.top.listbox
    pack .remfunc.frame.top.listbox

    foreach {name} $new_funcs {
	.remfunc.frame.top.listbox insert end $name
    }


    button .remfunc.frame.bot.ok -command "doneremFunc $var" -text Ok
    pack   .remfunc.frame.bot.ok -padx 2 -pady 2

    bind .remfunc.frame.bot.ok <Return> {.remfunc.frame.bot.ok invoke}

}


proc doneremFunc {var} {
    global new_funcs

    set inds   [.remfunc.frame.top.listbox curselection]

    foreach {i} $inds {
	lset new_funcs $i ""
	set rind [expr 10 + $i]
	if {$var == 3} {
	    set str ".type$var.down.frame.functions.menu delete $rind"
	} else {
	    set str ".type$var"
	    append str "2.down.frame.functions.menu delete $rind"
	}
	eval $str
    }
    set new_list []
    foreach {name} $new_funcs {
	if {$name != ""} {
	    lappend new_list $name
	}
    }
    set new_funcs $new_list

    rebuild_new_funcs $var

    destroy .remfunc
}

proc rebuild_new_funcs {var} {
    global new_funcs

    set fl [open "xsemi_new_funcs.tcl.names" w]
    close $fl
    set fl [open "xsemi_new_funcs.tcl.procs" w]
    close $fl
    set fl [open "xsemi_new_funcs.tcl.menu1" w]
    close $fl
    set fl [open "xsemi_new_funcs.tcl.menu2" w]
    close $fl
    set fl [open "xsemi_new_funcs.tcl.menu3" w]
    close $fl
    set fl [open "xsemi_new_funcs.tcl.menu4" w]
    close $fl



    foreach {name} $new_funcs {
	set fl [open "xsemi_new_funcs.tcl.procs" a]
	set str "proc $name {var} {\ninvokeDone\nset obj \[\".type\$var.up.frame.right.l0.entry\" get\]\nputs \"$name"
	append str "(\$obj);\"\nputs \"end\"   \n}\n"
	puts $fl $str
	if {[catch {close $fl} err]} {
	}
	eval $str

	set fl [open "xsemi_new_funcs.tcl.menu1" a]
	set str ".type12.down.frame.functions.menu add command -label \"$name\" -command \"$name 1\""
	puts $fl $str
	if {[catch {close $fl} err]} {
	}

	set fl [open "xsemi_new_funcs.tcl.menu2" a]
	set str ".type22.down.frame.functions.menu add command -label \"$name\" -command \"$name 2\""
	puts $fl $str
	if {[catch {close $fl} err]} {
	}

	set fl [open "xsemi_new_funcs.tcl.menu4" a]
	set str ".type42.down.frame.functions.menu add command -label \"$name\" -command \"$name 4\""
	puts $fl $str
	if {[catch {close $fl} err]} {
	}

	set fl [open "xsemi_new_funcs.tcl.menu3" a]
	set str ".type3.down.frame.functions.menu add command -label \"$name\" -command \"$name 3\""
	puts $fl $str
	if {[catch {close $fl} err]} {
	}

	set fl [open "xsemi_new_funcs.tcl.names" a]
	puts $fl $name
	if {[catch {close $fl} err]} {
	}

    }

}



proc callSize {var} {

    invokeDone
    set obj [".type$var.up.frame.right.l0.entry" get]
    puts "Size($obj);"
    puts "end"
}


proc drawCayley {var} {

    invokeDone
    set obj [".type$var.up.frame.right.l0.entry" get]
    puts "DrawRightCayleyGraph($obj);"
    puts "end"
}

proc drawDClasses {var} {

    invokeDone
    set obj [".type$var.up.frame.right.l0.entry" get]
    puts "DrawDClasses($obj);"
    puts "end"
}


proc drawDClassesT {var} {

    invokeDone
    set obj [".type$var.up.frame.right.l0.entry" get]
    puts "DrawDClasses($obj,1);"
    puts "end"
}


proc drawSchut {var} {

    invokeDone
    set obj [".type$var.up.frame.right.l0.entry" get]
    puts "DrawSchutzenbergerGraphs($obj);"
    puts "end"
}


proc invokeDone {} {
    global type

    if {$type == 1} {
	.type12.down.frame.done invoke
    } elseif {$type == 2} {
	.type22.down.frame.done invoke
    } elseif {$type == 4} {
	.type42.down.frame.done invoke
    }
}


#-----------------------------------------------------
#------ Destroy Windows ------------------------------
#-----------------------------------------------------

proc destroyWindows2 [] {

    if {[winfo exists .type1]} {
	destroy .type1
    }
    if {[winfo exists .type12]} {
	destroy .type12
    }
    if {[winfo exists .type2]} {
	destroy .type2
    }
    if {[winfo exists .type22]} {
	destroy .type22
    }
    if {[winfo exists .type3]} {
	destroy .type3
    }
    if {[winfo exists .type32]} {
	destroy .type32
    }
    if {[winfo exists .type4]} {
	destroy .type4
    }
    if {[winfo exists .type42]} {
	destroy .type42
    }
}


proc destroyWindows [] {

    if {[winfo exists .type12]} {
	destroy .type12
    }
    if {[winfo exists .type22]} {
	destroy .type22
    }
    if {[winfo exists .type32]} {
	destroy .type32
    }
    if {[winfo exists .type42]} {
	destroy .type42
    }
}


proc cancelS [] {
    puts "quit"
}



#-----------------------------------------------------
#------ Interface ------------------------------------
#-----------------------------------------------------

frame .up -relief groove -bd 1
frame .middle -relief groove -bd 1
frame .down -relief groove -bd 1
pack  .up .middle .down -expand 1 -fill both

frame .middle.frame
frame .down.frame
pack  .middle.frame .down.frame

label .up.label -text "Please choose the way to specify the semigroup"
pack  .up.label

radiobutton .middle.frame.rb1 -variable type -value 1 -text "Generators and relations" -justify left
.middle.frame.rb1 select
radiobutton .middle.frame.rb2 -variable type -value 2 -text "Transformations (total)" -justify left
radiobutton .middle.frame.rb4 -variable type -value 4 -text "Transformations (partial)" -justify left
radiobutton .middle.frame.rb3 -variable type -value 3 -text "Syntatic semigroup" -justify left
pack  .middle.frame.rb1 .middle.frame.rb2 .middle.frame.rb4 .middle.frame.rb3 -anchor w

button .down.frame.proceed -command proceed -text Proceed
button .down.frame.cancel -command cancelS -text Quit
pack   .down.frame.proceed .down.frame.cancel -side left -padx 2 -pady 2


#-----------------------------------------------------
#------ Bindings -------------------------------------
#-----------------------------------------------------

bind .up <Destroy> {.down.frame.cancel invoke}
bind .down.frame.proceed <Return> {.down.frame.proceed invoke}
bind .down.frame.cancel <Return> {.down.frame.cancel invoke}


#-----------------------------------------------------
#------ Finalization/Initialization ------------------
#-----------------------------------------------------

wm title . "XSemigroup - GAP Interface"

set generators {a b c d e f g h i j k l m n o p q r s t u v w x y z}
set varS 0

array set last_matrix []
set last_states -1
set last_nalph -1


set fl [open "xsemi_new_funcs.tcl.names" r]
set names [read $fl]
set new_funcs [split $names "\n"]
if {[catch {close $fl} err]} {
}



if {$argc > 0} {
    set var [lindex $argv 0]
    set monoid [lindex $argv 1]
    set type [lindex $argv 2]

    if {$type == 1} {
	set ngens [lindex $argv 3]
	set nrels [lindex $argv 4]

	.middle.frame.rb1 select
	.down.frame.proceed invoke
	.type1.up.frame.right.l0.entry insert 0 $var
	.type1.up.frame.right.l1.entry insert 0 $ngens
	.type1.up.frame.right.l2.entry insert 0 $nrels
	if {$monoid == 1} {
	    .type1.up.frame.right.l3.rb1 select
	} else {
	    .type1.up.frame.right.l3.rb2 select
	}
	proceedt1
	set j 1
	for {set i 1} {$i <= [expr 2*$nrels]} {incr i 2} {
	    if {[expr $j % 2] == 1} {
		set obj1 [format ".type12.frame.left.line%i.f1.e1" $j]
		set obj2 [format ".type12.frame.left.line%i.f3.e2" $j]
	    } else {
		set obj1 [format ".type12.frame.right.line%i.f1.e1" $j]
		set obj2 [format ".type12.frame.right.line%i.f3.e2" $j]
	    }
	    $obj1 insert 0 [lindex $argv [expr $i+4]]
	    $obj2 insert 0 [lindex $argv [expr $i+4+1]]
	    incr j 1
	}
    } elseif {$type == 2} {
	set ngens [lindex $argv 3]
	set dgtrs [lindex $argv 4]

	.middle.frame.rb2 select
	.down.frame.proceed invoke
	.type2.up.frame.right.l0.entry insert 0 $var
	.type2.up.frame.right.l1.entry insert 0 $ngens
	.type2.up.frame.right.l2.entry insert 0 $dgtrs
	if {$monoid == 1} {
	    .type2.up.frame.right.l3.rb1 select
	} else {
	    .type2.up.frame.right.l3.rb2 select
	}
	proceedt2
	for {set i 1} {$i <= $ngens} {incr i 1} {
	    for {set j 1} {$j <= $dgtrs} {incr j 1} {
		set obj [format ".type22.frame.line%i.right.entry%i" $i $j]
		set ind [expr $j + ($i - 1) * $dgtrs + 4]
		$obj insert 0 [lindex $argv $ind]
	    }
	}
    } elseif {$type == 4} {
	set ngens [lindex $argv 3]
	set dgtrs [lindex $argv 4]

	.middle.frame.rb4 select
	.down.frame.proceed invoke
	.type4.up.frame.right.l0.entry insert 0 $var
	.type4.up.frame.right.l1.entry insert 0 $ngens
	.type4.up.frame.right.l2.entry insert 0 $dgtrs
	if {$monoid == 1} {
	    .type4.up.frame.right.l3.rb1 select
	} else {
	    .type4.up.frame.right.l3.rb2 select
	}
	proceedt4
	for {set i 1} {$i <= $ngens} {incr i 1} {
	    for {set j 1} {$j <= $dgtrs} {incr j 1} {
		set obj [format ".type42.frame.line%i.right.entry%i" $i $j]
		set ind [expr $j + ($i - 1) * $dgtrs + 4]
		if {[lindex $argv $ind] != 0} {
		    $obj insert 0 [lindex $argv $ind]
		}
	    }
	}
    }
}

#--------------------------------------
# Read procs of user defined functions
#--------------------------------------
set fl [open "xsemi_new_funcs.tcl.procs" r]
set cmd [read $fl]
eval $cmd
if {[catch {close $fl} err]} {
}

