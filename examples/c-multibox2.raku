#!/usr/bin/env raku
use v6;
use lib 'lib';
use lib $?FILE.IO.cleanup.parent(2).add("lib");

use IUP;

=begin comment
This is not from upstream, but is a close variant of c-gridbox2.raku.
XXX doesn't showcase the multibox well.
=end comment

sub fnSrcFile(-->Int) { IUP_DEFAULT }
sub fnDstFile(-->Int) { IUP_DEFAULT }
sub fnBtnOk(-->Int)   { IUP_DEFAULT }
sub fnBtnQuit(-->Int) { IUP_CLOSE   }

sub MAIN() {
    my (  $dlg, $mbox,
          $lbl1, $lbl2, $txt1, $btn1,
          $lbl3, $lbl4, $txt2, $btn2,
          $lbl5, $lbl6, $btn3, $btn4);

    my $iup = IUP.new;
    $iup.open;

    $iup.set-global("GLOBALLAYOUTDLGKEY", "Yes");   # interesting!!

    $lbl1 = $iup.label("SOURCE FILE");
    $lbl2 = $iup.label(":");
    $lbl3 = $iup.label("DST DIR");
    $lbl4 = $iup.label(":");
    $txt1 = $iup.text();
    $txt1.set-attr("RASTERSIZE", "125");
    $txt1.set-attr("MULTILINE", "NO");
    $txt2 = $iup.text;
    $txt2.set-attr("RASTERSIZE", "125");
    $txt2.set-attr("MULTILINE", "NO");
    $btn1 = $iup.button("SRC", '');
    $btn1.set-callback("ACTION", &fnSrcFile);
    $btn2 = $iup.button("DST", '');
    $btn2.set-callback("ACTION", &fnDstFile);
    $lbl5 = $iup.label("");
    $lbl6 = $iup.label("");
    $btn3 = $iup.button("OK", '');
    $btn3.set-callback("ACTION", &fnBtnOk);
    $btn4 = $iup.button("QUIT", '');
    $btn4.set-callback("ACTION", &fnBtnQuit);

    $mbox = $iup.multibox(   $lbl1, $lbl2, $txt1, $btn1,
                            $lbl3, $lbl4, $txt2, $btn2,
                            $lbl5, $lbl6, $btn3, $btn4,
    );

    $mbox.set-attr("ORIENTATION", "HORIZONTAL");
    $mbox.set-attr("NUMDIV", "4");
    # $mbox.set-attr("SIZELIN","0");
    # $mbox.set-attr("SIZECOL","2");
    $mbox.set-attr("SIZELIN", "-1");
    $mbox.set-attr("SIZECOL", "-1");
    $mbox.set-attr("MARGIN", "30x30");
    $mbox.set-attr("GAPCOL", "30");
    $mbox.set-attr("GAPLIN", "30");
    $mbox.set-attr("ALIGNMENTLIN", "ACENTER");
    $mbox.set-attr("ALIGNMENTCOL", "ARIGHT");
    # $mbox.set-attr( "ALIGNMENTLIN", "ATOP");
    # $mbox.set-attr( "ALIGNMENTCOL", "ALEFT");

    $dlg = $iup.dialog($mbox);
    $dlg.set-attr("TITLE", "Hello World", :copy);
    $dlg.show(IUP_CENTER, IUP_CENTER);

    $iup.main-loop;
    $iup.close;
}
