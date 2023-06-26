#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.c;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;

my $iup = IUP.new;

$iup.open;

my $ih = IUP::Handle.new;

$ih.message("IupMessage Example", "Press the button");

$iup.close;

exit;
