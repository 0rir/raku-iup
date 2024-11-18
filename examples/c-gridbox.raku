#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6;
use lib 'lib';
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;
use IUP::Colors;

my ($iup, $ih);

sub GridBoxTest() {
    my $gbox;

    my $fr1 = $ih.frame(
            $gbox = $ih.gridbox(
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

    $gbox.set-attr("SIZECOL", "2");
    $gbox.set-attr("SIZELIN", "3");
    #  $gbox.set-attr("HOMOGENEOUSLIN", "Yes");
    #  $gbox.set-attr("HOMOGENEOUSCOL", "Yes");
    #  $gbox.set-attr("EXPANDCHILDREN", "HORIZONTAL");
    #  $gbox.set-attr("NORMALIZESIZE", "BOTH");
    #  $gbox.set-attr("NORMALIZESIZE", "HORIZONTAL");

    $gbox.set-attr("NUMDIV", "3");
    #  $gbox.set-attr("ORIENTATION", "VERTICAL");
    #  $gbox.set-attr("NUMDIV", "2");
    #  $gbox.set-attr("NUMDIV", "AUTO");

    $gbox.set-attr("ALIGNMENTLIN", "ACENTER");
    $gbox.set-attr("MARGIN", "10x10");
    $gbox.set-attr("GAPLIN", "5");
    $gbox.set-attr("GAPCOL", "5");

    my $dlg = $ih.dialog($ih.hbox($fr1));

    $dlg.set-attr("TITLE", "IupGridBox Test", :copy);
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
    GridBoxTest;
    $iup.main-loop;
    $iup.close;
}
