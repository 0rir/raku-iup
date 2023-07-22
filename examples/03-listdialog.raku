#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.c;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;
use NativeCall;

=begin comment
    03-listdialog.raku -- demo of the predefined ListDialog.
=end comment

sub MAIN() {

    my $iup = IUP.new;
    $iup.open;
    $iup.set-str-global( 'DEFAULTFONTSIZE', '24' );

    my Str $title = 'Choose One from List';
    my Str @list = < Red White Blue Green Yellow Black Orange Gold >;
    my int32 $size = @list.end;
    my int32 $hi = 6;       # default by index+1
    my int32 $cols = 8;
    my int32 $lines = 8;

    # --- only single selection
    my @sel = $iup.list-dialog: $title, @list, $hi, $cols, $lines, :single;
    say 'Single selection: ', @sel.raku;

    # multiple selection
    $title = 'Choose Multiple from List';
    $hi = -1;       # Not used in multi-choice

    @sel = $iup.list-dialog: $title, @list, $hi, $cols, $lines;
    say 'Multiple selection: ', @sel.raku;

    $iup.close; # Finishes IUP
}

