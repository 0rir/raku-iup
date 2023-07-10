use v6;
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

    $mbox = $iup.multibox(   $lbl1, $lbl2, $txt1, $btn1,
                            $lbl3, $lbl4, $txt2, $btn2,
                            $lbl5, $lbl6, $btn3, $btn4,
    );

    $mbox.sattr("ORIENTATION", "HORIZONTAL");
    $mbox.sattr("NUMDIV", "4");
    # $mbox.sattr("SIZELIN","0");
    # $mbox.sattr("SIZECOL","2");
    $mbox.sattr("SIZELIN", "-1");
    $mbox.sattr("SIZECOL", "-1");
    $mbox.sattr("MARGIN", "30x30");
    $mbox.sattr("GAPCOL", "30");
    $mbox.sattr("GAPLIN", "30");
    $mbox.sattr("ALIGNMENTLIN", "ACENTER");
    $mbox.sattr("ALIGNMENTCOL", "ARIGHT");
    # $mbox.sattr( "ALIGNMENTLIN", "ATOP");
    # $mbox.sattr( "ALIGNMENTCOL", "ALEFT");

    $dlg = $iup.dialog($mbox);
    $dlg.sattr("TITLE", "Hello World", :copy);
    $dlg.show(IUP_CENTER, IUP_CENTER);

    $iup.main-loop;
    $iup.close;
}
