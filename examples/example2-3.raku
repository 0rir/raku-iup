#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.c;
use lib 'lib';
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;

sub MAIN ( ) {
    my $iup = IUP.new();
    $iup.open;

    my $button  = $iup.button( '&OK', '' );
    $button.set-callback("ACTION", &exit_callback);
    my $vbox  = $iup.vbox( $button );
    my $dlg = $iup.dialog( $vbox);
    $dlg.set-attr( "TITLE", "Hello World 3", :copy );

    $dlg.show( IUP_CENTER, IUP_CENTER);
    $iup.main-loop();
    $iup.close;
}

sub exit_callback() returns Int { return IUP_CLOSE; }

