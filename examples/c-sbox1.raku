#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;


sub MAIN() {

  my $iup = IUP.new;
  $iup.open;
  my $ih = IUP::Handle.new;

  my ( $dlg, $bt, $box, $lbl, $ml, $vbox);

  $bt = $ih.button("Button");
  #$bt.set_attr("EXPAND", "VERTICAL"); #  This is the only necessary EXPAND
  $bt.set_attr( "EXPAND", "YES");

  $box = $ih.sbox( $bt);
  $box.set_attr( "DIRECTION", "SOUTH");  # place at the button's bottom
  $box.set_attr( "COLOR", "0 255 0");

  $ml = $ih.multiline('');
  $ml.set_attr( "EXPAND", "YES");
  $ml.set_attr( "VISIBLELINES", "5");
  $vbox = $ih.vbox( $box, $ml);

  $lbl = $iup.label("Label");
  $lbl.set_attr( "EXPAND", "VERTICAL");

  $dlg = $iup.dialog( $iup.hbox($vbox, $lbl) );
  $dlg.set_attr( "TITLE", "IupSbox Example");
  $dlg.set_attr( "MARGIN", "10x10");
  $dlg.set_attr( "GAP", "10");

  $dlg.show;

  $iup.main-loop;
  $iup.close;
}
