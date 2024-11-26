#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.c;
use lib 'lib';
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;

# Creates a dialog with buttons placed side by side, with the purpose of
# showing the organization possibilities of elements inside an hbox. The
# "ALIGNMENT" attribute is explored in all its possibilities to obtain
# the given effect.

sub MAIN() {

    my $iup = IUP.new;

    my @argv;

    # Initializes IUP
    $iup.open;

    my $ih = IUP::Handle.new;


    # Creates frame with three top aligned buttons */
    my $hbox;
    my $frame1 = $ih.frame(
        $hbox = $ih.hbox(
            $ih.fill(),
            $ih.button("1", "").set-attr("SIZE" => "30x30"),
            $ih.button("2", "").set-attr("SIZE" => "30x40"),
            $ih.button("3", "").set-attr("SIZE" => "30x50"),
            $ih.fill(),
            )
        );
    # Sets hbox's alignment, gap and size
    $hbox.set-attr("ALIGNMENT" => "ATOP", GAP => "10", "SIZE" => "200");
    $frame1.set-attr("TITLE", "ALIGNMENT=ATOP, GAP=10, SIZE=200", :copy );

    # Creates frame with three buttons */
    my $frame2 = $ih.frame(
        $ih.hbox(
            $ih.fill(),
            $ih.button("1", "").set-attr("SIZE" => "30x30"),
            $ih.button("2", "").set-attr("SIZE" => "30x40"),
            $ih.button("3", "").set-attr("SIZE" => "30x50"),
            $ih.fill().set-attr("ALIGNMENT", "ACENTER", 'GAP', "20")
            # Sets hbox's alignment and gap
        )
    );
    $frame2.set_attr("TITLE", "ALIGNMENT=ACENTER, GAP=20");

    # Creates frame with three bottom aligned buttons
    my $frame3 = $ih.frame(
        $ih.hbox(
            $ih.fill(),
            $ih.button("1", "").set-attr("SIZE" => "30x30"),
            $ih.button("2", "").set-attr("SIZE" => "30x40"),
            $ih.button("3", "").set-attr("SIZE" => "30x50"),
            $ih.fill.set-attr("ALIGNMENT" => "ABOTTOM", "SIZE" => "150")
            # Sets hbox's alignment and size
        )
    );
    $frame3.set-attr( "TITLE", "ALIGNMENT=ABOTTOM, SIZE=150");

    #
    # Creates dialog with the three frames
    #
    my $dialog = $ih.dialog(
        $ih.vbox(
            $frame1,
            $frame2,
            $frame3
        )
    );
    $dialog.set-attr( "TITLE", "IupHbox");
    # Sets dialog's title

    $dialog.show(IUP_CENTER, IUP_CENTER);
    # Shows dialog in the center of the screen

    # Initializes IUP main loop
    $iup.main-loop;

    # Finishes IUP
    $iup.close;

    exit;
}
