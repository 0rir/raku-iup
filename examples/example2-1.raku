#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;

sub MAIN ( ) {
    my $iup = IUP.new();
    $iup.open;
    my $msg  = IupMessage( 'Hello World 1', 'Hello world from IUP.');
    $iup.close;
}
