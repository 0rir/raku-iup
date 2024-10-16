#!/usr/bin/env raku
use v6;
use IUP;

my $iup;
my $ih;

=begin comment
    IupMultiline Advanced Example in C
Shows a dialog with a multiline, a text, a list and some buttons. You can
test the multiline attributes by clicking on the buttons. Each button is
related to an attribute. Select if you want to set or get an attribute
using the dropdown list. The value in the text will be used as value
when a button is pressed.
=end comment

#  Function: Set Attribute
#  Description: Sets an attribute with the value in the text.
#  Parameters received: * attribute - attribute to be set
#  Value returned: IUP_DEFAULT
sub set_attribute (Str $attribute -->Int) {
    my $string_message; # [50];

    my $mltline = $iup.get-handle("mltline");
    my $text    = $iup.get-handle("text");
    $mltline.set-attr( $attribute, $text.get-attr( $text, "VALUE"));

    sprintf( $string_message, "Attribute %s set with value %s",
    $attribute, $text.get-attr( "VALUE"));

    $iup.message( "Set attribute", $string_message);

    return IUP_DEFAULT;
}

# Function: Get attribute
# Description: Get an attribute of the multiline and shows it in the text
# Parameters received:
sub get_attribute (Str $attribute -->int32) {
    my $string_message;  # [50];
    my $mltline;
    my $text;

    $mltline = $iup.get-handle("$mltline");
    $text = $iup.get-handle("text");
    $text.set_attr( "VALUE", $mltline.get-attr($mltline, $attribute));

    $string_message.sprintf( "Attribute %s get with value %s", $attribute,
        $text.get-attr( "VALUE"));

    $iup.message("Get attribute", $string_message);

    return IUP_DEFAULT;
}

# Functions: Append button callback
# Description: Appends text to the multiline. Value: text to be appended
# Value returned: IUP_DEFAULT
sub btn_append_cb (-->int32) {

  my $list = $ih.get-handle("list");

  if $list.get-int( "VALUE") == 1 {
    $list.set_attribute("APPEND");
  } else {
     $list.get-attribute("APPEND");
  }
  return IUP_DEFAULT;
}


# Function: Insert button
# Description: Inserts text in the multiline. Value: text to be inserted
# Value returned: IUP_DEFAULT
sub btn_insert_cb (-->int32) {
  my $list;

  $list = $ih.get-handle("list");

  if $list.get-int( "VALUE") == 1 {
      $list.set_attr("INSERT")
  } else {
      $list.get-attr("INSERT");
  }
  return IUP_DEFAULT;
}


#  Function: Border button callback
#  Description: Border of the multiline. Value: "YES" or "NO"
# Value returned: IUP_DEFAULT

sub btn_border_cb (-->int32)
{
   my $list = $ih.get-handle("list");

  if $list.get-int( "VALUE") == 1 {
      $list.set_attr("BORDER");
  }else{
      $list.get-attr("BORDER");
  }
  return IUP_DEFAULT;
}


#  Function: Caret button callback
# Description: Position of the caret. Value: lin,col
# Value returned: IUP_DEFAULT

sub btn_caret_cb (-->int32) {
  my $list = $ih.get-handle("list");

  if $list.get-int( "VALUE") == 1 {
      $list.set_attr("CARET");
  }else{
      $list.get-attr("CARET");
  }

  return IUP_DEFAULT;
}

#  Function: Read-only button callback
#  Description: Readonly attribute. Value: "YES" or "NO"
# Value returned: IUP_DEFAULT

sub btn_readonly_cb(-->int32) {
  my $list = $ih.get-handle("list");

  if $list.get-int( "VALUE") == 1 {
      $list.set_attr("READONLY")
  } else {
      $list.get-attr("READONLY");
  }
  return IUP_DEFAULT;
}

#  Function: Selection button callback
# Description: Changes the selection attribute. Value: lin1,col1:lin2,col2
# Value returned: IUP_DEFAULT

sub btn_selection_cb (-->int32) {
  my $list = $ih.get-handle("list");

  if $list.get-int( "VALUE") == 1 {
      $list.set_attr("SELECTION");
  }else{
      $list.get-attr("SELECTION");
  }
  return IUP_DEFAULT;
}

#  Function: Selected text button callback
# Description: Changes the selected text attribute. Value: lin1,col1:lin2,col2
# Value returned: IUP_DEFAULT

sub btn_selectedtext_cb (-->int32){
  my $list = $ih.get-handle("list");

  if $list.get-int( "VALUE") == 1 {
      $list.set_attr("SELECTEDTEXT");
  }else{
      $list.get-attr("SELECTEDTEXT");
  }
  return IUP_DEFAULT;
}

#  Function: Number of characters button callback
# Description: Limit number of characters in the multiline
# Value returned: IUP_DEFAULT

sub btn_nc_cb (-->int32) {
  my $list;

  $list = $ih.get-handle("list");

  if ($list.get-int( "VALUE") == 1) {
        $list.set_attr("NC");
    } else {
        $list.get-attr("NC");
    }

  return IUP_DEFAULT;
}


#  Function: Value button callback
#  Description: Text in the multiline.
#  Value returned: IUP_DEFAULT

sub btn_value_cb (-->int32) {
  my $list = $ih.get-handle("list");

  if $list.get-int( "VALUE") == 1 {
      $list.set_attr("VALUE");
  }else{
      $list.get-attr("VALUE");
  }
  return IUP_DEFAULT;
}

# Main sub
sub MAIN(-->Int) {
    # IUP identifiers
  my (  $dlg,           $mltline,           $text,
        $list,          $btn_append,        $btn_insert,
        $btn_border,    $btn_caret,         $btn_readonly,
        $btn_selection, $btn_selectedtext,  $btn_nc,
        $btn_value);

  # Initializes IUP
  $iup = IUP.new;
  $iup.open;
  $ih = IUP::Handle.new;

  # Program begin
  # Creates a multiline, a text and a list
  $mltline = $iup.multiline;
  $text = $iup.text;
  $list = IupList('');

  # Turns on multiline expand and text horizontal expand
  $mltline.set_attr( "EXPAND", "YES");
  $text.set_attr( "EXPAND", "HORIZONTAL");

  # Associates handles to multiline, text and list
  $mltline.set-handle( 'mltline');
  $text.set-handle("text");
  $list.set-handle("list");

  # Sets list items and dropdown
  $list.set-attr( "1" => "SET", "2" => "GET", "DROPDOWN" => "YES");

  # Creates buttons
  $btn_append = $iup.button("Append");
  $btn_insert = $iup.button("Insert");
  $btn_border = $iup.button("Border");
  $btn_caret = $iup.button("Caret");
  $btn_readonly = $iup.button("Read only");
  $btn_selection = $iup.button("Selection");
  $btn_selectedtext = $iup.button("Selected Text");
  $btn_nc = $iup.button("Number of characters");
  $btn_value = $iup.button("Value");

  # Registers callbacks
  $btn_append.set-callback(       "ACTION", &btn_append_cb);
  $btn_insert.set-callback(       "ACTION", &btn_insert_cb);
  $btn_border.set-callback(       "ACTION", &btn_border_cb);
  $btn_caret.set-callback(        "ACTION", &btn_caret_cb);
  $btn_readonly.set-callback(     "ACTION", &btn_readonly_cb);
  $btn_selection.set-callback(    "ACTION", &btn_selection_cb);
  $btn_selectedtext.set-callback( "ACTION", &btn_selectedtext_cb);
  $btn_nc.set-callback(           "ACTION", &btn_nc_cb);
  $btn_value.set-callback(        "ACTION", &btn_value_cb);

  # Creates dialog
    $dlg = $iup.dialog(
        $iup.vbox(
            $mltline,
            $iup.hbox($text, $list),
            $iup.hbox($btn_append, $btn_insert, $btn_border, $btn_caret,
                    $btn_readonly, $btn_selection),
            $iup.hbox($btn_selectedtext, $btn_nc, $btn_value),
        )
    );

                   # Sets title and size of the dialog
  $dlg.set-attr( "TITLE" => "IupMultiLine Example", "SIZE" => "HALFxQUARTER");

  # Shows dialog in the center of the screen
  $dlg.show( IUP_CENTER, IUP_CENTER);

  $iup.main-loop;

  # Finishes IUP
  $iup.close;
  return 0;
}
