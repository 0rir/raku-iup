#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.c;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;

sub MAIN() {
    my $iup = IUP.new;

    $iup.open;

    my $ih = IUP::Handle.new();

    my $text = $ih.text;
    $text.sattr("SIZE", "200x");

    my $pwd = $ih.text;
    $pwd.sattr("VALUE", "current directory: $*CWD");
    $pwd.sattr("READONLY", "YES");
    $pwd.sattr("SIZE", "200x");

    my $vbox = $ih.vbox($text, $pwd);
    my $dlg = $ih.dialog($vbox);
    $dlg.sattr("TITLE", "IupText", :copy);
    $dlg.show(IUP_CENTER, IUP_CENTER);

    $iup.main_loop;
say "\$text -> $text.get-attr( 'VALUE').Str() \t\$pwd -> $pwd.get-attr( 'VALUE').Str()";
    $iup.close;

    exit;

}
