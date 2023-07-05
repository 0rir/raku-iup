#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use IUP;

multi MAIN ( ) {
    my $iup = IUP.new;
    $iup.open;
    my ( $file_menu, $item_exit, $item_open, $item_saveas);
    my ( $sub1_menu, $menu);

    my $multitext = $iup.text('');
    $multitext.set_attr( "MULTILINE", "YES");
    $multitext.set_attr( "EXPAND", "YES");

    $item_open = $iup.item( "Open", '');
    $item_saveas = $iup.item( "Save As", '');
    $item_exit = $iup.item( "Exit", '');
    $item_exit.set_callback( "ACTION", &exit_callback);

    $file_menu = $iup.menu(
        $item_open,
        $item_saveas,
        $iup.separator(),
        $item_exit,
    );

    $sub1_menu = $iup.submenu("File", $file_menu); 
    $menu = $iup.menu( $sub1_menu);

    my $vbox = $iup.vbox( $multitext,);

            $multitext.set_attr( "MULTILINE", "YES");
            $multitext.set_attr( "EXPAND", "YES");

    my $dlg = $iup.dialog($vbox);
    $dlg.set_attribute_handle( "MENU", $menu);
    $dlg.set_attr( "TITLE", "Simple Notepad");
    $dlg.set_attr( "SIZE", "QUARTERxQUARTER");

    $dlg.show( IUP_CENTER, IUP_CENTER);
    $dlg.set_attr( "USERSIZE", '');

    $iup.main_loop();
    $iup.close();
}

sub exit_callback() returns Int { return IUP_CLOSE; }

