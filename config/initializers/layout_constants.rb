MOBILE_ONLY     = ' visible-xs '
TABLET_ONLY     = ' visible-sm '
DESK_MED_ONLY   = ' visible-md '
DESK_LRG_ONLY   = ' visible-lg '

MOBILE_TABLET   = MOBILE_ONLY + TABLET_ONLY
TABLET_DESKTOP  =               TABLET_ONLY + DESK_MED_ONLY + DESK_LRG_ONLY
DESKTOP         =                             DESK_MED_ONLY + DESK_LRG_ONLY
VISIBLE_ALWAYS  = MOBILE_ONLY + TABLET_ONLY + DESK_MED_ONLY + DESK_LRG_ONLY

MOB_TAB_BLOCK   = ' visible-xs-block visible-sm-block '
DESKTOP_BLOCK   = ' visible-md-block visible-lg-block '

MOBILE_CLASS    = "class=\"#{MOBILE_TABLET}\""
DESKTOP_CLASS   = "class=\"#{DESKTOP}\""

BIG_BUTTON              = ' btn btn-primary '

GO_BUTTON_MOB_TAB       = ' btn btn-primary btn-sm '    # SFR: btn-default
GO_BUTTON_DESK          = ' btn btn-primary '

SMALL_GO_BUTTON_MOB_TAB = ' btn btn-primary btn-xs '    # SFR: btn-default
SMALL_GO_BUTTON_DESK    = ' btn btn-primary btn-sm '

WIDE_GO_BUTTON_MOB_TAB  = GO_BUTTON_MOB_TAB  + 'btn-block '
WIDE_GO_BUTTON_DESK     = GO_BUTTON_DESK     + 'btn-block '


ACT_BUTTON_MOB_TAB      = ' btn btn-primary btn-sm '
ACT_BUTTON_DESK         = ' btn btn-primary '

WIDE_ACT_BUTTON_MOB_TAB = ACT_BUTTON_MOB_TAB + 'btn-block '
WIDE_ACT_BUTTON_DESK    = ACT_BUTTON_DESK    + 'btn-block '


SMALL_BUTTON_MOB_TAB    = ' btn btn-primary btn-xs '
SMALL_BUTTON_DESK       = ' btn btn-primary btn-sm '

UNDER_BUTTON_MOB_TAB    = ' btn btn-primary btn-xs '
UNDER_BUTTON_DESK       = ' btn btn-primary btn-xs '

# CPC form buttons
SUBMIT_BUTTON_MOB_TAB   = ' btn btn-primary btn-sm '
SUBMIT_BUTTON_DESK      = ' btn btn-primary '

CANCEL_BUTTON_MOB_TAB   = ' btn btn-primary btn-xs btn-block '
CANCEL_BUTTON_DESK      = ' btn btn-primary btn-sm btn-block '

FORM_BUTTON_MOB_TAB     = ' btn btn-primary btn-xs btn-block '
FORM_BUTTON_DESK        = ' btn btn-primary btn-sm btn-block '
FORM_BUTTON_LO_MOB_TAB  = ' btn btn-default btn-xs btn-block '
FORM_BUTTON_LO_DESK     = ' btn btn-default btn-sm btn-block '

ROW_BUTTON_MOB_TAB      = ' btn btn-primary btn-xs '
ROW_BUTTON_DESK         = ' btn btn-primary btn-sm '
ROW_BUTTON_GRN_MOB_TAB  = ' btn btn-success btn-xs '
ROW_BUTTON_GRN_DESK     = ' btn btn-success btn-sm '
ROW_BUTTON_RED_MOB_TAB  = ' btn btn-danger  btn-xs '
ROW_BUTTON_RED_DESK     = ' btn btn-danger  btn-sm '
ROW_BUTTON_LO_MOB_TAB   = ' btn btn-default btn-xs '
ROW_BUTTON_LO_DESK      = ' btn btn-default btn-sm '
ROW_BUTTON_WIDE_MOB_TAB = ROW_BUTTON_MOB_TAB + 'btn-block '    # not used
ROW_BUTTON_WIDE_DESK    = ROW_BUTTON_DESK    + 'btn-block '    # not used


STYLE_COUNT      = 2
STYLES           = [MOBILE_TABLET,       DESKTOP]
STYLES_BLOCK     = [MOB_TAB_BLOCK, DESKTOP_BLOCK]

GO_BUTTONS       = [      GO_BUTTON_MOB_TAB,       GO_BUTTON_DESK]
SMALL_GO_BUTTONS = [SMALL_GO_BUTTON_MOB_TAB, SMALL_GO_BUTTON_DESK]
WIDE_GO_BUTTONS  = [ WIDE_GO_BUTTON_MOB_TAB,  WIDE_GO_BUTTON_DESK]

ACT_BUTTONS      = [     ACT_BUTTON_MOB_TAB,      ACT_BUTTON_DESK]
WIDE_ACT_BUTTONS = [WIDE_ACT_BUTTON_MOB_TAB, WIDE_ACT_BUTTON_DESK]

SMALL_BUTTONS    = [   SMALL_BUTTON_MOB_TAB,        SMALL_BUTTON_DESK]
ROW_BUTTONS      = [     ROW_BUTTON_MOB_TAB,          ROW_BUTTON_DESK]
ROW_BUTTONS_GRN  = [ ROW_BUTTON_GRN_MOB_TAB,      ROW_BUTTON_GRN_DESK]
ROW_BUTTONS_RED  = [ ROW_BUTTON_RED_MOB_TAB,      ROW_BUTTON_RED_DESK]
ROW_BUTTONS_LO   = [  ROW_BUTTON_LO_MOB_TAB,       ROW_BUTTON_LO_DESK]
ROW_BUTTONS_WIDE = [ROW_BUTTON_WIDE_MOB_TAB,     ROW_BUTTON_WIDE_DESK]    # not used, unless shared/row_button_link is used
UNDER_BUTTONS    = [   UNDER_BUTTON_MOB_TAB,        UNDER_BUTTON_DESK]
SUBMIT_BUTTONS   = [  SUBMIT_BUTTON_MOB_TAB,       SUBMIT_BUTTON_DESK]
CANCEL_BUTTONS   = [  CANCEL_BUTTON_MOB_TAB,       CANCEL_BUTTON_DESK]
FORM_BUTTONS     = [    FORM_BUTTON_MOB_TAB,         FORM_BUTTON_DESK]
FORM_BUTTONS_LO  = [ FORM_BUTTON_LO_MOB_TAB,      FORM_BUTTON_LO_DESK]

BTN_XS_BUTTONS   = [ROW_BUTTON_MOB_TAB, ROW_BUTTON_MOB_TAB]
BTN_SM_BUTTONS   = [ROW_BUTTON_DESK,    ROW_BUTTON_DESK]
BTN_LG_BUTTONS   = [BIG_BUTTON,         BIG_BUTTON]
