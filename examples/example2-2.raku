#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.c;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;

sub MAIN ( ) {
    my $iup = IUP.new();
    $iup.open;
    my $label  = $iup.label( 'Hello world from IUP.');
    my $dlg = $iup.dialog(
        $iup.vbox($label)
    );
    $dlg.set_attribute( "TITLE", "Hello World 2");

    $dlg.show( IUP_CENTER, IUP_CENTER);
    $iup.main_loop();
    $iup.close; 
}