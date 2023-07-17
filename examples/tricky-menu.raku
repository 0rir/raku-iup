#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.c;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;

sub MAIN() {

    #my @data_Tecgraf = get-data_from_file("images/Tecgraf.txt");
    #my $pixmap = IUP::Pixmap.new();
    #my $imageTecgraf = $pixmap.load(@data_Tecgraf);

    my $iup = IUP.new;
    $iup.open;

    $iup.image-lib-open;
    my $dlg = menu-test;
    $iup.main-loop;
    $dlg.destroy;
    $iup.close;

    exit;
}

sub get-data-from-file($filename) {
    my @array;
    if (my $fh = open $filename, :r) {
        for $fh.lines -> $line {
            @array.push($line.split(/\D+/));
        }
    } else {
        say "Could not open '$filename'";
        exit;
    }
    return @array;
}

sub menu-test {

    my $ih = IUP::Handle.new;

    # Creates menu create
    my $menu-create = $ih.menu(
        $ih.item("Line", ""),
        $ih.item("Circle", ""),
        $ih.submenu("Triangle",
            $ih.menu(
                $ih.item("Equilateral", "").sattr("VALUE" => "ON"),
                $ih.item("Isoceles", ""),
                $ih.item("Scalenus", "")
            ).sattr('RADIO' => "YES")
        )
    );

    # File Menu
    my $menu-file = $ih.menu(
        $ih.item("Item with Image \tCtrl+M", ""),
        $ih.item("Toggle using &VALUE", "").sattr("VALUE" => "ON", "KEY" => "KcV"),
        $ih.item("Auto &Toggle Text", "").sattr("AUTOTOGGLE" => "YES", "VALUE" => "OFF"),
        $ih.item("Auto &Toggle Image", ""),
        $ih.item("Big Image", ""),
        $ih.separator,
        $ih.item("Exit (Destroy)", ""),
        $ih.item("Exit (Close)", "")
    );

    # Edit Menu
    my $menu-edit = $ih.menu(
        $ih.item("Active Next", "").set-attribute('IMAGE', "IUP_ArrowRight"),
        $ih.item("Rename Next", ""),
        $ih.item("Set Next Image", ""),
        $ih.item("Item && Acc\tCtrl+A", ""),
        $ih.separator,
        $ih.submenu("Create", $menu-create)
    );

    # Help Menu
    my $menu-help = $ih.menu(
        $ih.item("Append", ""),
        $ih.item("Insert", ""),
        $ih.item("Remove", ""),
        $ih.separator,
        $ih.item("Info", "").sattr('IMAGE' => "IUP_MessageInfo")
    );

    # Creates main menu with file menu
    my $menu = $ih.menu(
        $ih.submenu("Submenu", $menu-file),
        $ih.submenu("Edit", $menu-edit),
        $ih.submenu("Help", $menu-help),
        $ih.item("Item", "")
    );

    my $canvas = $ih.canvas("");
    my $dlg = $ih.dialog($canvas);
    $dlg.set_attribute_handle("MENU", $menu);
    $dlg.sattr(
        "TITLE" => "IupMenu Test",
        "SIZE"  => "QUARTERxQUARTER");

    # Shows dlg in the center of the screen */
    $dlg.show(IUP_CENTER, IUP_CENTER);

    return $dlg;
}

