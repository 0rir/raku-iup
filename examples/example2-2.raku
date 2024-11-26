#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.c;
use lib 'lib';
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;

sub MAIN ( ) {
    my $iup = IUP.new();
    $iup.open;
    my $label  = $iup.label( 'Hello world from IUP.');
    my $dlg = $iup.dialog(
        $iup.vbox($label)
    );
    $dlg.set-attr( "TITLE", "Hello World 2", :copy );

    $dlg.show( IUP_CENTER, IUP_CENTER);
    $iup.main-loop();
    $iup.close;
}
