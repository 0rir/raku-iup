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

    sub p6IupFree(Ptr) is native(IUP_l) {*};

    ### Callbacks

    sub p6IupSetCallback_void(Ihdle, Str, &cb (--> int32) -->IUP::Callback)
            is native(IUP_l) {*};

    sub p6IupSetCallback_handle(Ihdle, Str, &cb (Ihdle -->int32)
            -->IUP::Callback) is native(IUP_l) {*};

    ###

    sub IupDestroy(Ihdle) is native(IUP_l) {*};

    sub IupAppend(Ihdle $ih, Ihdle $child -->Ihdle) is native(IUP_l) {*};

    sub IupInsert(Ihdle $ih, Ihdle $ref_child, Ihdle $child -->Ihdle)
            is native(IUP_l) {*};

    sub IupGetChild(Ihdle, int32 -->Ihdle) is native(IUP_l) {*};

    sub IupGetNextChild(Ihdle $ih, Ihdle $child -->Ihdle) is native(IUP_l) {*};

    sub IupGetParent(Ihdle -->Ihdle) is native(IUP_l) {*};

    sub IupGetDialog(Ihdle -->int32) is native(IUP_l) {*};

    ###

    sub IupPopup(Ihdle, int32, int32 -->int32) is native(IUP_l) {*};

    sub IupShow(Ihdle -->int32) is native(IUP_l) {*};

    sub IupShowXY(Ihdle, int32, int32 -->int32) is native(IUP_l) {*};

    sub IupHide(Ihdle -->int32) is native(IUP_l) {*};

    sub IupMap(Ihdle -->int32) is native(IUP_l) {*};

    ###

    sub IupSetAttribute(Ihdle, Str, Str) is native(IUP_l) {*};

    sub IupStoreAttribute(Ihdle, Str, Str) is native(IUP_l) {*};

    sub IupSetAttributes(Ihdle, Str -->Ihdle) is native(IUP_l) {*};

    sub IupGetAttribute(Ihdle, Str -->Str) is native(IUP_l) {*};

    sub IupGetAttributes(Ihdle -->Str) is native(IUP_l) {*};

    sub IupGetGlobal( Str -->Str) is native(IUP_l) is export {*}

    sub IupGetInt(Ihdle, Str -->int32) is native(IUP_l) {*};
 
    ###

    sub IupSetCallback(Ihdle, Str, IUP::Callback -->IUP::Callback)
            is native(IUP_l) {*};

    ###

    sub IupSetHandle(Str, Ihdle -->Ihdle) is native(IUP_l) {*};

    ###

    sub IupSetAttributeHandle(Ihdle $ih, Str $name, Ihdle $ih_named)
            is native(IUP_l) {*};

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

    # http://www.tecgraf.puc-rio.br/iup/en/func/iupsetattribute.html
    method set_attribute(Str $name, Str $value -->Mu) {
        #IupSetAttribute(self, $name, $value);
        IupStoreAttribute(self, $name, $value);
    }

    # numeric keys
    multi method set_attributes(*@attributes -->Ihdle) {
        my Str @tmp = ();
        for @attributes.values -> $pair {
            my ($name, $value) = $pair.kv;
            push(@tmp, join("=", $name, "\"$value\""));
        }
        my $string = join(", ", @tmp).Str;
        return IupSetAttributes(self, $string);
    }

    multi method set_attributes(*%attributes -->Ihdle) {
        my Str @tmp = ();
        for %attributes.kv -> Str $name, $value {
            push(@tmp, join("=", $name, "\"$value\""));
        }
        return IupSetAttributes(self, join(", ", @tmp).Str);
    }

    method get_attribute(Str $name -->Str) { IupGetAttribute(self, $name) }

    method get_attributes( -->Str) { IupGetAttributes(self) }

    method get_global( $attr -->Str) { IupGetGlobal( $attr) } #DEPRECATE
    method get-global( $attr -->Str) { IupGetGlobal( $attr) }

    method get_int(Str $name -->Int) { IupGetInt(self, $name) }

    ###

    method set_callback(Str $name, $func -->IUP::Callback) {
        my @params = $func.signature.params;
        given @params.elems {
            when 0 {
# TODO check refactor for correctness
#return p6IupSetCallback_void(self, $name.fmt("%s").Str, $func);
                      return p6IupSetCallback_void(self, $name.fmt, $func)
            }
            when 1 {
#return p6IupSetCallback_handle(self, $name.fmt("%s").Str, $func);
                      return p6IupSetCallback_handle(self, $name.fmt, $func)
            }
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

    method set_handle(Str $name -->Ihdle) { IupSetHandle($name, self) }

    ###

    method set_attribute_handle(Str $name, Ihdle $ih_named -->Mu) {
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

    method item(Str $title, Str $action -->Ihdle) { p6IupItem($title, $action) } 
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

    method text(Str $action -->Ihdle) { p6IupText($action) }

    ###

    method message(Str $title, Str $message -->Mu) {
        IupMessage($title, $message)
    }
}

class IUP is IUP::Handle {

    sub p6IupOpen(int32, CArray[Str] -->int32) is native(IUP_l) {*};

    sub IupClose() is native(IUP_l) {*};

    sub IupImageLibOpen() is native(IUP_l) {*};

    sub IupMainLoop( -->int32) is native(IUP_l) {*};

    #sub IupLoopStep( -->int32) is native(IUP_l) {*};

    #sub IupLoopStepWait( -->int32) is native(IUP_l) {*};

    #sub IupMainLoopLevel( -->int32) is native(IUP_l) {*};

    #sub IupFlush() is native(IUP_l) {*};

    #sub IupExitLoop() is native(IUP_l) {*};

    ###
    sub IupVersion(-->str) is export is native(IUP_l) {*}

    sub IupVersionNumber(-->int32) is export is native(IUP_l) {*}

    sub IupVersionDate(-->Str) is native(IUP_l) is export {*}

    sub IupSetLanguage(Str) is native(IUP_l) {*};

    sub IupGetLanguage( -->Str) is native(IUP_l) {*};

    ### METHODS ###

    method open(@argv = () -->int32) {
        my $argc = @argv.elems;
        my $arglist := CArray[Str].new();

        my $i = 0;
        for @argv -> $a {
            $arglist[$i] = $a;
            $i++;
        }
        return p6IupOpen($argc, $arglist);
    }

    method close(-->Mu) { IupClose(); }

    method image_lib_open(-->Mu) { IupImageLibOpen(); }

    method main_loop(-->int32) { return IupMainLoop(); }

#   method loop_step(Bool $wait = False -->Mu) {
#       return $wait ?? IupLoopStepWait() !! IupLoopStep();
#   }

#   method main_loop_level(-->int32) { IupMainLoopLevel }
#   method flush(-->Mu) { IupFlush }
#   method exit_loop(-->Mu) { IupExitLoop }

    ###

    method set_language(Str $language) { IupSetLanguage($language) }

    method get_language( -->Str) { IupGetLanguage }
}
