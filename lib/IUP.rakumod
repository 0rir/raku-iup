# :vim ft=raku sw=4 expandtab
use NativeCall;

# Abbreviations
sub IUP_l() { quietly return %?RESOURCES<lib/IUP.so>.Str}

#
# Callback Return Values
#
constant IUP_IGNORE   = -1;
constant IUP_DEFAULT  = -2;
constant IUP_CLOSE    = -3;
constant IUP_CONTINUE = -4;

#
# IupPopup and IupShowXY Parameter Values
#
constant IUP_CENTER       = 0xFFFF;  # 65535
constant IUP_LEFT         = 0xFFFE;  # 65534
constant IUP_RIGHT        = 0xFFFD;  # 65533
constant IUP_MOUSEPOS     = 0xFFFC;  # 65532
constant IUP_CURRENT      = 0xFFFB;  # 65531
constant IUP_CENTERPARENT = 0xFFFA;  # 65530
constant IUP_TOP          = IUP_LEFT;
constant IUP_BOTTOM       = IUP_RIGHT;

#
# Color Space
#
constant IUP_RGB  = 1;
constant IUP_RGBA = 2;

class IUP::Pixmap {
    method load(@data) {
        my $image = CArray[int8].new();
        my $i = 0;
        for @data -> $c {
            if 0 > $c.Int > 255 {
                say "Error loading Pixmap...";
                exit();
            }
            $image[$i++] = $c.Int;
        }
        return $image;
    }
}

class IUP::Callback is repr('CPointer') {}

class IUP::Handle is repr('CPointer') {

    constant Ihdle = IUP::Handle;
    constant Ptr = Pointer;

    sub p6IupNewChildrenList(int32 -->Ptr) is native(IUP_l) {*};

    sub p6IupAddChildToList(Ptr, Ihdle, int32, int32) is native(IUP_l) {*};

    # Free memory.
    sub p6IupFree(Ptr) is native(IUP_l) {*};

    ### Callbacks

    sub p6IupSetCallback_void(Ihdle, Str, &cb (--> int32) -->IUP::Callback)
            is native(IUP_l) {*};

    sub p6IupSetCallback_handle(Ihdle, Str, &cb (Ihdle -->int32)
            -->IUP::Callback) is native(IUP_l) {*};

    ###
    # Destroy an widget.
    sub IupDestroy(Ihdle) is native(IUP_l) {*};

    # Append a child to a widget's child list.
    sub IupAppend(Ihdle $ih, Ihdle $child -->Ihdle) is native(IUP_l) {*};

    # Insert $child into a $ih's child list before $ref_child.
    sub IupInsert(Ihdle $ih, Ihdle $ref_child, Ihdle $child -->Ihdle)
            is native(IUP_l) {*};

    # Get a child of widget by index into child-list.
    sub IupGetChild(Ihdle, int32 -->Ihdle) is native(IUP_l) {*};

    # Get a child of widget after the $child (aka the brother).
    sub IupGetNextChild(Ihdle $ih, Ihdle $child -->Ihdle) is native(IUP_l) {*};

    # Return the parent of a control.
    sub IupGetParent(Ihdle -->Ihdle) is native(IUP_l) {*};

    # Return the dialog that contains the interface element.
    sub IupGetDialog(Ihdle -->int32) is native(IUP_l) {*};

    ###

    sub IupPopup(Ihdle, int32, int32 -->int32) is native(IUP_l) {*};

    sub IupShow(Ihdle -->int32) is native(IUP_l) {*};

    sub IupShowXY(Ihdle, int32, int32 -->int32) is native(IUP_l) {*};

    # Hides an element; like IupSetAttribute("VISIBLE", "NO")
    sub IupHide(Ihdle -->int32) is native(IUP_l) {*};
    # Adds an elem and its children into the abstract layout.
    sub IupMap(Ihdle -->int32) is native(IUP_l) {*};

    ###
    # Store only a constant string (or application ptr) by reference.
    sub IupSetAttribute(Ihdle, Str, Str) is native(IUP_l) {*};

    # Store a copy of the given string.
    sub IupSetStrAttribute( Ihdle, Str, Str ) is native(IUP_l) {*};
    # Old name for IupSetStrAttribute
    sub IupStoreAttribute(Ihdle, Str, Str) is native(IUP_l) {*};    #DEPRECATE

    sub IupSetAttributes(Ihdle, Str -->Ihdle) is native(IUP_l) {*};

    sub IupGetAttribute(Ihdle, Str -->Str) is native(IUP_l) {*};

    sub IupGetAttributes(Ihdle -->Str) is native(IUP_l) {*};

    sub IupSetGlobal( Str, Str)     is native(IUP_l) is export {*}

    sub IupSetStrGlobal( Str, Str)  is native(IUP_l) is export {*}

    sub IupGetGlobal( Str -->Str)   is native(IUP_l) is export {*}

    sub IupGetInt(Ihdle, Str -->int32) is native(IUP_l) {*};

    ###

    # Attach a callback to an event, returns any displaced cb.
    sub IupSetCallback(Ihdle, Str, IUP::Callback -->IUP::Callback)
            is native(IUP_l) {*};

    ###

    sub IupSetHandle(Str, Ihdle -->Ihdle) is native(IUP_l) {*};

    ###

    sub IupSetAttributeHandle(Ihdle $ih, Str $name, Ihdle $ih_named)
            is native(IUP_l) {*};

    sub IupFileDlg(    -->Ihdle) is native(IUP_l) is export {*}

    sub IupMessageDlg( -->Ihdle) is native(IUP_l) is export {*}

    sub IupColorDlg(   -->Ihdle) is native(IUP_l) is export {*}

    sub IupFontDlg(    -->Ihdle) is native(IUP_l) is export {*}

    sub IupProgressDlg(-->Ihdle) is native(IUP_l) is export {*}

    ###

    sub IupFill( -->Ihdle) is native(IUP_l) {*};

    sub p6IupVbox(Ihdle -->Ihdle) is native(IUP_l) {*};

    sub IupVboxv(Ptr -->Ihdle) is native(IUP_l) {*};

    sub p6IupHbox(Ihdle -->Ihdle) is native(IUP_l) {*};

    sub IupHboxv(Ptr -->Ihdle) is native(IUP_l) {*};

    ###

    sub IupFrame(Ihdle $child -->Ihdle) is native(IUP_l) {*};

    ###

    sub IupImage(int32, int32, CArray[int8] -->Ihdle) is native(IUP_l) {*};

    sub IupImageRGB(int32, int32, CArray[int8] -->Ihdle) is native(IUP_l) {*};

    sub IupImageRGBA(int32, int32, CArray[int8] -->Ihdle) is native(IUP_l) {*};

    ###

    sub p6IupItem(Str, Str -->Ihdle) is native(IUP_l) {*};

    sub IupSubmenu(Str, Ihdle -->Ihdle) is native(IUP_l) {*};

    sub IupSeparator( -->Ihdle) is native(IUP_l) {*};

    sub p6IupMenu(Ihdle -->Ihdle) is native(IUP_l) {*};

    sub IupMenuv(Ptr -->Ihdle) is native(IUP_l) {*};

    ###

    sub p6IupButton(Str $title, Str $action -->Ihdle) is native(IUP_l) {*};

    sub IupCanvas(Str $action -->Ihdle) is native(IUP_l) {*};

    sub IupDialog(Ihdle -->Ihdle) is native(IUP_l) {*};

    sub IupLabel(Str -->Ihdle) is native(IUP_l) {*};

    sub p6IupText(Str $action -->Ihdle) is native(IUP_l) {*};

    ###

    sub IupMessage(Str $title, Str $message) is native(IUP_l) {*};

    multi sub IupListDialog(        # NATIVE
            int32 $type             # 1 = chose one,  2 = multiple choices
            , Str $title            # widget title
            , int32 $size           # size of $list
            , CArray[Str] $list     # list to display as choice
            , int32 $op             # choice if $type = 1
            , int32 $max_col        # visible columns
            , int32 $max_lin        # visible lines
            , CArray[int32] $marks  # if $type=2, ($mark[n] == 1) means
                                    # $list[n] selected
            -->int32 )
            is native(IUP_l) is export {*}

    sub int32-ro( $i -->int32) { my int32 $ = $i }

    # For single selection only.
    # Returns -1 if action cancelled or index of selection from $list).
    multi sub IupListDialog( Str $title, Array[Str] $list,
            Int $op is rw, Int $max_col, Int $max_lin -->Int) is export {
        my $size = $list.elems;
        my CArray[Str] $listN = CArray[Str].new;
        my CArray[int32] $marks = CArray[int32].new;
        for ^$size {
            $listN[$_] = $list[$_];
            $marks[$_] = 0;
        }
        my int32 $sizeN = $size;

        return IupListDialog( int32-ro(1), $title, $sizeN, $listN,
            int32-ro($op), int32-ro($max_col), int32-ro($max_lin), $marks);
    }

    # IupListDialog for multiple selections from list
    multi sub IupListDialog( Str $title, Array[Str] $list, Int $max_col,
            Int $max_lin, --> Array) is export {

        my int32 $type = 2;                # multiple choices
        my int32 $size = $list.elems;      # number of choices available
        my int32 $op;
        my CArray[Str] $listN = CArray[Str].new;       # list of choices
        my CArray[int32] $marks = CArray[int32].new;  # selections made
        for ^$size {
            $listN[$_] = $list[$_];
            $marks[$_] = 0;
        }

        my int32 $status = IupListDialog( int32-ro($type), $title, $size,
                $listN, int32-ro($op), int32-ro($max_col),
                int32-ro($max_lin), $marks);
        return [] if $status == -1;
        my @return;
        for 0 .. $size -1 {
            if $marks[$_] { @return.push( $listN[$_]); }
        }
        @return;
    }

    ### METHODS ###

    method destroy( -->Mu) { IupDestroy(self) }

    method append(Ihdle $child -->Ihdle) { IupAppend(self, $child) }

    method insert(Ihdle $ref_child, Ihdle $child -->Ihdle) {
        IupInsert(self, $ref_child, $child)
    }

    method get_child($position -->Ihdle) { IupGetChild(self, $position) }

    method get_next_child(Ihdle $child -->Ihdle) {
        IupGetNextChild(self, $child)
    }

    method get_parent(-->Ihdle) { IupGetParent(self) }

    method get_dialog(-->int32) { IupGetDialog(self) }

    ###

    method popup(Int $x, Int $y -->int32) { IupPopup(self, $x, $y) }

    multi method show(-->int32) { IupShow(self) }

    multi method show(Int $x, Int $y -->int32) { IupShowXY(self, $x, $y) }

    method hide(-->int32) { IupHide(self) }

    method map(-->int32) { IupMap(self) }

    ###

    # XXX
    # This is a new set of attribute setting multi methods.  TMP name setattr
    multi method setattr( Str:D $k, Str:D $v, Bool :$ref -->Mu) {
        $ref ??  IupStoreAttribute(self, $k, $v)
             !!  IupSetAttribute(self, $k, $v)
    }
    multi method setattr( *@attr, Bool :$ref -->Ihdle) {
        my Str @tmp;
        for @attr -> $k, $v  {
            @tmp.push:  qq{$h="$t"};
        }
        $ref ?? IupStoreAttribute self, @tmp.join( ', ')
             !! IupSetAttribute   self, @tmp.join( ', ');
    }
    multi method setattr( %attr, Bool :$ref! ) {
        my Str @tmp;
        for %attr.kv -> $k, $v  {
            @tmp.push: qq{$k="$v"};
        }
        $ref ?? IupStoreAttribute self, @tmp.join( ', ')
             !! IupSetAttribute   self, @tmp.join( ', ');
    }


    multi method set_attributes(*%attrs) {
        DEPRECATED('set-attrs','0.0.2','0.0.3', :what( &?ROUTINE.name));
        set-attrs( %attrs);
    }
    multi method set-attributes(*%attrs) {
        DEPRECATED('set-attrs','0.0.2','0.0.3', :what( &?ROUTINE.name));
    }
    multi method set-attrs(*%attrs) {
        my Str @tmp = ();
        for %attrs.kv -> Str $name, $value {
            push(@tmp, join("=", $name, "\"$value\""));
        }
        return IupSetAttributes(self, join(", ", @tmp).Str);
    }

    # XXX The naming of these set-attr* method reverse the sense of
    # the underlying C functions IupSetAttribute vs SetStrAttribute,
    # which respectively set by reference and set by value.  Copying
    # is the usual for Raku.
    #
    # Consider using only the 'set-attr*' and a flag ':ref' for the
    # distinction. And/or variant names or name. XXX

    # http://www.tecgraf.puc-rio.br/iup/en/func/iupsetattribute.html
    method set_attribute(Str $name, Str $value -->Mu) {
        DEPRECATED('set-attr','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupSetStrAttribute(self, $name, $value);
    }
    method set-attribute(Str $name, Str $value -->Mu) {
        IupSetStrAttribute(self, $name, $value);
    }
    method set-attr(     Str $name, Str $value -->Mu) {
        IupSetStrAttribute(self, $name, $value);
    }

    multi method set_attributes(*%attributes -->Ihdle) {
        my Str @tmp = ();
        for %attributes.kv -> Str $name, $value {
            push(@tmp, join("=", $name, "\"$value\""));
        }
        return IupSetAttributes(self, join(", ", @tmp).Str);
    }

    # Get an attrib by name.
    method get-attr(Str $name -->Str) {      IupGetAttribute(self, $name) }
    method get-attribute(Str $name -->Str) { IupGetAttribute(self, $name) }
    method get_attribute(Str $name -->Str) {
        DEPRECATED('get-attr','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupGetAttribute(self, $name)
    }

    method get-attrs( -->Str) {      IupGetAttributes(self) }
    method get-attributes( -->Str) { IupGetAttributes(self) }
    method get_attributes( -->Str) {
        DEPRECATED('get-attrs','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupGetAttributes(self)
    }

    method get-global( $attr -->Str) { IupGetGlobal( $attr) }
    method get_global( $attr -->Str) {
        DEPRECATED('get-global','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupGetGlobal( $attr)
    }

    method set-global( Str $k, Str $v -->Mu) { IupSetGlobal($k,$v) }
    method set_global( Str $k, Str $v -->Mu) {
        DEPRECATED('set-global','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupSetStrGlobal($k,$v)
    }
    method set-str-global( Str $k, Str $v -->Mu) { IupSetStrGlobal($k,$v) }
    method set_str_global( Str $k, Str $v -->Mu) {
        DEPRECATED('set-str-global','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupSetStrGlobal($k,$v)
    }


    method get_int(Str $name -->Int) { IupGetInt(self, $name) }

    ###

    method set_callback(Str $name, $func -->IUP::Callback) {
        DEPRECATED('set-callback','0.0.2','0.0.3', :what( &?ROUTINE.name));
        self.set-callback( $name, $func)
    }
    method set-callback(Str $name, $func -->IUP::Callback) {
        my @params = $func.signature.params;
        given @params.elems {
            when 0 { return p6IupSetCallback_void(  self, $name.fmt, $func) }
            when 1 { return p6IupSetCallback_handle(self, $name.fmt, $func) }
            default { say "Error... no callback"  }
        }
    }

    method set_callbacks(*%callbacks -->Ihdle) {
        for %callbacks.kv -> $name, $function {
            self.set_callback($name, $function);
        }
        return self;
    }

    ###

    method set-handle(Str $name -->Ihdle) { IupSetHandle($name, self) }
    method set_handle(Str $name -->Ihdle) {
        DEPRECATED('main-loop','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupSetHandle($name, self)
    }
    ###

    method set-attribute-handle(Str $name, Ihdle $ih_named -->Mu) {
        IupSetAttributeHandle(self, $name, $ih_named);
    }
    method set_attribute_handle(Str $name, Ihdle $ih_named -->Mu) {
        DEPRECATED('set-attribute-handle','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupSetAttributeHandle(self, $name, $ih_named);
    }

    ###

    method fill(-->Ihdle) { IupFill() }

    method vboxv(*@child -->Ihdle) {
        my $n = @child.elems;
        if $n > 1 {
            my $list = p6IupNewChildrenList($n);
            my $pos = 0;
            for @child -> $c {
                p6IupAddChildToList($list, $c, $pos, $n);
                $pos++;
            }
            my $result = IupVboxv($list);
            p6IupFree($list);
            return $result;
        }
        if $n == 1 {
            return p6IupVbox(@child[0]);
        }
    }

    method vbox(*@child -->Ihdle) { self.vboxv(@child); }

    method hboxv(*@child -->Ihdle) {
        my $n = @child.elems;
        if $n > 1 {
            my $list = p6IupNewChildrenList($n);
            my $pos = 0;
            for @child -> $c {
                p6IupAddChildToList($list, $c, $pos, $n);
                $pos++;
            }
            my $result = IupHboxv($list);
            p6IupFree($list);
            return $result;
        }
        if $n == 1 {
            return p6IupHbox(@child[0]);
        }
    }

    method hbox(*@child -->Ihdle) { self.hboxv(@child); }

    ###

    method frame($child -->Ihdle) { IupFrame($child); }

    ###

    method image(
        Int $width where $width > 0,
        Int $height where $height > 0,
        $pixels,
        Int $color_space where 0..IUP_RGBA = 0 -->Ihdle) {

        given $color_space {
            when IUP_RGB { return IupImageRGB($width, $height, $pixels); }
            when IUP_RGBA { return IupImageRGBA($width, $height, $pixels); }
            default { return IupImage($width, $height, $pixels); }
        }
    }

    ###

    method item(Str $title, Str $action -->Ihdle) { p6IupItem($title, $action)}
    method submenu(Str $title, $child -->Ihdle) { IupSubmenu($title, $child) }

    method separator(-->Ihdle) { IupSeparator }

    method menuv(*@child -->Ihdle) {
        my $n = @child.elems;
        if $n > 1 {
            my $list = p6IupNewChildrenList($n);
            my $pos = 0;
            for @child -> $c {
                p6IupAddChildToList($list, $c, $pos, $n);
                $pos++;
            }
            my $result = IupMenuv($list);
            p6IupFree($list);
            return $result;
        }
        if $n == 1 {
            return p6IupMenu(@child[0]);
        }
    }

    method menu(*@child -->Ihdle) { self.menuv(@child) }

    ###

    method button(Str $title, Str $action -->Ihdle) {
        p6IupButton($title, $action);
    }

    method canvas(Str $action -->Ihdle) { IupCanvas($action) }

    method dialog($child -->Ihdle) { IupDialog($child) }

    method label(Str $str -->Ihdle) { IupLabel($str) }

    method text(Str $action = '' -->Ihdle) { p6IupText($action) }

    ###

    method message(Str $title, Str $message -->Mu) {
        IupMessage($title, $message)
    }
}

class IUP is IUP::Handle {

    # Must be called before any other IUP function.
    sub p6IupOpen(int32, CArray[Str] -->int32) is native(IUP_l) {*};

    # Ends IUP usage releasing memory. It destroys all named dialogs & elems.
    sub IupClose() is native(IUP_l) {*};

    sub IupImageLibOpen() is native(IUP_l) {*};

    # Starts loop on interaction that stops when a callback returns IUP_CLOSE,
    # IupExitLoop is called, or all dialogs are hidden.
    sub IupMainLoop( -->int32) is native(IUP_l) {*};

    #sub IupLoopStep( -->int32) is native(IUP_l) {*};

    #sub IupLoopStepWait( -->int32) is native(IUP_l) {*};

    #sub IupMainLoopLevel( -->int32) is native(IUP_l) {*};

    #sub IupFlush() is native(IUP_l) {*};

    #sub IupExitLoop() is native(IUP_l) {*};

    ###
    # Return version string
    sub IupVersion(-->str) is export is native(IUP_l) {*}

    # Return version number.
    sub IupVersionNumber(-->int32) is export is native(IUP_l) {*}

    # Return version's date.
    sub IupVersionDate(-->Str) is native(IUP_l) is export {*}

    # Sets the user language: English, Portuguese or Spanish
    sub IupSetLanguage(Str) is native(IUP_l) {*};

    # Gets the user language.
    sub IupGetLanguage( -->Str) is native(IUP_l) {*};

    ### METHODS ###

    method open(@argv = [,] -->int32) {
        my $argc = @argv.elems;
        my $arglist := CArray[Str].new();

        my $i = 0;
        for @argv -> $a {
            $arglist[$i] = $a;
            $i++;
        }
        return p6IupOpen($argc, $arglist);
    }

    method close(-->Mu) { IupClose }

    method image-lib-open(-->Mu) { IupImageLibOpen }
    method image_lib_open(-->Mu) {
        DEPRECATED('image-lib-open','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupImageLibOpen
    }

    method main-loop(-->int32) { IupMainLoop }
    method main_loop(-->int32) {
        DEPRECATED('main-loop','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupMainLoop
    }

#   method loop_step(Bool $wait = False -->Mu) {
#       return $wait ?? IupLoopStepWait() !! IupLoopStep();
#   }

#   method main_loop_level(-->int32) { IupMainLoopLevel }
#   method flush(-->Mu) { IupFlush }
#   method exit_loop(-->Mu) { IupExitLoop }

    ###

    method set-language(Str $language) { IupSetLanguage($language) }
    method set_language(Str $language) {
        DEPRECATED('set-language','0.0.2','0.0.3', :what( &?ROUTINE.name));
        self.set-language($language)
    }

    method get_language( -->Str) { IupGetLanguage }
}
