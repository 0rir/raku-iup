# IupBackgroundBox Example in Raku from C

use IUP;

sub MAIN(-->Any) {

    my $iup = IUP.new;
    $iup.open;
    my $ih = IUP::Handle.new;

    # Creates a backgroundbox 
    my $btn = $ih.backgroundbox(
       $ih.frame(
            $ih.vbox(
                $ih.button("This button does nothing", ""), 
                $ih.text(""), 
            ).set-attr( "MARGIN" => "0x0")
        )
    );
say $btn.WHICH;
    $btn.set-attr(  "BGCOLOR", "0 128 0");
    $btn.set-attr(  "BORDER", "Yes");

    # Creates dialog 
    my $dlg = $ih.dialog(
        $ih.vbox(
            $btn,
        ),
    );

    $dlg.set-attr(
        :pre,  "MARGIN=10x10, GAP=10, TITLE = \"IupBackgroundBox Example\"");

    $dlg.show( IUP_CENTER, IUP_CENTER );

    $iup.main-loop;
    $iup.close;
    0
}

