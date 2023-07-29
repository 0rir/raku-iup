#!/usr/bin/env raku
# IupVbox Example in Raku from C 
# Creates a dialog with buttons placed one above the other, 
# showing the organization possibilities of the elements inside a vbox. 
# The "ALIGNMENT" attribute is explored in all its possibilities to obtain
# the effects. The attributes "GAP", "MARGIN" and "SIZE" are also tested. 

use IUP;

# Main program 
sub MAIN() {
    my $iup = IUP.new;
    $iup.open;
    my $ih = IUP::Handle.new;

    # Creates frame 1 
    my $frm_1 = $ih.frame(
        $ih.hbox(
            $ih.fill,
            $ih.vbox(
                $ih.button("1", "").set-attr( "SIZE", "20x30"),
                $ih.button("2", "").set-attr( "SIZE", "30x30"),
                $ih.button("3", "").set-attr( "SIZE", "40x30"),
            ).set-attr( :pre, "ALIGNMENT = ALEFT, GAP = 10"),
            $ih.fill,
        )
    ).set-attr( :copy, "TITLE", "ALIGNMENT = ALEFT, GAP = 10");

    # Creates frame 2 
    my $frm_2 = $iup.frame(
        $ih.hbox(
            $ih.fill,
            $iup.vbox(
                $iup.button("1", "").set-attr(  "SIZE", "20x30"),
                $iup.button("2", "").set-attr(  "SIZE", "30x30"),
                $iup.button("3", "").set-attr(  "SIZE", "40x30"),
            ).set-attr( :pre,  "ALIGNMENT = ACENTER, MARGIN = 15"),
            $ih.fill,
        )
    ).set-attr( :copy, "TITLE", "ALIGNMENT = ACENTER, MARGIN = 15");

    # Creates frame 3 
    my $frm_3 = $iup.frame(
        $ih.hbox(
            $ih.fill,
            $iup.vbox(
                $iup.button("1", "").set-attr(  "SIZE", "20x30"),
                $iup.button("2", "").set-attr(  "SIZE", "30x30"),
                $iup.button("3", "").set-attr(  "SIZE", "40x30"),
            ).set-attr( :pre,  "ALIGNMENT = ARIGHT, SIZE = 20");
            $ih.fill,
        )
    ).set-attr( :copy, "TITLE", "ALIGNMENT = ARIGHT, SIZE = 20");

    # Creates dialog with three frames inside a vbox
    my $dlg = $iup.dialog(
        $ih.vbox(
            $frm_1, $frm_2, $frm_3,
        )
    ).set-attr( :pre,  "TITLE = \"IupVbox Example\", SIZE = QUARTER");

    # Shows dialog in the center of the screen 
    $dlg.show(  IUP_CENTER, IUP_CENTER);

    $iup.main-loop;
    $iup.close;  
}
