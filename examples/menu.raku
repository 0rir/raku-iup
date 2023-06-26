#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.c;
use lib $?FILE.IO.cleanup.parent(2).add("lib");

use IUP;

my $iup = IUP.new;

$iup.set-language("PORTUGUESE");

my @argv;
$iup.open;

my $ih = IUP::Handle.new;

my $item-open = $ih.item("Open", "");
$item-open.set-attr("KEY", "O");

my $item-save = $ih.item("Save", "");
$item-save.set-attribute("KEY", "S");

my $item-undo = $ih.item("Undo", "");
$item-undo.set-attribute("KEY", "U");
$item-undo.set-attribute("ACTIVE", "NO");

my $item-exit = $ih.item("Exit", "");
$item-exit.set-attribute("KEY", "x");
$item-exit.set-callback("ACTION", &exit-cb);

my $file-menu = $ih.menu(
    $item-open,
    $item-save,
    $ih.separator,
    $item-undo,
    $item-exit);

my $sub1-menu = $ih.submenu("File", $file-menu);

my $menu = $ih.menu($sub1-menu);

$menu.set-handle("mymenu");

my $canvas = $ih.canvas("");
my $dlg = $ih.dialog($canvas);

$dlg.set-attribute("MENU", "mymenu");

$dlg.set-attribute("TITLE", "IupMenu");
$dlg.set-attribute("SIZE", "200x100");

$dlg.show;

$iup.main-loop;

$iup.close;

exit;

sub exit-cb(-->Int) { IUP_CLOSE }
