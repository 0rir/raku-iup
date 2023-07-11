#!/usr/bin/env raku
use v6;
use IUP;

sub fnSrcFile(-->Int) { IUP_DEFAULT }
sub fnDstFile(-->Int) { IUP_DEFAULT }
sub fnBtnOk(-->Int)   { IUP_DEFAULT }
sub fnBtnQuit(-->Int) { IUP_CLOSE   }

sub MAIN() {
    my (  $dlg, $gbox,
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
    $txt1.sattr("RASTERSIZE", "125");
    $txt1.sattr("MULTILINE", "NO");
    $txt2 = $iup.text;
    $txt2.sattr("RASTERSIZE", "125");
    $txt2.sattr("MULTILINE", "NO");
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

    $gbox = $iup.gridbox(   $lbl1, $lbl2, $txt1, $btn1,
                            $lbl3, $lbl4, $txt2, $btn2,
                            $lbl5, $lbl6, $btn3, $btn4,
    );

    $gbox.sattr("ORIENTATION", "HORIZONTAL");
    $gbox.sattr("NUMDIV", "4");
    # $gbox.sattr("SIZELIN","0");
    # $gbox.sattr("SIZECOL","2");
    $gbox.sattr("SIZELIN", "-1");
    $gbox.sattr("SIZECOL", "-1");
    $gbox.sattr("MARGIN", "30x30");
    $gbox.sattr("GAPCOL", "30");
    $gbox.sattr("GAPLIN", "30");
    $gbox.sattr("ALIGNMENTLIN", "ACENTER");
    $gbox.sattr("ALIGNMENTCOL", "ARIGHT");
    # $gbox.sattr( "ALIGNMENTLIN", "ATOP");
    # $gbox.sattr( "ALIGNMENTCOL", "ALEFT");

    $dlg = $iup.dialog($gbox);
    $dlg.sattr("TITLE", "Hello World", :copy);
    $dlg.show(IUP_CENTER, IUP_CENTER);

    $iup.main-loop;
    $iup.close;
}
