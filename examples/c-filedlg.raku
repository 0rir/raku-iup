#!/usr/bin/env raku
# IupFileDlg Raku Example from the C 
# Shows a typical file-saving dialog.

use IUP;

sub MAIN() {
    my $filedlg; 
    my $iup = IUP.new;
    $iup.open;
    my $ih = IUP::Handle.new;

    $iup.set-language("ENGLISH");

   $filedlg = $iup.file-dlg(); 
 
   $filedlg.set-attr( :pre,  "DIALOGTYPE = SAVE, TITLE = \"File Save\"");
   $filedlg.set-attr( :pre,  "FILTER = \"*.bmp\", FILTERINFO = \"Bitmap Files\"");

   $filedlg.popup(  IUP_CENTER, IUP_CENTER); 

    given $filedlg.get-int( "STATUS") {
        when 1 {
            $ih.message("New file", $filedlg.get-attr(  "VALUE") ); 
        }
        when 0 {
            $ih.message("File already exists", $filedlg.get-attr(  "VALUE"));
        }
        when -1 {
            $ih.message("IupFileDlg","Operation Canceled");
            return 1;
        }
    }
    $filedlg.destroy;
    $iup.close; 
}
