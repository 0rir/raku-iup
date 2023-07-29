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

    $mbox.set_attr("SIZECOL", "2");
    $mbox.set_attr("SIZELIN", "3");
    #  $mbox.set_attr("HOMOGENEOUSLIN", "Yes");
    #  $mbox.set_attr("HOMOGENEOUSCOL", "Yes");
    #  $mbox.set_attr("EXPANDCHILDREN", "HORIZONTAL");
    #  $mbox.set_attr("NORMALIZESIZE", "BOTH");
    #  $mbox.set_attr("NORMALIZESIZE", "HORIZONTAL");

    $mbox.set_attr("NUMDIV", "3");
    #  $mbox.set_attr("ORIENTATION", "VERTICAL");
    #  $mbox.set_attr("NUMDIV", "2");
    #  $mbox.set_attr("NUMDIV", "AUTO");

    $mbox.set_attr("ALIGNMENTLIN", "ACENTER");
    $mbox.set_attr("MARGIN", "10x10");
    $mbox.set_attr("GAPLIN", "5");
    $mbox.set_attr("GAPCOL", "5");

    my $dlg = $ih.dialog($ih.hbox($fr1));

    $dlg.set_attr("TITLE", "IupMultiBox Test", :copy);
    $dlg.set_attr("MARGIN", "10x10");
    $fr1.set_attr("MARGIN", "0x0");
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
