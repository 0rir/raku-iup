#!/usr/bin/env raku
# IupRadio Example in Raku from the C 
#
# Creates a dialog for the user to select his/her gender. 
# In this case, the radio element is essential to prevent the user
# from selecting both options. 

use IUP;

sub MAIN() {
    my $iup = IUP.new;
say 'A';
    $iup.open;
say 'A';
    my $ih = IUP::Handle.new;
say 'A';
    my $male   = $iup.toggle( "Male" );
say 'A';
    my $female = $iup.toggle( "Female");
say 'A';
    my $exclusive = $iup.radio(
        $iup.vbox( $male, $female,)
    );
    $male.set-handle( "male");
    $female.set-handle( "female");
    $exclusive.set-attr(  "VALUE", "female");
    $male.set-attr(   "TIP", "Two state button - Exclusive - RADIO");
    $female.set-attr( "TIP", "Two state button - Exclusive - RADIO");

    my $frame = $iup.frame( $exclusive);
    $frame.set-attr( :copy, "TITLE", "Gender");

    my $dialog = $iup.dialog(
        $iup.hbox( $iup.fill, $frame, $iup.fill),
    );

    $dialog.set-attr( :pre, "SIZE=140, TITLE=IupRadio, RESIZE=NO, MINBOX=NO, MAXBOX=NO");

    $dialog.show;
    $iup.main-loop;
    $iup.close;
}
