#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.c;
use lib $?FILE.IO.cleanup.parent(2).add("lib");

use IUP;

sub MAIN() {

    my $iup = IUP.new;

    my @argv = ("Test");

    # Initializes IUP
    $iup.open(@argv);           # No argument necessary.

    my $ih = IUP::Handle.new();

    # Creates frame with a hbox with a label
    my $frame = $ih.frame(
            $ih.hbox(
                    $ih.fill(),
                    $ih.label(
"IupFrame Attributes:\nFGCOLOR = \"255 0 0\"\nSIZE = \"EIGHTHxEIGHTH\"\nTITLE = \"This is the frame\"\nMARGIN = \"10x10\""),
                        $ih.fill()
                    )
            ).set-attrs(
                FGCOLOR => "255 0 0",
                SIZE => "EIGHTHxEIGHTH",
                TITLE => "This is the frame",
                MARGIN => "10x10");
                # Sets frame's attributes

    # Creates dialog
    my $dlg = $ih.dialog($frame);
    $dlg.set-attr("TITLE", "IupFrame");

    # Shows dialog in the center of the screen
    $dlg.show;

    # Initializes IUP main loop
    $iup.main-loop;

    # Finishes IUP
    $iup.close;

    exit;
}
