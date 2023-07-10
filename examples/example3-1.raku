#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use IUP;

multi MAIN ( ) {
    my $iup = IUP.new;
    $iup.open;

    my $multitext = $iup.text('');
    my $vbox = $iup.vbox( $multitext,);

    $multitext.set_attr( "MULTILINE", "YES");   # a MultiLine is this.
    $multitext.set_attr( "EXPAND", "YES");
    my $dlg = $iup.dialog($vbox);
    $dlg.set_attr( "TITLE", "Simple Notepad");
    $dlg.set_attr( "SIZE", "QUARTERxQUARTER");

    $dlg.show( IUP_CENTER, IUP_CENTER);
    $dlg.set_attr( "USERSIZE", '');

    $iup.main_loop();
    $iup.close();
}


