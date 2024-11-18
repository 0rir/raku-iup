#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.c;
use lib 'lib';
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;
use NativeCall;

=begin comment
    03-listdialog.raku -- demo of the predefined ListDialog.
=end comment

sub MAIN() {

    my $iup = IUP.new;
    $iup.open;
    my $ih = IUP::Handle.new;

    $iup.set-str-global( 'DEFAULTFONTSIZE', '24' );

    my Str $title = 'Choose One from List';
    my Str @list = < Red White Blue Green Yellow Black Orange Gold >;
    my int32 $size = @list.end;
    my Int $hilight = 4;       # pre select by index
    my int32 $cols = 8;
    my int32 $lines = 8;

    # --- only single selection made with scalar Int $hilight
    my @sel = $iup.list-dialog: $title, @list, $hilight, $cols, $lines;
    say 'Single selection: ', @sel.raku;

    # multiple selection
    $title = 'Choose Multiple from List';
    my @pre-sel =[1,3,5];

    @sel = $iup.list-dialog: $title, @list, @pre-sel, $cols, $lines;
    say 'Multiple selection: ', @sel.raku;

    $iup.close; # Finishes IUP
}

