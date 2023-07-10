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

    $multitext.sattr( "MULTILINE", "YES");
    $multitext.sattr( "EXPAND", "YES");
    my $dlg = $iup.dialog($vbox);
    $dlg.sattr( "TITLE", "Simple Notepad", :copy);
   $dlg.sattr( "SIZE", "QUARTERxQUARTER");

    $dlg.show( IUP_CENTER, IUP_CENTER);
    $dlg.sattr( "USERSIZE", '');

    $iup.main_loop();
    $iup.close();
}


