 Raku IUP ![IUP Logo](logotype/logo_32x32.png)
=========
Raku interface to the IUP toolkit for building GUI's.

| Operating System  |   Build Status  |
| ----------------- | --------------- |
| Linux             | None            |

Description
-----------
[IUP][2] is a multi-platform toolkit for building graphical user interfaces.
IUP's purpose is to allow a program source code to be compiled in different
systems without any modification.  Its main advantages are:

* It offers a simple API.
* High performance, due to the fact that it uses native interface elements.
* Fast learning by the user, due to the simplicity of its API.

Installation
------------
Get this IUP library, or later, and install it:

	mkdir libiup
	cd libiup
	curl -L https://sourceforge.net/projects/iup/files/3.25/Linux%20Libraries/iup-3.25_Linux44_64_lib.tar.gz > libiup.tar.gz
	tar xvzf libiup.tar.gz
	sudo bash install
	sudo bash install_dev
	cd ..

Install the Raku module with Zef:

	zef update
	zef install IUP

Synopsis
--------
WARNING:
This module is in its early stages and should be considered a Work in Progress.
The interface is not final and may change in the future.

Some of these methods also have longer names or names with underscores
instead of hyphens.

| Method          | Description                                                            |
| --------------------------------------------------------------------------- |
| destroy         | Destroy self.                                             |
| detach          | NYI                                                       |
| append          | Append control to child-list                              |
| insert          | Insert control after child                                |
| get-child       | Get child by position in list.                            |
| get-child-pos   | NYI                                                       |
| get-child-count | NYI                                                       |
| get-next-child  | Get next child from list.                                 |
| get-brother     | NYI                                                       |
| get-parent      | Get parent of self.                                       |
| get-dialog      | Get the dialog (top-level) of self.                       |
| get-dialog-child | I don't remember this one.                               |
| reparent        | NYI                                                       |
| popup           | Popup self at x,y.                                        |
| show            | Show widget, optionally at x,y.                           |
| hide            | Hide self.                                                |
| map             | Map self into the display layout.                         |
| unmap           | NYI  Unmap self out of the display layout.                |
| set-attr        | Workhorse to set attribute(s) by ref or by :copy and etc. |
| get-attr        | Get attribute by name.                                    |
| get-attrs       | Get attributes of self.                                   |
| get-int         | Get integer attribute by name.                            |
| set-global      | Set global by key (name) and value.                       |
| set-str-global  | Set string global by key (name) and value.                |
| get-global      | Get named global's value                                  |
| set-focus       | Set focus on self.                                        |
| get-focus       | Get widget that has focus.                                |
| set-callback    | Set a callback for a widget.                              |
| set-callbacks   | Set callbacks with key value pairs.                       |
| get-handle      | Get named widget by name.                                 |
| set-handle      | Set a name for self.                                      |
| set-attr-handle | Name a referenced widget.                                 |
| fill            | Fill space in layout.                                     |
| radio           | Create a radio button widget.                             |
| vbox            | Create a vertical box with 1..N child widgets.            |
| zbox            |  Create a zbox with 1..N child widgets.                   |
| hbox            | Create a horizontal box with 1..N child widgets.          |
| sbox            | Crate a sbox (split box)                                  |
| gridbox         | create a grid box                                         |
| multibox        | Create a multibox.                                        |
| expander        | Create an expander.                                       |
| backgroundbox   | Create a backgroundbox.                                   |
| frame           | Create a frame.                                           |
| image           | Create an image by dimensions and pixel list.             |
| item            | Create an item.                                           |
| submenu         | Create a titled submenu.                                  |
| separator       | Create a separator in a menu.                             |
| menu            | Create a menu with 0..N members.                          |
| button          | Create a button with label and action.                    |
| canvas          | Create a canvas.  Not working.                            |
| dialog          | Create a dialog.  Perhaps the top-level or a nodal.       |
| user            | Create a user widget.                                     |
| label           | Create a label.                                           |
| list            | Create a list with a string.                              |
| text            | Create a text widget.                                     |
| multiline       | Create a multiline widget. Text & multiline are same.     |
| toggle          | Create a toggle switch.                                   |
| val             | Create a Val (aka slider or scale) for choosing a value.  |
| dial            | Create a dail widget.                                     |
| file-dlg        | File choice dialog.                                       |
| message-dlg     | Message displaying dialog.                                |
| color-dlg       |   Color choice dialog.                                    |
| font-dlg        |   Font choice dialog.                                     |
| progress-dlg    | Progress displaying dialog.                               |
| get-file        | Get file by name.                                         |
| message         | Display message with title.                               |
| alarm           | Display message and title with three user choices.        |
| list-dialog     | List choices for one or more selection, opt. w/ defaults. |
| open            | create the IUP system                                     |
| close           | shutdown the IUP system                                   |
| image-lib-open  | open the widget library                                   |
| main-loop       | start an event loop on user inputs                        |
| set-language        | Set the language to English, Portugese or Spanish.    |
| get-language        | Get the language.                                     |
| version             | Get the IUP library version.                          |
| get-version         | Get the IUP library version.                          |
| get-version-date    | Return version's date.                                |
|  get-version-number | Get version number.                                   |


Sample GUI:

<p align="center">
<img src="https://raw.github.com/mrhdias/perl6-IUP/master/examples/images/widgets.png" alt="Hello World IUP Application"/>
</p>

Sample code:

```Raku
use IUP;

# initialize iup
my $iup = IUP.new;

$iup.image-lib-open;
$iup.open;

# create widgets and set their attributes

my $btn = $iup.button("&Ok", "");

$btn.set-callback("ACTION", &exit_callback);

$btn.set-attr("IMAGE", "IUP_ActionOk");
$btn.set-attr("EXPAND", "YES");
$btn.set-attr("TIP", "Exit button");

my $lbl = $iup.label("Hello, world!");

my $vb = $iup.vbox($lbl, $btn);
$vb.set-attr("MARGIN", "10x10");
$vb.set-attr("GAP", "10");
$vb.set-attribute("ALIGNMENT", "ACENTER");

my $dlg = $iup.dialog($vb);
$dlg.set_attribute("TITLE", "Hello");

# Map widgets and show dialog

$dlg.show;

# Wait for user interaction

$iup.main-loop;

# Clean up

$dlg.destroy;
$iup.close;

exit;

sub exit-callback( --> Int) {
    return IUP_CLOSE;
}

```
Authors and Contributors
------
Henrique Dias <mrhdias@gmail.com>
Naoum Hankache <naoum88@gmail.com>
Tobias Leich <email@froggs.de>
Zoffix Znet <cpan@zoffix.com>
David Warring <david.warring@gmail.com>
Robert Ransbottom <rirans@comcast.net>

Blame
------
Robert Ransbottom, as I am changing the name of the distribution, the
style of the code, and extending the Raku coverage of the Tecgraf-Puc-rio
C library.


See Also
--------
* [Raku IUP Module Documentation][1]
* [IUP Site][2]
* [IUP on SourceForge][3]

License
-------

This library is free software; you can redistribute it and/or modify it under the same terms as Raku itself.

[1]: lib/IUP.rakudoc "Raku IUP Module Documentation"
[2]: http://www.tecgraf.puc-rio.br/iup/ "IUP - Portable User Interface"
[3]: https://sourceforge.net/projects/iup/ "IUP Source Repository"
