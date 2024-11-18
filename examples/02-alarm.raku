#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.d;
use lib 'lib';
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;

=begin comment
    02-alarm.raku -- a demo of the alarm dialogue, a warning box with options.
=end comment

sub MAIN() {

    my $iup = IUP.new();
    $iup.open(@);
    $iup.set-global( 'DEFAULTFONTSIZE', '24', :copy );

    my $pressed = IupAlarm( 'Title', 'Press one?', 'one', 'two', "three" );
    say $pressed.WHAT;
    say $pressed;
    $pressed = IupAlarm( 'Title', 'Press two?', 'one', 'two', "three" );
    say $pressed;
    $pressed = IupAlarm( 'Title', 'Press three?', 'one', 'two', "three" );
    say $pressed;
    $pressed = IupAlarm( 'Title', 'Press two?', 'one', 'two', Str );
    say $pressed;
    $pressed = IupAlarm( 'Title', 'Press one?', 'one', 'two',  Str );
    say $pressed;
    $pressed = IupAlarm( 'Title', 'Press 1?', '1', Str, Str );
    say $pressed;

    my $msg = IupMessage( 'Title', 'message' );

    $iup.close(); # Finishes IUP


}
