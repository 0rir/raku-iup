#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.c;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;

sub MAIN ( ) {
    my $iup = IUP.new();
    $iup.open;

    my $button  = $iup.button( '&OK', '' );
    $button.set_callback("ACTION", &exit_callback);
    my $vbox  = $iup.vbox( $button );
    my $dlg = $iup.dialog( $vbox);
    $dlg.sattr( "TITLE", "Hello World 3", :copy );

    $dlg.show( IUP_CENTER, IUP_CENTER);
    $iup.main_loop();
    $iup.close; 
}

sub exit_callback() returns Int { return IUP_CLOSE; }

