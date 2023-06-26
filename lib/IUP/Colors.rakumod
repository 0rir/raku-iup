use v6;
unit class IUP::Colors;

# CSS/CSS3 named colors as Str constants suited for the IUP toolkit.

# Pinks
our constant MediumVioletRed      is export = "199  21 133";
our constant DeepPink             is export = "255  20 147";
our constant PaleVioletRed        is export = "219 112 147";
our constant HotPink              is export = "255 105 180";
our constant LightPink            is export = "255 182 193";
our constant Pink                 is export = "255 192 203";
# Reds
our constant DarkRed              is export = "139   0   0";
our constant Red                  is export = "255   0   0";
our constant Firebrick            is export = "178  34  34";
our constant Crimson              is export = "220  20  60";
our constant IndianRed            is export = "205  92  92";
our constant LightCoral           is export = "240 128 128";
our constant Salmon               is export = "250 128 114";
our constant DarkSalmon           is export = "233 150 122";
our constant LightSalmon          is export = "255 160 122";
# Oranges
our constant OrangeRed            is export = "255  69   0";
our constant Tomato               is export = "255  99  71";
our constant DarkOrange           is export = "255 140   0";
our constant Coral                is export = "255 127  80";
our constant Orange               is export = "255 165   0";
# Yellows
our constant DarkKhaki            is export = "189 183 107";
our constant Gold                 is export = "255 215   0";
our constant Khaki                is export = "240 230 140";
our constant PeachPuff            is export = "255 218 185";
our constant Yellow               is export = "255 255   0";
our constant PaleGoldenrod        is export = "238 232 170";
our constant Moccasin             is export = "255 228 181";
our constant PapayaWhip           is export = "255 239 213";
our constant LightGoldenrodYellow is export = "250 250 210";
our constant LemonChiffon         is export = "255 250 205";
our constant LightYellow          is export = "255 255 224";
# Browns
our constant Maroon               is export = "128   0   0";
our constant Brown                is export = "165  42  42";
our constant SaddleBrown          is export = "139  69  19";
our constant Sienna               is export = "160  82  45";
our constant Chocolate            is export = "210 105  30";
our constant DarkGoldenrod        is export = "184 134  11";
our constant Peru                 is export = "205 133  63";
our constant RosyBrown            is export = "188 143 143";
our constant Goldenrod            is export = "218 165  32";
our constant SandyBrown           is export = "244 164  96";
our constant Tan                  is export = "210 180 140";
our constant Burlywood            is export = "222 184 135";
our constant Wheat                is export = "245 222 179";
our constant NavajoWhite          is export = "255 222 173";
our constant Bisque               is export = "255 228 196";
our constant BlanchedAlmond       is export = "255 235 205";
our constant Cornsilk             is export = "255 248 220";
# Greens
our constant DarkGreen            is export =   "0 100   0";
our constant Green                is export =   "0 128   0";
our constant DarkOliveGreen       is export =  "85 107  47";
our constant ForestGreen          is export =  "34 139  34";
our constant SeaGreen             is export =  "46 139  87";
our constant Olive                is export = "128 128   0";
our constant OliveDrab            is export = "107 142  35";
our constant MediumSeaGreen       is export =  "60 179 113";
our constant LimeGreen            is export =  "50 205  50";
our constant Lime                 is export =   "0 255   0";
our constant SpringGreen          is export =   "0 255 127";
our constant MediumSpringGreen    is export =   "0 250 154";
our constant DarkSeaGreen         is export = "143 188 143";
our constant MediumAquamarine     is export = "102 205 170";
our constant YellowGreen          is export = "154 205  50";
our constant LawnGreen            is export = "124 252   0";
our constant Chartreuse           is export = "127 255   0";
our constant LightGreen           is export = "144 238 144";
our constant GreenYellow          is export = "173 255  47";
our constant PaleGreen            is export = "152 251 152";
# Cyans
our constant Teal                 is export =   "0 128 128";
our constant DarkCyan             is export =   "0 139 139";
our constant LightSeaGreen        is export =  "32 178 170";
our constant CadetBlue            is export =  "95 158 160";
our constant DarkTurquoise        is export =   "0 206 209";
our constant MediumTurquoise      is export =  "72 209 204";
our constant Turquoise            is export =  "64 224 208";
our constant Aqua                 is export =   "0 255 255";
our constant Cyan                 is export =   "0 255 255";
our constant Aquamarine           is export = "127 255 212";
our constant PaleTurquoise        is export = "175 238 238";
our constant LightCyan            is export = "224 255 255";
# Blues
our constant Navy                 is export =   "0   0 128";
our constant DarkBlue             is export =   "0   0 139";
our constant MediumBlue           is export =   "0   0 205";
our constant Blue                 is export =   "0   0 255";
our constant MidnightBlue         is export =  "25  25 112";
our constant RoyalBlue            is export =  "65 105 225";
our constant SteelBlue            is export =  "70 130 180";
our constant DodgerBlue           is export =  "30 144 255";
our constant DeepSkyBlue          is export =   "0 191 255";
our constant CornflowerBlue       is export = "100 149 237";
our constant SkyBlue              is export = "135 206 235";
our constant LightSkyBlue         is export = "135 206 250";
our constant LightSteelBlue       is export = "176 196 222";
our constant LightBlue            is export = "173 216 230";
our constant PowderBlue           is export = "176 224 230";
# Purples, Violets, and Magentas
our constant Indigo               is export =  "75   0 130";
our constant Purple               is export = "128   0 128";
our constant DarkMagenta          is export = "139   0 139";
our constant DarkViolet           is export = "148   0 211";
our constant DarkSlateBlue        is export =  "72  61 139";
our constant BlueViolet           is export = "138  43 226";
our constant DarkOrchid           is export = "153  50 204";
our constant Fuchsia              is export = "255   0 255";
our constant Magenta              is export = "255   0 255";
our constant SlateBlue            is export = "106  90 205";
our constant MediumSlateBlue      is export = "123 104 238";
our constant MediumOrchid         is export = "186  85 211";
our constant MediumPurple         is export = "147 112 219";
our constant Orchid               is export = "218 112 214";
our constant Violet               is export = "238 130 238";
our constant Plum                 is export = "221 160 221";
our constant Thistle              is export = "216 191 216";
our constant Lavender             is export = "230 230 250";
# Whites
our constant MistyRose            is export = "255 228 225";
our constant AntiqueWhite         is export = "250 235 215";
our constant Linen                is export = "250 240 230";
our constant Beige                is export = "245 245 220";
our constant WhiteSmoke           is export = "245 245 245";
our constant LavenderBlush        is export = "255 240 245";
our constant OldLace              is export = "253 245 230";
our constant AliceBlue            is export = "240 248 255";
our constant Seashell             is export = "255 245 238";
our constant GhostWhite           is export = "248 248 255";
our constant Honeydew             is export = "240 255 240";
our constant FloralWhite          is export = "255 250 240";
our constant Azure                is export = "240 255 255";
our constant MintCream            is export = "245 255 250";
our constant Snow                 is export = "255 250 250";
our constant Ivory                is export = "255 255 240";
our constant White                is export = "255 255 255";
# Blacks, Grays, Greys
our constant Black                is export =   "0   0   0";
our constant DarkSlateGray        is export =  "47  79  79";
our constant DimGray              is export = "105 105 105";
our constant SlateGray            is export = "112 128 144";
our constant Gray                 is export = "128 128 128";
our constant LightSlateGray       is export = "119 136 153";
our constant DarkGray             is export = "169 169 169";
our constant Silver               is export = "192 192 192";
our constant LightGray            is export = "211 211 211";
our constant Gainsboro            is export = "220 220 220";

