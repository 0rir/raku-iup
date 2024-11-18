#!/usr/bin/env raku
# IupMenu: Example in Raku from th C
#   Creates a dialog with a menu with two submenus.

use lib 'lib';
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;

sub exit_cb(-->Int) { IUP_CLOSE }

sub MAIN() {

    my $iup = IUP.new;
    $iup.open;
    my $ih = IUP::Handle.new;

    my $item_open = $iup.item( "Open", '');
    $item_open.set-attr( "KEY", "O");

    my $item_save = $iup.item( "Save", '');
    $item_save.set-attr(  "KEY", "S");


    my $item_undo = $iup.item( "Undo", '');
    $item_undo.set-attr(  "KEY", "U");
    $item_undo.set-attr(  "ACTIVE", "NO");

    my $item_exit = $iup.item( "Exit", '');
    $item_exit.set-attr(  "KEY", "x");
    $item_exit.set-callback(  "ACTION", &exit_cb);

    my $file_menu = $item_open.menu(
                      $item_save,
                      $iup.separator,
                      $item_undo,
                      $item_exit,
    );


    my $sub1_menu = $iup.submenu( "File", $file_menu);

    my $menu = $ih.menu( $sub1_menu );
    $menu.set-handle( "mymenu", );
    my $dlg = $iup.dialog($iup.canvas(""));
    $dlg.set-attr( :copy, "MENU", "mymenu");
    $dlg.set-attr( :copy, "TITLE", "IupMenu");
    $dlg.set-attr( :copy, "SIZE", "QUARTERxQUARTER");

    $dlg.show;
    $iup.main-loop;
    $iup.close;
}

