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

    # Destroy an widget.
    sub IupDestroy(Ihdle) is native(IUP_l) {*};

    # IupDetach

    # Append a child to a widget's child list.
    sub IupAppend(Ihdle $ih, Ihdle $child -->Ihdle) is native(IUP_l) {*};

    # Insert $child into a $ih's child list before $ref_child.
    sub IupInsert(Ihdle $ih, Ihdle $ref_child, Ihdle $child -->Ihdle)
            is native(IUP_l) {*};

    # Get a child of widget by index into child-list.
    sub IupGetChild(Ihdle, int32 -->Ihdle) is native(IUP_l) {*};

    # IupGetChildPos IupGetChildCount

    # Get a child of widget after the $child (aka the brother).
    sub IupGetNextChild(Ihdle $ih, Ihdle $child -->Ihdle) is native(IUP_l) {*};

    # IupGetBrother

    # Return the parent of a control.
    sub IupGetParent(Ihdle -->Ihdle) is native(IUP_l) {*};

    # Return the dialog that contains the interface element.
    sub IupGetDialog(Ihdle -->int32) is native(IUP_l) {*};

    sub IupGetDialogChild(Ihdle $ih, Str $name -->Ihdle)is native(IUP_l) {*}

    #IupReparent

    sub IupPopup(Ihdle, int32, int32 -->int32) is native(IUP_l) {*};

    sub IupShow(Ihdle -->int32) is native(IUP_l) {*};

    sub IupShowXY(Ihdle, int32, int32 -->int32) is native(IUP_l) {*};

    # Hides an element; like IupSetAttribute("VISIBLE", "NO")
    sub IupHide(Ihdle -->int32) is native(IUP_l) {*};

    # Adds an elem and its children into the abstract layout.
    sub IupMap(Ihdle -->int32) is native(IUP_l) {*};

    # IupUnmap IupResetAttribute IupGetAllAttributes
    # IupCopyAttributes IupSetAtt

    sub IupSetAttributes(Ihdle, Str -->Ihdle) is native(IUP_l) {*};

    sub IupGetAttributes(Ihdle -->Str) is native(IUP_l) {*};

    # Store only a constant string (or application ptr) by reference.
    sub IupSetAttribute(Ihdle, Str, Str) is native(IUP_l) {*};

    # Store a copy of the given string.
    sub IupSetStrAttribute( Ihdle, Str, Str ) is native(IUP_l) {*};

    # IupSetStrf IupSetInt IupSetFloat IupSetDouble IupSetRGB IupSetRGBA

    sub IupGetAttribute(Ihdle, Str -->Str) is native(IUP_l) {*};

    sub IupGetInt(Ihdle, Str -->int32) is native(IUP_l) {*};

    sub IupGetInt2(Ihdle $ih, Str $name -->int32) is native(IUP_l) {*}

    sub IupGetIntInt( Ihdle $ih, Str $nam, Ptr[int32] $i1, Ptr[int32] $i2
            -->int32) is native(IUP_l) {*}

    sub IupGetFloat(Ihdle $ih, Str $nam -->num32) is native(IUP_l) {*}

    sub IupGetDouble(Ihdle $ih, Str $nam -->num64) is native(IUP_l) {*}

    # IupGetRGB IupGetRGBA
    # IupSetAttributeId IupSetStrAttributeId IupSetStrfId IupSetIntId
    # IupSetFloatId IupSetDoubleId IupSetRGBId IupGetAttributeId
    # IupGetIntId IupGetFloatId IupGetDoubleId IupGetRGBId
    # IupSetAttributeId2 IupSetStrAttributeId2 IupSetStrfId2
    # IupSetIntId2 IupSetFloatId2 IupSetDoubleId2 IupSetRGBId2
    # IupGetAttributeId2 IupGetIntId2 IupGetFloatId2 IupGetDoubleId2
    # IupGetRGBId2

    sub IupSetGlobal( Str, Str)     is native(IUP_l) is export {*}

    sub IupSetStrGlobal( Str, Str)  is native(IUP_l) is export {*}

    sub IupGetGlobal( Str -->Str)   is native(IUP_l) is export {*}

    sub IupSetFocus(Ihdle $ih -->Ihdle) is native(IUP_l) is export {*}

    sub IupGetFocus(-->Ihdle) is native(IUP_l) is export {*}

    # IupPreviousField IupNextField IupGetCallback

    ### Callbacks

    sub p6IupSetCallback_void(Ihdle, Str, &cb (--> int32) -->IUP::Callback)
            is native(IUP_l) {*};

    sub p6IupSetCallback_handle(Ihdle, Str, &cb (Ihdle -->int32)
            -->IUP::Callback) is native(IUP_l) {*};

    # Attach a callback to an event, returns any displaced cb.
    sub IupSetCallback(Ihdle, Str, IUP::Callback -->IUP::Callback)
            is native(IUP_l) {*};


    # IupSetCallbacks IupGetFunction IupSetFunction

    # Returns the handle of an element that was tagged/named by IupSetHandle
    sub IupGetHandle(Str $name -->Ihdle) is native(IUP_l) {*}

    # Associates a name with an interface element
    sub IupSetHandle(Str, Ihdle -->Ihdle) is native(IUP_l) {*}

    # IupGetAllNames IupGetAllDialogs IupGetName

    sub IupSetAttributeHandle(Ihdle $ih, Str $name, Ihdle $ih_named)
            is native(IUP_l) {*};

    # IupGetAttributeHandle IupSetAttributeHandleId IupGetAttributeHandleId
    # IupSetAttributeHandleId2 IupGetAttributeHandleId2
    # IupGetClassName
    # IupGetClassType IupGetAllClasses IupGetClassAttributes
    # IupGetClassCallbacks IupSaveClassAttributes IupCopyClassAttributes
    # IupSetClassDefaultAttribute IupClassMatch
    # IupCreate IupCreatev IupCreatep

    sub IupFill( -->Ihdle) is native(IUP_l) {*};

    # IupSpace

    sub IupRadio(Ihdle $child -->Ihdle) is native(IUP_l) {*}

    sub p6IupVbox(Ihdle -->Ihdle) is native(IUP_l) {*};

    sub IupVboxv(Ptr -->Ihdle) is native(IUP_l) {*};

    sub p6IupZbox(Ihdle -->Ihdle) is native(IUP_l) {*}

    sub IupZboxv(Ptr -->Ihdle) is native(IUP_l) {*}

    sub p6IupHbox(Ihdle -->Ihdle) is native(IUP_l) {*};

    sub IupHboxv(Ptr -->Ihdle) is native(IUP_l) {*};

    # IupNormalizer IupNormalizerv

    sub IupCbox(Ihdle $child -->Ihdle) is native(IUP_l) is export {*}

    sub IupCboxv(Ptr $children -->Ihdle) is native(IUP_l) is export {*}

    # Make a container that lets its child be resized in one direction.
    sub IupSbox(Ihdle $child -->Ihdle) is native(IUP_l) is export {*}

    sub IupSplit(Ihdle $child1, Ihdle $child2 -->Ihdle)
            is native(IUP_l) is export {*}

    sub IupScrollBox(Ihdle $child -->Ihdle) is native(IUP_l) is export {*}

    # IupFlatScrollBox

    sub p6IupGridBox(Ihdle -->Ihdle) is native(IUP_l) {*};

    sub IupGridBoxv(Ptr -->Ihdle) is native(IUP_l) is export {*};

    sub p6IupMultiBox(Ihdle -->Ihdle) is native(IUP_l) is export {*}

    sub IupMultiBoxv(Ihdle -->Ihdle) is native(IUP_l) is export {*}

    sub IupExpander(Ihdle $child -->Ihdle) is native(IUP_l) is export {*}

    sub IupDetachBox(Ihdle $child -->Ihdle) is native(IUP_l) is export {*}

    sub IupBackgroundBox(Ihdle $child -->Ihdle) is native(IUP_l) is export {*}

    sub IupFrame(Ihdle $child -->Ihdle) is native(IUP_l) {*};

    # IupFlatFrame

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

    # IupFlatButton IupFlatToggle IupDropButton IupFlatLabel IupFlatSeparator

    sub IupCanvas(Str $action -->Ihdle) is native(IUP_l) {*};

    sub IupDialog(Ihdle -->Ihdle) is native(IUP_l) {*};

    # Make a elem to map a foreign thing to an elem, or to a stash attributes.
    sub IupUser(-->Ihdle) is native(IUP_l) {*}

    # IupThread

    sub IupLabel(Str -->Ihdle) is native(IUP_l) {*};

    # Make a dropdown or visible displayed list, may have editbox. AKA combobox.
    sub IupList( Str -->Ihdle) is native(IUP_l) is export {*};

    # IupFlatList

    sub p6IupText(Str $action -->Ihdle) is native(IUP_l) {*}

    sub p6IupMultiLine(Str $action -->Ihdle) is native(IUP_l) {*}

    sub IupToggle(Str $title, Str $action -->Ihdle) is native(IUP_l) {*}

    # IupTimer
    # IupClipboard IupProgressBar IupVal IupFlatVal IupFlatTree
    # IupTabs IupTabsv IupFlatTabs IupFlatTabsv
    # IupTree IupLink IupAnimatedLabel
    # IupDatePick IupCalendar IupColorbar IupGauge

    sub IupDial(Str $type -->Ihdle) is native(IUP_l) {*}

    # IupColorBrowser IupSpin IupSpinbox
    # IupStringCompare IupSaveImageAsText IupImageGetHandle
    # IupTextConvertLinColToPos IupTextConvertPosToLinCol IupConvertXYToPos
    # IupStoreGlobal

    # Old name for IupSetStrAttribute
    sub IupStoreAttribute(Ihdle, Str, Str) is native(IUP_l) {*};    #DEPRECATE

    # IupSetfAttribute IupStoreAttributeId IupSetfAttributeId
    # IupStoreAttributeId2 IupSetfAttributeId2

    # IupTreeSetUserId IupTreeGetUserId IupTreeGetId IupTreeSetAttributeHandle
    ###

    sub IupFileDlg(    -->Ihdle) is native(IUP_l) is export {*}

    sub IupMessageDlg( -->Ihdle) is native(IUP_l) is export {*}

    sub IupColorDlg(   -->Ihdle) is native(IUP_l) is export {*}

    sub IupFontDlg(    -->Ihdle) is native(IUP_l) is export {*}

    sub IupProgressDlg(-->Ihdle) is native(IUP_l) is export {*}

    # Shows a modal, native dialog to select a filename. Uses IupFileDlg.
    sub IupGetFile(Str $arg -->int32) is native(IUP_l) is export {*}

    # Makes a popup at center of screen with a message and an OK button, which
    # has to be pressed.
    sub IupMessage(Str $title, Str $message)  is native(IUP_l) is export {*};

    # XXX Before researching:
    # I don't know how to handle variadic C functions from Raku.  Th𝑒 params
    # mirror sprintf's.  My first plan is to format in Raku and use IupMessage
    # instead; hopefully that may be the last plan.
    # void IupMessagef(const char * title , const char * format, ... );
    #sub IupMessagef(Str $title, Str $format) is native(IUP_l) is export {*}

    #IupMessageError IupMessageAlarm

    # Returns pressed button number or 0 for noop
    sub IupAlarm( Str:D $title, Str:D $msg,
            Str:D $b1txt, Str $b2txt, Str $b3txt -->int32) is export
        is native(IUP_l) {*};

    # Make modal dialog to capture value with a format like the C stdio lib
    # scanf function. Deprecated upstream; use IupGetParam
    sub IupScanf(Str $format -->int32) is native(IUP_l) is export {*}

    multi sub IupListDialog(        # NATIVE
              int32 $type           # 1 = chose one,  2 = multiple choices
            , Str $title            # widget's title
            , int32 $size           # size of $list
            , CArray[Str] $list     # list to display for selection
            , int32 $presel         # highlighted selection when $type == 1
            , int32 $max_col        # displayed columns
            , int32 $max_lin        # displayed lines
            , CArray[int32] $markN  # if $type=2 then ($mark[n] == 1) means
                                    # $list[n] selected
            -->int32 )
            is native(IUP_l) is export {*}

    sub int32-ro( $i -->int32) { my int32 $ = $i }  # helper function
    constant &i32ro := &int32-ro;

    # For single selection, returns [] if cancelled else an array w/ one elem.
    # The zeroeth item is highlighted by default or out of bounds $presel
    multi sub IupListDialog( Str $title, Array[Str] $list, Int $presel is copy,
            Int $max_col, Int $max_lin, -->Array) is export {

        my int32 $sizeN = $list.elems;
        my $listN = CArray[Str].new;
        my $markN = CArray[int32].new;
        for ^$sizeN {
            $listN[$_] = $list[$_];
            $markN[$_] = 0;
        }
        $presel //= 0;
        ++$presel;
        given IupListDialog( i32ro(1), $title, $sizeN, $listN,
                i32ro($presel), i32ro($max_col), i32ro($max_lin), $markN) {
            when -1 { [] }
            default { [ $list[$_] ] }
        }
    }

    # IupListDialog for multiple, or single, selections from list
    # Here @hi contains Ints of the list items to pre-highlight origin 1.
    multi sub IupListDialog( Str $title, Array[Str] $list, @presel,
            Int $max_col, Int $max_lin -->Array) {

        my int32 $size = $list.elems;      # number of choices available
        my $listN = CArray[Str].new;       # list of choices
        my $markN = CArray[int32].new;     # selections made
        for ^$size {
            $listN[$_] = $list[$_];
            $markN[$_] = 0;
        }
        for @presel -> $i { if $i ~~ 1..$list.elems { $markN[$i] = 1 } }

        -1 == IupListDialog( i32ro(2), $title, $size, $listN, i32ro(0),
                i32ro($max_col), i32ro($max_lin), $markN)
            ?? []
            !! $listN[ $markN.grep( ?*, :k)].Array
    }

    # IupGetText IupGetColor IupGetParam IupGetParamv
    # IupParam

    sub IupParamBox(Ihdle $param -->Ihdle) is native(IUP_l) is export {*}
    sub IupParamBoxv(Ptr $param_array -->Ihdle) is native(IUP_l) is export {*}

    # IupLayoutDialog IupElementPropertiesDialog
    # IupGlobalsDialog IupClassInfoDialog

    ### METHODS ###

    method destroy( -->Mu) { IupDestroy(self) }

    # detach

    method append(Ihdle $child -->Ihdle) { IupAppend(self, $child) }

    method insert(Ihdle $ref_child, Ihdle $child -->Ihdle) {
        IupInsert(self, $ref_child, $child)
    }

    method get_child($position -->Ihdle) { IupGetChild(self, $position) }

    # getchildpos getchildcount

    method get_next_child(Ihdle $child -->Ihdle) {
        IupGetNextChild(self, $child)
    }

    # getbrother

    method get-parent(-->Ihdle) { IupGetParent(self) }
    method get_parent(-->Ihdle) {
        DEPRECATED('get-parent','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupGetParent(self)
    }

    method get-dialog(-->Ihdle) { IupGetDialog(self) }
    method get_dialog(-->Ihdle) {
        DEPRECATED('get-dialog','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupGetDialog(self)
    }

    method get-dialog-child($name -->Ihdle) { IupGetDialogChild(self, $name ) }
    method get_dialog_child($name -->Ihdle) {
        DEPRECATED('get-dialog-child','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupGetDialogChild(self, $name )
    }

    ###

    # reparent

    method popup(Int $x, Int $y -->int32) { IupPopup(self, $x, $y) }

    multi method show(-->int32) { IupShow(self) }

    multi method show(Int $x, Int $y -->int32) { IupShowXY(self, $x, $y) }

    method hide(-->int32) { IupHide(self) }

    method map(-->int32) { IupMap(self) }

    # unmap

    # These multis cover setting one or more attributes by reference.
    # :copy indicates that the data should be copied instead of using a ref.
    # :pre is only to support the preformatted string arg used by
    # IupSetAttributes in C-code.
    # All the set-attrs return the self element.
    # XXX ??? Hole to globals by calling type-object ??? XXX
    multi method set-attr( Str:D $pre-kv-str, Bool :$pre where $pre -->Ihdle) {
say "Preformatted Str";
        die ':pre flag should not be set False' if not $pre;
        IupSetAttributes(self, $pre-kv-str);
        self
    }
    multi method set-attr(
        Str:D $k, Str:D $v, Bool :$copy where $copy -->Ihdle) {
say "Str,Str,:copy";
        IupStoreAttribute( self, $k, $v);
        self
    }
    multi method set-attr( Str:D $k, Str:D $v -->Ihdle) {
say "Str,Str,  $k, $v";
        IupSetAttribute( self, $k, $v);
        self
    }
    multi method set-attr(Str:D $k, Str:D $v, *@kv -->Ihdle) {
say "Str,Str,…";
        die "Expected even number of args." unless @kv.elems %% 2;
        my $str = "$k=\"$v\"";
        for @kv -> $kk, $vv { $str ~= ",$kk=\"$vv\""; }
        IupSetAttributes(self, $str);
    }
    multi method set-attr( Pair $kv, Bool :$copy where $copy -->Ihdle) {
say 'Pair :copy';
        IupStoreAttribute( self, $kv.key, $kv.value);
        self
    }
    multi method set-attr( Pair $kv -->Ihdle) {
say 'Pair';
         IupSetAttribute( self, $kv.key, $kv.value);
    }
    multi method set-attr( Pair $kv, Pair $kw, *@etc -->Ihdle) { #XXX 2 pair??
say 'Pair Pair …';
        my $str = "$kv.key()=\"$kv.value()\",$kw.key()=\"$kw.value()\"";
        for @etc -> $p {
            die "Expected a Pair object" unless $p ~~ Pair;
            $str ~= ",$p.key()=\"$p.value()\""
        }
        IupSetAttributes self, $str;
    }

    multi method set_attributes(*%attrs) {
        DEPRECATED('set-attr see docs','0.0.2','0.0.3', :what( &?ROUTINE.name));
        .set-attrs( %attrs);
    }

    # http://www.tecgraf.puc-rio.br/iup/en/func/iupsetattribute.html
    method set_attribute(Str $name, Str $value -->Mu) {
        DEPRECATED('set-attr','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupSetStrAttribute(self, $name, $value);
    }
    method set_attr(Str $name, Str $value -->Mu) {
        DEPRECATED('set-attr','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupSetStrAttribute(self, $name, $value);
    }

    ###

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

    # resetattribute
    # getallattributes
    # copyattributes XXX
    # setatt XXX
    # setattributes XXX
    # getattributes XXX
    # setattribute XXX
    # setstrattribute XXX
    # setstrf setint setfloat setdouble setRGB setRGBA
    # getattribute XXX

    method get-int(Str $name -->Int) { IupGetInt(self, $name) }
    method get_int(Str $name -->Int) {
        DEPRECATED('get-int','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupGetInt(self, $name)
    }

    # getint2 getintint getfloat getdouble
    # getRGB getRGBA setattributeid setstrattributeid setstrfid setintid
    # setfloatid setdoubleid setRGBid getattributeid getintid getfloatid
    # getRGBid setattributeid2 setstrattributeid2 setstrfid2
    # setintid2 setfloatid2 setdoubleid2 setRGBid2 getattributeid2 getintid2
    # getfloatid2 getdoubleid2 getRGBid2

    multi method set-global( Str $k, Str $v, Bool :$copy where ?$copy -->Mu) {
        IupSetStrGlobal($k,$v)
    }
    multi method set-global( Str $k, Str $v -->Mu) {
        IupSetGlobal($k,$v)
    }

    method set_global( Str $k, Str $v -->Mu) {
        DEPRECATED('set-global','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupSetStrGlobal($k,$v)
    }

    method set-str-global( Str $k, Str $v -->Mu) {
        DEPRECATED('set-global :copy','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupSetStrGlobal($k,$v) }
    method set_str_global( Str $k, Str $v -->Mu) {
        DEPRECATED('set-str-global :copy','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupSetStrGlobal($k,$v)
    }

    
    method get-global( $attr -->Str) { IupGetGlobal( $attr) }
    method get_global( $attr -->Str) {
        DEPRECATED('get-global','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupGetGlobal( $attr)
    }

    method set-focus( -->Ihdle) { IupSetFocus( self) }
    method set_focus( -->Ihdle) {
        DEPRECATED('set_focus','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupSetFocus( self)
    }

    method get-focus(-->Ihdle) { IupGetFocus }
    method get_focus(-->Ihdle) {
        DEPRECATED('get_focus','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupGetFocus
    }

    ###

    # previousfield nextfield getcallback

    method set-callback(Str $name, $func -->IUP::Callback) {
        my @params = $func.signature.params;
        given @params.elems {
            when 0 { return p6IupSetCallback_void(  self, $name.fmt, $func) }
            when 1 { return p6IupSetCallback_handle(self, $name.fmt, $func) }
            default { say "Error... no callback"  }
        }
    }
    method set_callback(Str $name, $func -->IUP::Callback) {
        DEPRECATED('set-callback','0.0.2','0.0.3', :what( &?ROUTINE.name));
        self.set-callback( $name, $func)
    }

    method set_callbacks(*%callbacks -->Ihdle) {
        for %callbacks.kv -> $name, $function {
            self.set_callback($name, $function);
        }
        return self;
    }

    # getfunction setfunction

    ###
    method get-handle(Str $name -->Ihdle) { IupGetHandle($name) }
    method get_handle(Str $name -->Ihdle) {
        DEPRECATED('get-handle','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupGetHandle($name )
    }

    method set-handle(Str $name -->Ihdle) { IupSetHandle($name, self) }
    method set_handle(Str $name -->Ihdle) {
        DEPRECATED('set-handle','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupSetHandle($name, self)
    }

    ###
    # getallnames getalldialogs getname 
    method set-attr-handle(Str $name, Ihdle $ih_named -->Mu) {
        IupSetAttributeHandle(self, $name, $ih_named);
    }
    method set-attribute-handle(Str $name, Ihdle $ih_named -->Mu) {
        DEPRECATED('set-attr-handle','0.0.2','0.0.3',
                :what( &?ROUTINE.name));
        IupSetAttributeHandle(self, $name, $ih_named);
    }
    method set_attribute_handle(Str $name, Ihdle $ih_named -->Mu) {
        DEPRECATED('set-attr-handle','0.0.2','0.0.3',
                :what( &?ROUTINE.name));
        IupSetAttributeHandle(self, $name, $ih_named);
    }

    ###
    # getattributehandle
    # setattributehandleid getattributehandleid setattributehandleid2 
    # getattributehandleid2 getclassname getclasstype getallclasses
    # getclassattributes getclasscallbacks saveclassattributes
    # setclassdefaultattribute classmatch create createp createv
    method fill(-->Ihdle) { IupFill() }

    method radio( Ihdle $child -->Ihdle) { IupRadio($child) }

    # space

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

    method vbox(*@child -->Ihdle) { self.vboxv(@child) }

    method zboxv(*@children -->Ihdle) {
        given @children.elems {
            when 1 { p6IupZbox: @children[0] }
            default {
                my $list = p6IupNewChildrenList($_);
                my $pos = 0;
                for @children -> $c {
                    p6IupAddChildToList($list, $c, $pos, $_);
                    $pos++;
                }
                my $ret = IupZboxv($list);
                p6IupFree($list);
                return $ret;
            }
        }
    }

    method zbox(*@child -->Ihdle) { self.zbox(@child) }

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

    method hbox(*@child -->Ihdle) { self.hboxv(@child) }

    # normalizer, cbox,

    method sbox( $child -->Ihdle) { IupSbox($child) }

    # split,scrollbox, flatscrollbox

    method gridboxv(*@child -->Ihdle) {
        my $n = @child.elems;
        if $n > 1 {
            my $list = p6IupNewChildrenList($n);
            my $pos = 0;
            for @child -> $c {
                p6IupAddChildToList($list, $c, $pos, $n);
                $pos++;
            }
            my $result = IupGridBoxv($list);
            p6IupFree($list);
            return $result;
        }
        if $n == 1 {
            return p6IupGridBox(@child[0]);
        }
    }

    method gridbox(*@child -->Ihdle) { self.gridboxv(@child); }

    method multiboxv(*@child -->Ihdle) {
        my $n = @child.elems;
        if $n > 1 {
            my $list = p6IupNewChildrenList($n);
            my $pos = 0;
            for @child -> $c {
                p6IupAddChildToList($list, $c, $pos, $n);
                $pos++;
            }
            my $result = IupMultiBoxv($list);
            p6IupFree($list);
            return $result;
        }
        if $n == 1 {
            return p6IupMultiBox(@child[0]);
        }
    }

    method multibox(*@child -->Ihdle) { self.multiboxv(@child); }

    method expander( $child -->Ihdle){  IupExpander( $child) }

    # detachbox, backgroundbox

    method frame($child -->Ihdle) { IupFrame($child); }

    # FlatFrame 
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

    method button(Str $title, Str $action = "" -->Ihdle) {
        p6IupButton($title, $action);
    }

    # FlatButton FlatToggle DropButton FlatLabel FlatSeparator 

    method canvas(Str $action -->Ihdle) { IupCanvas($action) }

    method dialog($child -->Ihdle) { IupDialog($child) }

    method user(-->Ihdle) { IupUser() }

    # thread

    method label(Str $str = '' -->Ihdle) { IupLabel($str) }

    method list(Str $action = Str -->Ihdle) { IupList( $action) }

    # flatlist

    method text(Str $action = '' -->Ihdle) { p6IupText($action) }

    method multiline(Str $action = '' -->Ihdle) { p6IupMultiLine($action) }

    method toggle(Str $title, Str $action = Str -->Ihdle) {
        IupToggle( $title, $action)
    }

    # Timer Clipboard ProgressBar Val FlatVal FlatTree
    # Tabs Tabsv FlatTabs FlatTabsv Tree Link AnimatedLabel
    # DatePick Calendar Colorbar Gauge

    method dial(Str $type -->Ihdle) { IupDial($type) }

    # ColorBrowser Spin Spinbox StringCompare SaveImageAsText ImageGetHandle
    # TextConvertLinColToPos TextConvertPosToLinCol ConvertXYToPos StoreGlobal

    ###
    # StoreAttribute SetfAttribute StoreAttributeId SetfAttributeId
    # StoreAttributeId2 SetfAttributeId2 TreeSetUserId TreeGetUserId
    # TreeGetId TreeSetAttributeHandle 

    method file-dlg(-->Ihdle)    { IupFileDlg      }

    method message-dlg(-->Ihdle) { IupMessageDlg   }

    method color-dlg(-->Ihdle)    { IupColorDlg    }

    method font-dlg(-->Ihdle)     { IupFontDlg     }

    method progress-dlg(-->Ihdle) { IupProgressDlg }

    method get-file(Str $arg -->int32) {
        IupGetFile($arg);
    }

    method message(Str $title, Str $message -->Mu) {
        IupMessage($title, $message)
    }

    # Messagef MessageError MessageAlarm

    method alarm( Str:D $title, Str:D $msg,
            Str:D $b1txt, Str $b2txt, Str $b3txt -->int32) {
        IupAlarm( $title, $msg, $b1txt, $b2txt, $b3txt );
    }

    # IupScanf

    # .list-dialog
    #
    # NOTE: pre-selects/highlights are by indices for both multis.  Upstream
    #       the Clang single selection version used origin one.  That behavior
    # behavior can be got by calling the _native_ IupListDialog directly.
    #
    # $presel versus @presel distinguishes which multi is called.
    # For simple single selection, Int or 0 yield the default preselect.
    # For the multiple selection, use the empty array to get no preselection.

    multi method list-dialog( Str:D $title, Array[Str] $list, Int $presel,
            Int:D $max_col, Int:D $max_lin -->Array) {
        IupListDialog $title, $list, $presel, $max_col, $max_lin;
    }

    multi method list-dialog( Str:D $title, Array[Str] $list, @presel,
            Int:D $max_col, Int:D $max_lin -->Array) {
        IupListDialog $title, $list, @presel, $max_col, $max_lin;
    }

    # GetText GetColor GetParam GetParamv Param ParamBox ParamBoxv LayoutDialog
    # ElementPropertiesDialog GlobalsDialog ClassInfoDialog
}

class IUP is IUP::Handle {

    constant Ihdle = IUP::Handle;
    constant Ptr = Pointer;

    # Must be called before any other IUP function.
    sub p6IupOpen(int32, CArray[Str] -->int32) is native(IUP_l) {*};

    # Ends IUP usage releasing memory. It destroys all named dialogs & elems.
    sub IupClose() is native(IUP_l) {*};

    # IupIsOpened

    sub IupImageLibOpen() is native(IUP_l) {*};

    # Starts loop on interaction that stops when a callback returns IUP_CLOSE,
    # IupExitLoop is called, or all dialogs are hidden.
    sub IupMainLoop( -->int32) is native(IUP_l) {*};

    # IupLoopStep IupLoopStepWait IupMainLoopLevel
    # IupFlush IupExitLoop
    # IupPostMessage  IupRecordInput  IupPlayInput   IupUpdate
    # IupUpdateChildren IupRedraw IupRefresh IupRefreshChildren
    # IupExecute IupExecuteWait IupHelp IupLog
    # IupLoad    IupLoadBuffer

    ###

    # Return version string
    sub IupVersion(-->str) is export is native(IUP_l) {*}

    # Return version's date.
    sub IupVersionDate(-->Str) is native(IUP_l) is export {*}

    # Return version number.
    sub IupVersionNumber(-->int32) is export is native(IUP_l) {*}

    # IupVersionShow

    # Sets the user language: English, Portuguese or Spanish
    sub IupSetLanguage(Str) is native(IUP_l) {*};

    # Gets the user language.
    sub IupGetLanguage( -->Str) is native(IUP_l) {*};

    # IupSetLanguageString IupStoreLanguageString IupGetLanguageString
    # IupSetLanguagePack


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
        IupSetLanguage($language)
    }

    method get-language( -->Str) { IupGetLanguage }
    method get_language( -->Str) {
        DEPRECATED('get-language','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupGetLanguage
    }

    method version(-->Str) { IupVersion }
    method get-version(-->Str) { IupVersion }
    method get_version(-->Str) {
        DEPRECATED('get-version','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupVersion
    }

    # Return version's date.
    method get-version-date(-->Str) { IupVersionDate }
    method get_version_date(-->Str) {
        DEPRECATED('get-version-date','0.0.2','0.0.3', :what( &?ROUTINE.name));
        IupVersionDate
    }

    # Return version number.
    method get-version-number(-->int32) { IupVersionNumber }
    method get_version_number(-->int32) {
        DEPRECATED('get-version-number','0.0.2','0.0.3',
                :what( &?ROUTINE.name));
        IupVersionNumber
    }
}

