#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;

my @argv;

# initialize iup
my $iup = IUP.new;

$iup.image_lib_open;
$iup.open;

# create widgets and set their attributes
my $btn = $iup.button("&Ok", "");

$btn.set-callback("ACTION", &exit_callback);

$btn.set-attr("IMAGE", "IUP_ActionOk");
$btn.set-attr("EXPAND", "YES");
$btn.set-attr("TIP", "Exit button");

my $lbl = $iup.label("Hello, world!");

my $vb = $iup.vbox($lbl, $btn);
$vb.set-attr("MARGIN", "10x10");
$vb.set-attr("GAP", "10");
$vb.set-attr("ALIGNMENT", "ACENTER");

my $dlg = $iup.dialog($vb);
$dlg.set-attr("TITLE", "Hello");

# Map widgets and show dialog
$dlg.show();

# Wait for user interaction
$iup.main-loop;

# Clean up
$dlg.destroy;

$iup.close;

exit;

sub exit_callback() returns Int {
    return IUP_CLOSE;
}
