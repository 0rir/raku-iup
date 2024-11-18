# Raku program to exemplify the IupVal element.

use lib 'lib';
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;

my ( $lbl_h, $lbl_v);

sub mousemove(IUP::Handle $c, Rat $a -->Int) {

    my $buffer = sprintf "VALUE=%.2g", $a;
    my $type = $c.get-attr( "ORIENTATION");

    given $type[0] {
        when 'V' { $lbl_v.set-attr( :copy,  "TITLE", $buffer) }
        when 'H' { $lbl_h.set-attr( :copy, "TITLE", $buffer) }
    }
    IUP_DEFAULT;
}

sub button_press(IUP::Handle $c, Rat $a -->Int) {

    my $type =  $c.get-attr( "ORIENTATION");

    given $type[0] {
        when 'V' { $lbl_v.set-attr( "FGCOLOR", "255 0 0") }
        when 'H' { $lbl_h.set-attr( "FGCOLOR", "255 0 0") }
    }
    mousemove($c, $a);
    IUP_DEFAULT;
}

sub button_release(IUP::Handle $c, Rat $a -->Int) {

    my $type = $c.get-attr( "ORIENTATION");

    given $type[0] {
        when 'V' { $lbl_v.set-attr(  "FGCOLOR", "0 0 0") }
        when 'H' { $lbl_h.set-attr(  "FGCOLOR", "0 0 0") }
    }
    mousemove($c, $a);
    IUP_DEFAULT;
}


sub MAIN() {

    my $iup = IUP.new;
    $iup.open;
    my $ih = IUP::Handle.new;

    my $val_v = $iup.val("VERTICAL");
    my $val_h = $iup.val("HORIZONTAL");
    $lbl_v = $ih.label("VALUE=");
    $lbl_h = $ih.label("VALUE=");
    $lbl_v.set-attr(  "SIZE", "50x");
    $lbl_h.set-attr(  "SIZE", "50x");
    $val_v.set-attr(  "SHOWTICKS", "5");

    my $dlg_val = $iup.dialog(
        $ih.hbox(
            $ih.hbox( $val_v, $lbl_v).set-attr( :pre, "ALIGNMENT=ACENTER"),
            $ih.hbox( $val_h, $lbl_h).set-attr( :pre, "ALIGNMENT=ACENTER"),
        )
    );
    $val_v.set-callback(  "BUTTON_PRESS_CB",   &button_press);
    $val_v.set-callback(  "BUTTON_RELEASE_CB", &button_release);
    $val_v.set-callback(  "MOUSEMOVE_CB",      &mousemove);

    $val_h.set-callback(  "BUTTON_PRESS_CB",   &button_press);
    $val_h.set-callback(  "BUTTON_RELEASE_CB", &button_release);
    $val_h.set-callback(  "MOUSEMOVE_CB",       &mousemove);

    $dlg_val.set-attr(  "TITLE", "IupVal");
    $dlg_val.set-attr(  "MARGIN", "10x10");
    $dlg_val.show( IUP_CENTER,IUP_CENTER);

    $iup.main-loop;
    $iup.close;

}

