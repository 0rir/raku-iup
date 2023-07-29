#!/usr/bin/env raku
#  IupGetFile: example in Raku from the C 
#    Shows a typical file-selection dialog.

use IUP;

sub MAIN() {

    my $iup = IUP.new;
    $iup.open;
    my $ih = IUP::Handle.new;

    $iup.set-language: "ENGLISH";

    my $file =  "*.txt";

    given $ih.get-file($file) {
        when 1  { $ih.message("New file", $file);                 }
        when 0  { $ih.message("File already exists", $file);      }
        when -1 { $ih.message("IupFileDlg","Operation canceled"); }
        when -2 { $ih.message("IupFileDlg","Allocation error");   }
        when -3  { $ih.message("IupFileDlg","Invalid parameter"); }
    }
    $iup.close;
}

