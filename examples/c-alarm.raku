#!/usr/bin/env raku
# Iup Alarm: Raku example converted from  C 
#   Shows a dialog similar to the one shown when you exit
# a program without saving.

use IUP;

# Main program
sub MAIN() {
    # Initializes IUP
    my $iup = IUP.new;       # $iup is a boil for the "system Iup"
    $iup.open;
    my $ih = IUP::Handle.new;   # $ih is a handle to a IUP widget which
                                # can be used where the 'self' is not used.
    # Executes IupAlarm via method
    given $ih.alarm( "IupAlarm Example", "File not saved! Save it now?",
                "Yes", "No", "Cancel")
    {
        # Shows a message for each selected button */
        when 1 {
            $ih.message(
                "Save file", "File saved successfully - leaving program");
            }
        when 2 {
            $ih.message(
                "Save file", "File not saved - leaving program anyway");
            }
        when 3 {
            $ih.message( "Save file", "Operation canceled");
        }
  }
  
  # Finishes IUP
  $iup.close;
}
