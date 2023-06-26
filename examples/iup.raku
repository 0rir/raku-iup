#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.c;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;

my $iup = IUP.new;

my @argv;
$iup.open;

$iup.dialog( $iup.label("Hello, world!")).show();

$iup.main-loop;
$iup.close;
exit;
