Raku IUP ![IUP Logo](logotype/logo_32x32.png)
=========
Raku interface to the IUP toolkit for building GUI's.

| Operating System  |   Build Status  |
| ----------------- | --------------- |
| Linux		    | None |

Description
-----------
[IUP][2] is a multi-platform toolkit for
building graphical user interfaces. IUP's purpose is to allow a program
source code to be compiled in different systems without any modification.
Its main advantages are:

* It offers a simple API.
* High performance, due to the fact that it uses native interface elements.
* Fast learning by the user, due to the simplicity of its API.

Installation
------------
Get the IUP library and install it:

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

Sample GUI:

<p align="center">
<img src="https://raw.github.com/mrhdias/perl6-IUP/master/examples/images/widgets.png" alt="Hello World IUP Application"/>
</p>

Sample code:

```Raku
use IUP;

my @argv = ("Test");

#
# initialize iup
#

my $iup = IUP.new();

$iup.image_lib_open();
$iup.open(@argv);

#
# create widgets and set their attributes
#

my $btn = $iup.button("&Ok", "");

$btn.set_callback("ACTION", &exit_callback);

$btn.set_attribute("IMAGE", "IUP_ActionOk");
$btn.set_attribute("EXPAND", "YES");
$btn.set_attribute("TIP", "Exit button");

my $lbl = $iup.label("Hello, world!");

my $vb = $iup.vbox($lbl, $btn);
$vb.set_attribute("MARGIN", "10x10");
$vb.set_attribute("GAP", "10");
$vb.set_attribute("ALIGNMENT", "ACENTER");

my $dlg = $iup.dialog($vb);
$dlg.set_attribute("TITLE", "Hello");

#
# Map widgets and show dialog
#

$dlg.show();

#
# Wait for user interaction
#

$iup.main_loop();

#
# Clean up
#

$dlg.destroy();
$iup.close();

exit();

sub exit_callback() returns Int {
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
Robert Ransbottom, as I am changing the name of the distribution, the style of the code, and extending the coverage of the Tecgraf-Puc-rio C library.


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
