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

    # --- single selection by index via return value
    my Str $title = 'Title';
    my Str @option = < Red White Blue >;
    my int32 $size = @option.end;
    my int32 $chosen = 2;       # highlight default by index+1
    my int32 $columns = 6;
    my int32 $lines = 4;

    my $sel = IupListDialog( $title, @option, $chosen, $columns, $lines );
    say 'First selection index: ', $sel;

    # multiple selection by indices returned
    $title = 'Title choose multiple';
    @option = < Red White Blue Green Yellow Black Orange Gold>;
    $size = @option.end;
    $chosen = 1;       # highlight default by index+1
    $columns = 8;
    $lines = 7;

    my @sel = IupListDialog( $title, @option, $columns, $lines );
    say @sel.raku;

    $iup.close; # Finishes IUP
}

