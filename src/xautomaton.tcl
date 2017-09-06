
#-----------------------------------------------------
#------ Procedures -----------------------------------
#-----------------------------------------------------
proc addFunc [] {

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

    button .addfunc.frame.bot.ok -command "doneaddFunc" -text Ok
    pack   .addfunc.frame.bot.ok -padx 2 -pady 2

    bind .addfunc.frame.top.right.entry <Return> {.addfunc.frame.bot.ok invoke}
    bind .addfunc.frame.bot.ok <Return> {.addfunc.frame.bot.ok invoke}

    focus .addfunc.frame.top.right.entry
}

proc doneaddFunc [] {
    global new_funcs var


    set name   [.addfunc.frame.top.right.entry get]

    set len [string length $name]

    for {set i 0} {$i < $len} {incr i} {
	set c [string index $name $i]
	if {$c == " " } {
	    error "The function's name must contain no spaces"
	    return
}
}

    set fl [open "xaut_new_funcs.tcl.procs" a]
    set str "proc $name \[\] {\nglobal var\nfinishfunc\nputs \"$name"
    append str "(\$var);\"\nputs \"end\"   \n}\n"
    puts $fl $str
    if {[catch {close $fl} err]} {
}
    eval $str

    set fl [open "xaut_new_funcs.tcl.menu" a]
    set str ".matrix.down.functions.menu add command -label \"$name\" -command \"$name\""
    puts $fl $str
    if {[catch {close $fl} err]} {
}

	eval $str

    set fl [open "xaut_new_funcs.tcl.names" a]
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


proc remFunc [] {
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


    button .remfunc.frame.bot.ok -command "doneremFunc" -text Ok
    pack   .remfunc.frame.bot.ok -padx 2 -pady 2

    bind .remfunc.frame.bot.ok <Return> {.remfunc.frame.bot.ok invoke}

}


proc doneremFunc [] {
    global new_funcs

    set inds   [.remfunc.frame.top.listbox curselection]

    foreach {i} $inds {
	lset new_funcs $i ""
	set rind [expr 9 + $i]
    set str ".matrix.down.functions.menu "
    append str "delete $rind"

	eval $str
}
    set new_list []
    foreach {name} $new_funcs {
	if {$name != ""} {
	    lappend new_list $name
}
}
    set new_funcs $new_list

    rebuild_new_funcs

    destroy .remfunc
}

proc rebuild_new_funcs [] {
    global new_funcs

    set fl [open "xaut_new_funcs.tcl.names" w]
    close $fl
    set fl [open "xaut_new_funcs.tcl.procs" w]
    close $fl
    set fl [open "xaut_new_funcs.tcl.menu" w]
    close $fl


    foreach {name} $new_funcs {

    set fl [open "xaut_new_funcs.tcl.procs" a]
    set str "proc $name \[\] {\nglobal var\nfinishfunc\nputs \"$name"
    append str "(\$var);\"\nputs \"end\"   \n}\n"


	puts $fl $str
	if {[catch {close $fl} err]} {
}
	eval $str

	set fl [open "xaut_new_funcs.tcl.menu" a]
	set str ".matrix.down.functions.menu add command -label \"$name\" -command \"$name\""
	puts $fl $str
	if {[catch {close $fl} err]} {
}


	set fl [open "xaut_new_funcs.tcl.names" a]
	puts $fl $name
	if {[catch {close $fl} err]} {
}

}

}

#-----------------------------------------------------
proc matrix [] {
    global last_states last_nalph var states alph nalph flag_alph
    if {[winfo exists .matrix]} {
	.matrix.down.cancel invoke
    }

    set var [.up.var.down.entry get]
    set states [.up.states.down.entry get]
    set alph [.up.alph.down.entry get]

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

    displayMatrix
}


proc displayMatrix [] {
    global last_matrix last_states last_nalph var states alph nalph flag_alph

    frame .matrix
    frame .matrix.up
    frame .matrix.down
    pack .matrix .matrix.up .matrix.down
    for {set a 1} {$a <= $nalph} {incr a 1} {
	set lab [format "label%i" $a]
	set cmd "label .matrix.up."
	append cmd $lab
	eval $cmd
	set cmd "pack .matrix.up."
	append cmd $lab
	eval $cmd
	set lcmd "pack "
	for {set q 1} {$q <= $states} {incr q 1} {
	    set box [format "box%i%i" $a $q]
	    set cmd "entry .matrix.up."
	    append cmd $lab "." $box " -width 5"
	    eval $cmd
	    append lcmd ".matrix.up." $lab "." $box " "
	}
	append lcmd "-side left"
	eval $lcmd
    }

    set list [array get last_matrix]
    if {!($list == [])} {
	for {set a 1} {$a <= $nalph} {incr a 1} {
	    set lab [format ".matrix.up.label%i" $a]
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


    menubutton .matrix.down.functions -text Functions -menu .matrix.down.functions.menu -takefocus 1

    button .matrix.down.view -text View -command "view $var $states $alph $nalph $flag_alph"
    button .matrix.down.ok -text Ok -command "finish $var $states $alph $nalph $flag_alph"
    button .matrix.down.clear -text Clear -command clearMatrix
    button .matrix.down.cancel -text Cancel -command destroyMatrix
    pack .matrix.down.functions .matrix.down.view .matrix.down.ok .matrix.down.clear .matrix.down.cancel -side left

    menu .matrix.down.functions.menu

    .matrix.down.functions.menu add command -label "Add a function to this menu" -command "addFunc"
	.matrix.down.functions.menu add command -label "Remove an added function" -command "remFunc"

    .matrix.down.functions.menu add separator


    .matrix.down.functions.menu add command -label "Get rational expression" -command "getRatExp $var $states $alph $nalph $flag_alph"
    .matrix.down.functions.menu add command -label "View minimalized automaton" -command "viewMinAut $var $states $alph $nalph $flag_alph"
    .matrix.down.functions.menu add command -label "Edit minimalized automaton" -command "editMinAut $var $states $alph $nalph $flag_alph"
    .matrix.down.functions.menu add command -label "Transition semigroup" -command "transitionSemigroup $var $states $alph $nalph $flag_alph"

    .matrix.down.functions.menu add separator


set fl [open "xaut_new_funcs.tcl.menu" r]
    set cmd [read $fl]
    eval $cmd
    if {[catch {close $fl} err]} {
}


    for {set a 1} {$a <= $nalph} {incr a 1} {
	set lab [format "bind .matrix.up.label%i" $a]
	for {set q 1} {$q <= $states} {incr q 1} {
	    set box [format "%s.box%i%i %s" $lab $a $q {<Return> {.matrix.down.ok invoke}}]
	    eval $box
	}
    }

    bind .matrix.down.view   <Return> {.matrix.down.view invoke}
    bind .matrix.down.ok     <Return> {.matrix.down.ok invoke}
    bind .matrix.down.clear  <Return> {.matrix.down.clear invoke}
    bind .matrix.down.cancel <Return> {.matrix.down.cancel invoke}
    focus .matrix.up.label1.box11
}


proc finish {var states alph nalph flag_alph} {
    set str "$var:="
    append str [getAutomaton $var $states $alph $nalph $flag_alph] ";"
    puts $str
    puts "end"
    destroyMatrix
}


proc finishfunc [] {
	global var states alph nalph flag_alph
    set str "$var:="
    append str [getAutomaton $var $states $alph $nalph $flag_alph] ";"
    puts $str
    puts "end"
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
    puts "quit"
}

proc destroyMatrix [] {
    global last_matrix last_states last_nalph

    set list []
    set i 1
    for {set a 1} {$a <= $last_nalph} {incr a 1} {
	set lab [format ".matrix.up.label%i" $a]
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
    destroy .matrix
    focus .up.var.down.entry
}


proc clearMatrix [] {
    global last_matrix last_states last_nalph

    array set last_matrix []
    set last_states -1
    set last_nalph -1
    .down.matrix invoke
}



proc testAut {states nalph} {
    global type

    for {set a 1} {$a <= $nalph} {incr a 1} {
	set lab [format ".matrix.up.label%i" $a]
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
	    set lab [format ".matrix.up.label%i" $a]
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
	    set lab [format ".matrix.up.label%i" $a]
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


    set ini [.up.ini.down.entry get]
    set fin [.up.fin.down.entry get]


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

frame .up -relief groove -bd 1
frame .down
pack .up
pack .down

frame .up.var -relief groove -bd 1
frame .up.type -relief groove -bd 1
frame .up.states -relief groove -bd 1
frame .up.alph -relief groove -bd 1
frame .up.ini -relief groove -bd 1
frame .up.fin -relief groove -bd 1
pack .up.var .up.type .up.states .up.alph .up.ini .up.fin -side left -anchor n -expand yes -fill y


frame .up.var.up
frame .up.var.down
frame .up.type.up
frame .up.type.down
frame .up.states.up
frame .up.states.down
frame .up.alph.up
frame .up.alph.down
frame .up.ini.up
frame .up.ini.down
frame .up.fin.up
frame .up.fin.down
pack .up.var.up   .up.type.up   .up.states.up   .up.alph.up   .up.ini.up   .up.fin.up   -anchor n
pack .up.var.down .up.type.down .up.states.down .up.alph.down .up.ini.down .up.fin.down -anchor n -expand yes -fill y


label .up.var.up.label -text "Var"
label .up.type.up.label -text "Type"
label .up.states.up.label -text "States"
label .up.alph.up.label -text "Alphabet"
label .up.ini.up.label -text "Initial"
label .up.fin.up.label -text "Final"
pack .up.var.up.label .up.type.up.label .up.states.up.label .up.alph.up.label .up.ini.up.label .up.fin.up.label


entry .up.var.down.entry -width 6
pack .up.var.down.entry

radiobutton .up.type.down.rb1 -variable type -value det -text det -justify left
.up.type.down.rb1 select
radiobutton .up.type.down.rb2 -variable type -value nondet -text nondet -justify left
radiobutton .up.type.down.rb3 -variable type -value epsilon -text epsilon -justify left
pack .up.type.down.rb1 .up.type.down.rb2 .up.type.down.rb3 -anchor w

entry .up.states.down.entry -width 6
pack .up.states.down.entry

entry .up.alph.down.entry -width 16
pack .up.alph.down.entry

entry .up.ini.down.entry -width 16
pack .up.ini.down.entry

entry .up.fin.down.entry -width 16
pack .up.fin.down.entry


#-----------------------------------------------------
#------ Down -----------------------------------------
#-----------------------------------------------------

button .down.matrix -command matrix -text "Transition Matrix"
button .down.cancel -command cancel -text Quit
pack .down.matrix .down.cancel -side left


#-----------------------------------------------------
#------ Bindings -------------------------------------
#-----------------------------------------------------

bind .up.var.up.label <Destroy> {.down.cancel invoke}

bind .down.matrix <Return> {.down.matrix invoke}
bind .down.cancel <Return> {.down.cancel invoke}

bind .up.var.down.entry    <KeyPress-Return> {.down.matrix invoke}
bind .up.states.down.entry <KeyPress-Return> {.down.matrix invoke}
bind .up.alph.down.entry   <KeyPress-Return> {.down.matrix invoke}
bind .up.ini.down.entry    <KeyPress-Return> {.down.matrix invoke}
bind .up.fin.down.entry    <KeyPress-Return> {.down.matrix invoke}

bind .       <Control-q> {.down.cancel invoke}


#-----------------------------------------------------
#------ Finalization/Initialization ------------------
#-----------------------------------------------------

focus .up.var.down.entry
wm title . "XAutomaton - GAP Interface"
array set last_matrix []
set last_states -1
set last_nalph -1

#---------------------------
#---- Globals --------------
#---------------------------
set var 0
set states 0
set alph 0
set nalph 0
set flag_alph 0
#---------------------------


set fl [open "xaut_new_funcs.tcl.names" r]
set names [read $fl]
set new_funcs [split $names "\n"]
if {[catch {close $fl} err]} {
}


#-----------------------------------------------------
#------ Process Arguments ----------------------------
#-----------------------------------------------------

if {$argc > 0} {
    set var [lindex $argv 0]
    set type [lindex $argv 1]
    set states [lindex $argv 2]
    set alph [lindex $argv 3]
    set ini [lindex $argv 4]
    set fin [lindex $argv 5]

    .up.var.down.entry insert 0 $var

    if {$type == "det"} {
	.up.type.down.rb1 select
    } elseif {$type == "nondet"} {
	.up.type.down.rb2 select
    } else {
	.up.type.down.rb3 select
    }

    .up.states.down.entry insert 0 $states
    .up.alph.down.entry   insert 0 $alph

    if {[string is integer $alph]} {
	set nalph $alph
	set flag_alph 0
    } else {
	set len [string length $alph]
	incr len -1
	incr len -1
	set nalph $len
	set flag_alph 1
    }


    if {! ($ini == -1) && !($ini == "")} {
	.up.ini.down.entry   insert 0 [lindex $argv 4]
    }
    if {! ($fin == -1) && !($fin == "")} {
	.up.fin.down.entry   insert 0 [lindex $argv 5]
    }


    displayMatrix


    for {set a 1} {$a <= $nalph} {incr a 1} {
	set lab [format ".matrix.up.label%i" $a]
	for {set q 1} {$q <= $states} {incr q 1} {
	    set box [format ".box%i%i" $a $q]
	    set cmd ""
	    set i [expr ($a-1)*$states + $q + 5]
	    if {! ([lindex $argv $i] == "")} {
		append cmd $lab $box " insert 0 " [lindex $argv $i]
		eval $cmd
	    }
	}
    }
}


#--------------------------------------
# Read procs of user defined functions
#--------------------------------------
set fl [open "xaut_new_funcs.tcl.procs" r]
set cmd [read $fl]
eval $cmd
if {[catch {close $fl} err]} {
}

