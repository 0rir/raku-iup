#!/usr/bin/env raku
# IupSeparator: Example in Raku from C
#   Creates a dialog with a menu and some items. A IupSeparator is used
#   to separate the menu items.
use lib 'lib';
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;
use IUP::Colors;

my $iup;
my $ih;

#  Show message
#  Shows a message saying that the this item performs no operation
sub show_message( -->Int) {
  $ih.message( "Warning", "This item performs no operation\n"
                          ~"It is here only to compose");
  IUP_DEFAULT;
}

# Item new callback
sub item_new_cb( -->Int) { show_message }

#  Item open callback
sub item_open_cb (-->Int) { show_message }

# Item close callback
sub item_close_cb (-->Int) { show_message }

# Item page setup callback
sub item_pagesetup_cb ( -->Int) { show_message }

#* Item print callback
sub item_print_cb( -->Int) { show_message }

#* Item exit callback
sub item_exit_cb( -->Int) { IUP_CLOSE }


sub MAIN() {

    # Initializes IUP
    $iup = IUP.new;
    $iup.open;
    $ih = IUP::Handle.new;

    # Program begin

    # Creates a text
    my $text = $iup.text;

    # Sets value of the text and turns on expand
    $text.set-attr( "VALUE", "This text is here only to compose");
    $text.set-attr( "EXPAND" => "HORIZONTAL");

    # Creates six items
    my $item_new        = $iup.item( "New");
    my $item_open       = $iup.item( "Open");
    my $item_close      = $iup.item( "Close");
    my $item_pagesetup  = $iup.item( "Page Setup");
    my $item_print      = $iup.item( "Page Setup Again");
    my $item_exit       = $iup.item( "Exit");

    # Registers callbacks
    $item_new.set-callback(       "ACTION", &item_new_cb);
    $item_open.set-callback(      "ACTION", &item_open_cb);
    $item_close.set-callback(     "ACTION", &item_close_cb);
    $item_pagesetup.set-callback( "ACTION", &item_pagesetup_cb);
    $item_print.set-callback(     "ACTION", &item_print_cb);
    $item_exit.set-callback(      "ACTION", &item_exit_cb);

    # Creates file menu
    my $menu_file = $ih.menu( $item_new,$item_open, $item_close,
            $ih.separator,
            $item_pagesetup, $item_print,
            $iup.separator,
            $item_exit);

    # Creates file submenu
    my $submenu_file = $ih.submenu( "File", $menu_file );

    # Creates main menu with file menu
    my $menu = $ih.menu( $submenu_file);

    # Associates handle "menu" with menu
    $menu.set-handle( "menu");

    # Creates dialog with a text
    my $dlg = $iup.dialog($text);

    # Sets title and size of the dialog and associates a menu to it
    $dlg.set-attr( :copy, "TITLE" => "IupSeparator Example");
    $dlg.set-attr( "SIZE" => "QUARTERxEIGHTH", "MENU" => "menu");

    # Shows dialog in the center of the screen
    $dlg.show( IUP_CENTER, IUP_CENTER);

    $iup.main-loop;
    $iup.close;
}
