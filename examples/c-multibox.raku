#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;
use IUP::Colors;

=begin comment
This is not from upstream, but is a close variant of c-gridbox.raku.
It does not showcase the multibox well.
=end comment

my ($iup, $ih);

sub MultiBoxTest() {
    my $mbox;

    my $fr1 = $ih.frame(
            $mbox = $ih.multibox(
                    $ih.label();  # XXX C version uses IupSetAttributes( "")???
                    $ih.label("col1").set-attr("FONTSTYLE" => "Bold"),
                    $ih.label("col2").set-attr("FONTSTYLE" => "Bold"),

                    $ih.label().set-attr("FONTSTYLE" => "Bold"),
                    $ih.label().set-attr("XSIZE" => "50x12"),
                    $ih.button("but").set-attr("XSIZE" => "50", 'FGCOLOR' => Red),

                    $ih.label("lin2").set-attr("FONTSTYLE" => "Bold"),
                    $ih.label("label").set-attr("XSIZE" => "x12"),
                    $ih.button("button").set-attr("XEXPAND" => "Horizontal"),
                    $ih.label("lin3").set-attr("FONTSTYLE" => "Bold"),
                    $ih.label("label large").set-attr("XSIZE" => "x12"),
                    $ih.button("button large"),
                    ),
            );

    $mbox.set-attr("SIZECOL", "2");
    $mbox.set-attr("SIZELIN", "3");
    #  $mbox.set-attr("HOMOGENEOUSLIN", "Yes");
    #  $mbox.set-attr("HOMOGENEOUSCOL", "Yes");
    #  $mbox.set-attr("EXPANDCHILDREN", "HORIZONTAL");
    #  $mbox.set-attr("NORMALIZESIZE", "BOTH");
    #  $mbox.set-attr("NORMALIZESIZE", "HORIZONTAL");

    $mbox.set-attr("NUMDIV", "3");
    #  $mbox.set-attr("ORIENTATION", "VERTICAL");
    #  $mbox.set-attr("NUMDIV", "2");
    #  $mbox.set-attr("NUMDIV", "AUTO");

    $mbox.set-attr("ALIGNMENTLIN", "ACENTER");
    $mbox.set-attr("MARGIN", "10x10");
    $mbox.set-attr("GAPLIN", "5");
    $mbox.set-attr("GAPCOL", "5");

    my $dlg = $ih.dialog($ih.hbox($fr1));

    $dlg.set-attr("TITLE", "IupMultiBox Test", :copy);
    $dlg.set-attr("MARGIN", "10x10");
    $fr1.set-attr("MARGIN", "0x0");
    #  avoid attribute propagation   XXX ???

    # Shows dlg in the center of the screen
    $dlg.show(IUP_CENTER, IUP_CENTER);
}

sub MAIN() {
    $iup = IUP.new;
    $iup.open;
    $ih = IUP::Handle.new;
    MultiBoxTest;
    $iup.main-loop;
    $iup.close;
}
