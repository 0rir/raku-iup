#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;

=begin comment

Exploring/verifying setting/getting by handle.

=end comment

my $iup = IUP.new;
$iup.open;
my $ih = IUP::Handle.new;

my $hbox = $ih.hbox( $ih.label('hello'));

say '$hbox.raku: ', $hbox;

$hbox.set-handle( 'hbox' );

my $h = $ih.get-handle( 'hbox');

my $dialog = $ih.dialog( $h );
$dialog.show(IUP_CENTER, IUP_CENTER);

$iup.main-loop;
$iup.close;
