#!/usr/bin/raku
# IupSubmenu: Example in Raku from the C
#  Creates a dialog with a menu with three submenus.
#  One of the submenus has a submenu, which has another submenu.

use IUP;
my $iup;
my $ih;

# Item help callback
# Shows a message saying that only Help and Exit items performs an operation
sub item_help_cb(-->Int){
    $iup.message("Warning", "Only Help & Exit items performs an operation");
  IUP_DEFAULT;
}

#  Item exit callback
#  Exits the program
sub item_exit_cb(-->Int){ IUP_CLOSE; }

# Main program
sub MAIN() {
    # Initializes IUP
    $iup = IUP.new;
    $iup.open;
    $ih = IUP::Handle.new;

    # Creates a multiline
    my $text = $iup.text;

    # Sets value of the text and turns on expand
    $text.set-attr(
        :pre, "VALUE = \"This text is here only to compose\", EXPAND = YES");

    # Creates items of menu file
    my $item_new   = $iup.item( "New");
    my $item_open  = $iup.item( "Open");
    my $item_close = $iup.item( "Close");
    my $item_exit  = $iup.item( "Exit", "item_exit_act");

    # Creates items of menu edit
    my $item_copy  = $iup.item( "Copy");
    my $item_paste = $iup.item( "Paste");

    # Creates items for menu triangle
    my $item_scalenus    = $iup.item( "Scalenus");
    my $item_isoceles    = $iup.item( "Isoceles");
    my $item_equilateral = $iup.item( "Equilateral");

    # Create menu triangle
    my $menu_triangle =
            $item_equilateral.menu( $item_isoceles, $item_scalenus);

    # Creates submenu triangle
    my $submenu_triangle = $ih.submenu( "Triangle", $menu_triangle);

    # Creates items for menu create
    my $item_line   = $iup.item( "Line");
    my $item_circle = $iup.item( "Circle");

    # Creates menu create
    my $menu_create = $ih.menu( $item_line, $item_circle, $submenu_triangle);

    # Creates submenu create
    my $submenu_create = $iup.submenu( "Create", $menu_create);

    # Creates items of menu help
    my $item_help = $iup.item( "Help", "item_help_act");

    # Creates three menus
    my $menu_file = $ih.menu(
        $item_new, $item_open, $item_close, $iup.separator, $item_exit);
    my $menu_edit = $ih.menu(
        $item_copy, $item_paste, $iup.separator, $submenu_create );
    my $menu_help = $ih.menu( $item_help);

    # Creates three submenus
    my $submenu_file = $ih.submenu( "File", $menu_file);
    my $submenu_edit = $ih.submenu( "Edit", $menu_edit);
    my $submenu_help = $ih.submenu( "Help", $menu_help);

    # Creates main menu with file menu
    my $menu = $ih.menu( $submenu_file, $submenu_edit, $submenu_help);

    # Registers callbacks
    $item_help.set-callback( "ACTION", &item_help_cb);
    $item_exit.set-callback( "ACTION", &item_exit_cb);

    # Associates handle "menu" with menu
    $menu.set-handle( "menu");

    # Creates dialog with a text
    my $dlg = $ih.dialog( $text);

    # Sets title and size of the dialog and associates a menu to it
    $dlg.set-attr( :pre,  "TITLE=\"IupSubmenu Example\", SIZE = QUARTERxEIGHTH, MENU = menu");

    # Shows dialog in the center of the screen
    $dlg.show(  IUP_CENTER, IUP_CENTER);

    $iup.main-loop;
    $iup.close;
}
