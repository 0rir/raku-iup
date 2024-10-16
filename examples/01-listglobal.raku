#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use IUP;

=begin comment
    01-list-glob -- This just lists to STDOUT the names and values of
    global settings in IUP.  This focuses on the GTK/linux implementation.
=end comment

my $iup = IUP.new;
$iup.open;

say "Misc:";
say '   IupVersion(): ', IupVersion;
say '   IupVersionNumber(): ', IupVersionNumber();
say '   IupVersionDate(): ', IupVersionDate;
say '   DEFAULTFONTSIZE: ', $iup.get-global( 'DEFAULTFONTSIZE' );

say "\nSys Info:";
say '    SYSTEM: ', $iup.get-global( 'SYSTEM' );
say '    SYSTEMVERSION: ', $iup.get-global( 'SYSTEMVERSION' );
say '    SYSTEMLANGUAGE: ', $iup.get-global( 'SYSTEMLANGUAGE' );
say '    SYSTEMLOCALE: ', $iup.get-global( 'SYSTEMLOCALE' );
say '    SCROLLBARSIZE: ', $iup.get-global( 'SCROLLBARSIZE' );
say '    GTKVERSION: ', $iup.get-global( 'GTKVERSION' );
say '    GTKDEVVERSION: ', $iup.get-global( 'GTKDEVVERSION' );
say '    COMPUTERNAME: ', $iup.get-global( 'COMPUTERNAME' );
say '    USERNAME: ', $iup.get-global( 'USERNAME' );
say '    EXEFILENAME: ', $iup.get-global( 'EXEFILENAME' );
say '    XSERVERVENDOR: ', $iup.get-global( 'XSERVERVENDOR' );
say '    XVENDORRELEASE: ', $iup.get-global( 'XVENDORRELEASE' );

say "\nScreen Info:";
say '    FULLSIZE: ', $iup.get-global( 'FULLSIZE' );
say '    SCREENSIZE: ', $iup.get-global( 'SCREENSIZE' );
say '    SCREENDEPTH: ', $iup.get-global( 'SCREENDEPTH' );
say '    SCREENDPI: ', $iup.get-global( 'SCREENDPI' );
say '    TRUECOLORCANVAS: ', $iup.get-global( 'TRUECOLORCANVAS' );
say '    XVENDORRELEASE: ', $iup.get-global( 'XVENDORRELEASE' );
say '    DWM_COMPOSITION: ', $iup.get-global( 'DWM_COMPOSITION' );
say '    VIRTUALSCREEN: ', $iup.get-global( 'VIRTUALSCREEN' );
say '    MONITORCOUNT: ', $iup.get-global( 'MONITORCOUNT' );
say '    MONITORSINFO: ', $iup.get-global( 'MONITORSINFO' );

say "System Data:";
say '    HINSTANCE: ', $iup.get-global( 'HINSTANCE' );
say '    DLL_HINSTANCE: ', $iup.get-global( 'DLL_HINSTANCE' );
say '    APPSHELL: ', $iup.get-global( 'APPSHELL' );
say '    XDISPLAY: ', $iup.get-global( 'XDISPLAY' );
say '    XSCREEN: ', $iup.get-global( 'XSCREEN' );
say "\nDefault Attributes:";
say '    DLGBGCOLOR: ', $iup.get-global( 'DLGBGCOLOR' );
say '    DLGFGCOLOR: ', $iup.get-global( 'DLGFGCOLOR' );
say '    MENUBGCOLOR: ', $iup.get-global( 'MENUBGCOLOR' );
say '    MENUFGCOLOR: ', $iup.get-global( 'MENUFGCOLOR' );
say '    TXTBGCOLOR: ', $iup.get-global( 'TXTBGCOLOR' );
say '    TXTFGCOLOR: ', $iup.get-global( 'TXTFGCOLOR' );
say '    TXTHLCOLOR: ', $iup.get-global( 'TXTHLCOLOR' );
say '    LINKFGCOLOR: ', $iup.get-global( 'LINKFGCOLOR' );
say '    DEFAULTFONT: ', $iup.get-global( 'DEFAULTFONT' );
say '    DEFAULTFONTFACE: ', $iup.get-global( 'DEFAULTFONTFACE' );
say '    DEFAULTBUTTONPADDING: ', $iup.get-global( 'DEFAULTBUTTONPADDING' );
say '    DEFAULTTHEME: ', $iup.get-global( 'DEFAULTTHEME' );

$iup.close;
exit;
