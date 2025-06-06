#!/usr/bin/env raku
# IupMessage Raku Example from the C
use lib 'lib';
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;

sub MAIN() {
  my $iup = IUP.new;
  $iup.open;
  my $ih = IUP::Handle.new;

  $iup.message("IupMessage Example", "Press the button");

  $iup.close;
}
