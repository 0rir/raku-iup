#!/usr/bin/env raku
# IupListDialog: Example in C
# Shows a dialog for selection from list.

use lib 'lib';
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;

sub MAIN() {

    my $iup = IUP.new;
        $iup.open;
    my $ih = IUP::Handle.new;

    $iup.set-language("ENGLISH");

    my $title ="Color Selection";
    my Str @option = [ "Blue",  "Red", "Green", "Yellow", "Black", "White",
            "Gray", "Brown" ];
    my Int @preselect = [ 0 ];
    my ( $col, $line) = 16, 5;

    # multiple selection is indicated by @preselect being an Array
    my @selected = $ih.list-dialog( $title, @option, @preselect, $col, $line);

    # XXX Lost distinction between 'Cancel' and 'Nothing selected.
    # Could use [Nil,] for no selection and Array for Cancel.
    if not @selected {
        $ih.message("IupListDialog","Operation canceled"
                  ~ " or No options selected.\n"
                  ~ " NOTE: Current code does not capture the distinction."
              );
    } else {
        $iup.message("Options selected", @selected.Str); # was messagef in C
    }
    $iup.close;
}
