#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.c;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;

sub MAIN ( ) {
    my $iup = IUP.new();
    $iup.open;

    my $label = $iup.label( "Hello world from IUP.");
    my $button  = $iup.button( '&OK', '' );
    $button.set_callback("ACTION", &exit_callback);
    my $vbox  = $iup.vbox( $label, $button );
    $vbox.set_attribute( 'ALIGNMENT', 'ACENTER');
    $vbox.set_attr( 'GAP', '30');
    $vbox.set_attr( 'MARGIN', '50x50');
    my $dlg = $iup.dialog( $vbox);
    $dlg.set_attribute( "TITLE", "Hello World 5");

    $dlg.show( IUP_CENTER, IUP_CENTER);
    $iup.main_loop();
    $iup.close; 
}

sub exit_callback() returns Int { return IUP_CLOSE; }

