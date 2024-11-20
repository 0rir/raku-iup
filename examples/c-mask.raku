#!/usr/bin/env raku
#  IupText MASK: Example in Raku from C
#  Creates an IupText that accepts only numbers.
use lib 'lib';
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;

sub MAIN(-->Mu){

    my $iup = IUP.new;
    $iup.open;
    my $ih = IUP::Handle.new;

    my $text = $iup.text("");
    $text.set-attr( "MASK", "/d*", "SIZE", "100x", "EXPAND", "HORIZONTAL");

    my $dg = $iup.dialog($text);
    $dg.set-attr( :copy, "TITLE", "IupText MASK");

    $dg.show;
    $iup.main-loop;
    $iup.close;
}

