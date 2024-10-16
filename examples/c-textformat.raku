#!/usr/bin/env raku

use IUP;

my $iup = IUP.new;
$iup.open;
my $ih = IUP::Handle.new;

sub MAIN( -->Int) {

  TextTest();

  $iup.main-loop;
  $iup.close;
}


sub text2multiline( $ih, Str $attribute -->Nil) {
    my $mltline =  $ih.get-dialog-child(  "mltline");
    my $text    =  $ih.get-dialog-child(  "text");
    $mltline.set-attr(  $attribute,  $text.get-attr( "VALUE"));
}

sub multiline2text( $ih, Str $attribute -->Nil) {
    my $mltline =  $ih.get-dialog-child(  "mltline");
    my $text    =  $ih.get-dialog-child(  "text");
    $text.set-attr(  "VALUE",  $mltline.get-attr( $attribute));
}

sub btn_append_cb( $ih -->Int) {
    text2multiline( $ih, "APPEND");
    IUP_DEFAULT;
}

sub btn_insert_cb( $ih -->Int) {
    text2multiline($ih, "INSERT");
    IUP_DEFAULT;
}

sub btn_clip_cb( $ih -->Int) {
    text2multiline($ih, "CLIPBOARD");
    IUP_DEFAULT;
}

sub btn_key_cb( $ih -->Int) {
    my $mltline =  $ih.get-dialog-child( "mltline");
    my $text    =  $ih.get-dialog-child( "text");
    $mltline.set-focus;
    $iup.flush;
    IUP_DEFAULT;
}

sub btn_caret_cb( $ih -->Int) {
    my $opt = $iup.get-handle("text2multi");
    if $opt.get-int("VALUE") {
        text2multiline($ih, "CARET");
    } else {
        multiline2text($ih, "CARET");
    }
    IUP_DEFAULT;
}

sub btn_readonly_cb( $ih -->Int) {
    my $opt = $iup.get-handle("text2multi");
    if $opt.get-int( $opt, "VALUE") {
        text2multiline( $ih, "READONLY");
    } else {
        multiline2text($ih, "READONLY");
    }
    IUP_DEFAULT;
}

sub btn_selection_cb( $ih -->Int) {
    my $opt = $iup.get-handle("text2multi");
    if $iup.get-int($opt, "VALUE") {
        text2multiline($ih, "SELECTION");
    }else{
        multiline2text($ih, "SELECTION");
    }
    IUP_DEFAULT;
}

sub btn_selectedtext_cb( $ih -->Int) {
    my $opt = $iup.get-handle("text2multi");
    if $opt.get-int( "VALUE") {
        text2multiline( $ih, "SELECTEDTEXT");
    } else {
        multiline2text( $ih, "SELECTEDTEXT");
    }
    IUP_DEFAULT;
}

sub btn_overwrite_cb( $ih -->Int) {
    my $opt = $iup.get-handle("text2multi");
    if $opt.get-int( "VALUE") {
        text2multiline( $ih, "OVERWRITE");
    } else {
        multiline2text( $ih, "OVERWRITE");
    }
    IUP_DEFAULT;
}
sub btn_active_cb( $ih -->Int) {
    my $opt = $iup.get-handle("text2multi");
    if $opt.get-int( "VALUE") {
        text2multiline( $ih, "ACTIVE");
    } else {
        multiline2text( $ih, "ACTIVE");
    }
    IUP_DEFAULT;
}

sub btn_remformat_cb( $ih -->Int) {
  text2multiline($ih, "REMOVEFORMATTING");
  IUP_DEFAULT;
}

sub btn_nc_cb( $ih -->Int) {
    my $opt = $iup.get-handle("text2multi");
    if $opt.get-int( "VALUE") {
        text2multiline( $ih, "NC");
    } else {
        multiline2text( $ih, "NC");
    }
    IUP_DEFAULT;
}

sub btn_value_cb( $ih -->Int) {
    my $opt = $iup.get-handle("text2multi");
    if $opt.getint( "VALUE") {
        text2multiline($ih, "VALUE");
    }else {
        multiline2text($ih, "VALUE");
    }
    IUP_DEFAULT;
}

sub btn_tabsize_cb( $ih -->Int) {
    my $opt = $iup.get-handle("text2multi");
    if $opt.get.int( "VALUE") {
        text2multiline($ih, "TABSIZE");
    } else {
        multiline2text($ih, "TABSIZE");
    }
    IUP_DEFAULT;
}

sub k_f2( -->Int) {
    printf("K_F2\n");
    IUP_DEFAULT;
}

sub file_open( -->Int) {
    my $filename = "";
    $iup.get-file($filename);  # test key after dlg in multiline
    printf( $filename);
    IUP_DEFAULT;
}

#sub iupKeyCodeToName(Int $code -->Str); # XXX This is in UIP/src/iup_key.c

sub k_any( $ih, int32 $c -->Int) {
    if iup_isprint($c) {
        printf("K_ANY(%d = %s \'%c\')\n", $c, iupKeyCodeToName($c), $c);
    } else {
        printf("K_ANY(%d = %s)\n", $c, iupKeyCodeToName($c));
        printf("  CARET(%s)\n",  $ih.get-attr(  "CARET"));
    }
    if $c == K_cA {
        IUP_IGNORE;   # Sound a beep in Windows
    }
    if $c == K_cP {
        file_open();
        IUP_IGNORE;   // Sound a beep in Windows
    }
    IUP_CONTINUE;
}

sub action( $ih, int32 $c, $after -->Int) {
    if iup_isprint(c) {
        printf("ACTION(%d = %s \'%c\', %s)\n", $c, iupKeyCodeToName($c), $c, $after);
    } else {
        printf("ACTION(%d = %s, %s)\n", c, iupKeyCodeToName(c), after);
    }
    if $c == K_i { IUP_IGNORE;  }  // OK
    if $c == K_cD { IUP_IGNORE;  }  // Sound a beep in Windows
    if $c == K_h { K_j; }
    IUP_DEFAULT;
}

sub caret_cb($ih, Int $lin, Int $col, Int $po -->Int) {
    printf("CARET_CB(%d, %d - %d)\n", $lin, $col, $pos);
    printf("  CARET(%s - %s)\n",
            $ih.get-attr(  "CARET"),  $ih.get-attr(  "CARETPOS"));
    IUP_DEFAULT;
}

sub getfocus_cb( -->Int) {
    printf("GETFOCUS_CB()\n");
    IUP_DEFAULT;
}

sub help_cb( -->Int) {
    printf("HELP_CB()\n");
    IUP_DEFAULT;
}

sub killfocus_cb( -->Int) {
    printf("KILLFOCUS_CB()\n");
    IUP_DEFAULT;
}

sub leavewindow_cb( -->Int) {
    printf("LEAVEWINDOW_CB()\n");
    IUP_DEFAULT;
}

sub enterwindow_cb(-->Int) {
    printf("ENTERWINDOW_CB()\n");
    IUP_DEFAULT;
}

    sub btn_def_esc_cb( -->Int) {
  printf("DEFAULTESC\n");
  IUP_DEFAULT;
}

sub btn_def_enter_cb( -->Int) {
    printf("DEFAULTENTER\n");
    IUP_DEFAULT;
}

sub dropfiles_cb($ih, Str $filename, Int $num, Int $x, Int $y -->Int) {
    printf("DROPFILES_CB(%s, %d, x=%d, y=%d)\n", $filename, $num, $x, $y);
    IUP_DEFAULT;
}

sub button_cb( $ih,Int $but,Int $pressed,Int $x,Int $y,Str $status -->Int) {
    Int ( $lin, $col, $pos);
    printf("BUTTON_CB(but=%c (%d), x=%d, y=%d [%s])\n",
            $but,$pressed,$x,$y, $status);
    $pos = IupConvertXYToPos( $ih, $x, $y);
    IupTextConvertPosToLinCol($ih, $pos, $lin, $col);
    printf("         (lin=%d, col=%d, pos=%d)\n", $lin, $col, $pos);
    IUP_DEFAULT;
}

sub motion_cb( $ih, Int $x,Int $y,Str $status -->Int) {
    Int ( $lin, $col, $pos);
    printf("MOTION_CB(x=%d, y=%d [%s])\n", $x, $y,  $status);
    $pos = IupConvertXYToPos($ih, $x, $y);
    IupTextConvertPosToLinCol($ih, $pos, $lin, $col);
    printf("         (lin=%d, col=%d, pos=%d)\n", $lin, $col, $pos);
    IUP_DEFAULT;
}

sub TextTest( -->Nil) {
    Int $formatting = 0;
    my ( $dlg,              $mltline,       $text,          $opt,
         $btn_def_enter,    $btn_def_esc,   $btn_active,    $btn_overwrite,
         $btn_append,       $btn_insert,    $btn_caret,     $btn_clip,
         $btn_key,          $btn_readonly,  $btn_tabsize,   $btn_selection,
         $btn_selectedtext, $btn_nc,        $btn_value,     $lbl,
         $formattag,        $btn_remformat
     );

#   $iup.set-global("UTF8AUTOCONVERT", "NO");

    $text = $iup.text;
    $text.set-attr( "EXPAND", "HORIZONTAL");
#   $text.set-attr( "VALUE", "Single Line Text");
    $text.set-attr( "CUEBANNER", "Enter Attribute Value Here");
    $text.set-attr( "NAME", "text");
    $text.set-attr( "TIP", "Attribute Value");

    $opt = $iup.toggle("Set/Get");
    $opt.set-attr( "VALUE", "ON");
    $iup.set-function( "text2multi", $opt);

    $mltline = $iup.multiline();
#   $mltline = $iup.text(NULL);
#   $mltline.set-attr( "MULTILINE", "YES");
    $mltline.set-attr( "NAME", "mltline");

    $mltline.set-callback( "DROPFILES_CB", (Icallback)dropfiles_cb);
    $mltline.set-callback( "BUTTON_CB",    (Icallback)button_cb);
#   $mltline.set-callback( "MOTION_CB",    (Icallback)motion_cb);
    $mltline.set-callback( "HELP_CB",      (Icallback)help_cb);
    $mltline.set-callback( "GETFOCUS_CB",  (Icallback)getfocus_cb);
    $mltline.set-callback( "KILLFOCUS_CB", (Icallback)killfocus_cb);
    $mltline.set-callback( "ENTERWINDOW_CB", (Icallback)enterwindow_cb);
    $mltline.set-callback( "LEAVEWINDOW_CB", (Icallback)leavewindow_cb);
#   $mltline.set-callback( "ACTION", (Icallback)action);
    $mltline.set-callback( "K_ANY", (Icallback)k_any);
    $mltline.set-callback( "K_F2", (Icallback)k_f2);
    $mltline.set-callback( "CARET_CB", (Icallback)caret_cb);
#   $mltline.set-attr( "WORDWRAP", "YES");
#   $mltline.set-attr( "BORDER", "NO");
#   $mltline.set-attr( "AUTOHIDE", "YES");
#   $mltline.set-attr( "BGCOLOR", "255 0 128");
#   $mltline.set-attr( "FGCOLOR", "0 128 192");
#   $mltline.set-attr( "PADDING", "15x15");
    $mltline.set-attr( "TIP", "First Line\nSecond Line\nThird Line");
#   $mltline.set-attr( "FONT", "Helvetica, 14");
#   $mltline.set-attr( "MASK", IUP_MASK_FLOAT);
#   $mltline.set-attr( "FILTER", "UPPERCASE");
#   $mltline.set-attr( "ALIGNMENT", "ACENTER");
#   $mltline.set-attr( "CANFOCUS", "NO");

        # Turns on multiline expand and text horizontal expand */
    $mltline.set-attr( "SIZE", "80x40");
    $mltline.set-attr( "EXPAND", "YES");

#   $mltline.set-attr( "FONT", "Courier, 16");
#   $mltline.set-attr( "FONT", "Arial, 12");
#   $mltline.set-attr( "FORMATTING", "YES");

    $formatting = 0;
    if $formatting {         # just to make easier to comment this section
        # formatting before Map
        $mltline.set-attr( "FORMATTING", "YES");

        $formattag = $iup.user;
        $formattag.set-attr( "ALIGNMENT", "CENTER");
        $formattag.set-attr( "SPACEAFTER", "10");
        $formattag.set-attr( "FONTSIZE", "24");
        $formattag.set-attr( "SELECTION", "3,1:3,50");
        $mltline.set-attr( "ADDFORMATTAG_HANDLE", (char*)formattag);

        $formattag = IupUser();
        $formattag.set-attr( "BGCOLOR", "255 128 64");
        $formattag.set-attr( "UNDERLINE", "SINGLE");
        $formattag.set-attr( "WEIGHT", "BOLD");
        $formattag.set-attr( "SELECTION", "3,7:3,11");
        $mltline.set-attr( "ADDFORMATTAG_HANDLE", (char*)formattag);
    }

    # Creates buttons
    $btn_append = $iup.button("&APPEND", NULL);
    $btn_insert = $iup.button("INSERT", NULL);
    $btn_caret = $iup.button("CARET", NULL);
    $btn_readonly = $iup.button("READONLY", NULL);
    $btn_selection = $iup.button("SELECTION", NULL);
    $btn_selectedtext = $iup.button("SELECTEDTEXT", NULL);
    $btn_nc = $iup.button("NC", NULL);
    $btn_value = $iup.button("VALUE", NULL);
    $btn_tabsize = $iup.button("TABSIZE", NULL);
    $btn_clip = $iup.button("CLIPBOARD", NULL);
    $btn_key = $iup.button("KEY", NULL);
    $btn_def_enter = $iup.button("Default Enter", NULL);
    $btn_def_esc = $iup.button("Default Esc", NULL);
    $btn_active = $iup.button("ACTIVE", NULL);
    $btn_remformat = $iup.button("REMOVEFORMATTING", NULL);
    $btn_overwrite = $iup.button("OVERWRITE", NULL);

    $btn_append.set-attr( "TIP", "First Line\nSecond Line\nThird Line");

    # Registers callbacks */
    $btn_append.set-callback(       "ACTION", (Icallback) btn_append_cb);
    $btn_insert.set-callback(       "ACTION", (Icallback) btn_insert_cb);
    $btn_caret.set-callback(        "ACTION", (Icallback) btn_caret_cb);
    $btn_readonly.set-callback(     "ACTION", (Icallback) btn_readonly_cb);
    $btn_selection.set-callback(    "ACTION", (Icallback) btn_selection_cb);
    $btn_selectedtext.set-callback( "ACTION", (Icallback) btn_selectedtext_cb);
    $btn_nc.set-callback(           "ACTION", (Icallback) btn_nc_cb);
    $btn_value.set-callback(        "ACTION", (Icallback) btn_value_cb);
    $btn_tabsize.set-callback(      "ACTION", (Icallback) btn_tabsize_cb);
    $btn_clip.set-callback(         "ACTION", (Icallback) btn_clip_cb);
    $btn_key.set-callback(          "ACTION", (Icallback) btn_key_cb);
    $btn_def_enter.set-callback(    "ACTION", (Icallback) btn_def_enter_cb);
    $btn_def_esc.set-callback(      "ACTION", (Icallback) btn_def_esc_cb);
    $btn_active.set-callback(       "ACTION", (Icallback) btn_active_cb);
    $btn_remformat.set-callback(    "ACTION", (Icallback) btn_remformat_cb);
    $btn_overwrite.set-callback(    "ACTION", (Icallback) btn_overwrite_cb);

    $lbl = IupLabel("&Multiline:");
    $lbi.set-attr( "PADDING", "2x2")

        # Creates dlg
    $dlg = $iup.dialog(
        $iup.vbox(
            $lbl,
            $mltline,
            $iup.hbox( $text, $opt),
            $iup.hbox(  $btn_append, $btn_insert, $btn_caret,
                        $btn_readonly, $btn_selection),
            $iup.hbox(  $btn_selectedtext, $btn_nc, $btn_value,
                        $btn_tabsize, $btn_clip, $btn_key),
            $iup.hbox(  $btn_def_enter, $btn_def_esc, $btn_active,
                        $btn_remformat, $btn_overwrite),
        )
    );
    $dlg.set-callback(  "K_cO", (Icallback)file_open);
    $dlg.set-attr(  "TITLE", "IupText Test");
    $dlg.set-attr(  "MARGIN", "10x10");
    $dlg.set-attr(  "GAP", "5");
    $dlg.set_attribute_handle( "DEFAULTENTER", btn_def_enter);
    $dlg.set_attribute_handle( "DEFAULTESC", btn_def_esc);
    $dlg.set-attr(  "SHRINK", "YES");

    if $formatting {         # just to make easier to comment this section
        IupMap(dlg);
            # formatting after Map

        $formattag = $iup.user;
        $formattag.set-attr(  "ITALIC", "YES");
        $formattag.set-attr(  "STRIKEOUT", "YES");
        $formattag.set-attr(  "SELECTION", "2,1:2,12");
        $mltline.set-attr(  "ADDFORMATTAG_HANDLE", (char*)formattag);
    }

        # Shows dlg in the center of the screen
    $dlg.show(  IUP_CENTER, IUP_CENTER);
    $iup.set-focus(mltline);
}


