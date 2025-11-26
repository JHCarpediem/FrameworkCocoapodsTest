#ifndef _STD_SHOW_MACO_H_
#define _STD_SHOW_MACO_H_

//#include "StdInclude.h"

/*-----------------------------------------------------------------------------
Àµ    √˜£∫  ”√À˘”–Ω”ø⁄£¨»Áπ˚App√ª”– µœ÷¥ÀΩ”ø⁄π¶ƒ‹£®º¥JNIø…“‘’“µΩApkµƒ∫Ø ˝∂®“Â£¨
          µ´ «App/Apk »¥√ª”– µœ÷¥ÀΩ”ø⁄π¶ƒ‹£¨º¥App≤ª÷ß≥÷µ±«∞π¶ƒ‹£©£¨∑µªÿ¥À÷µ
-----------------------------------------------------------------------------*/
#define DF_APP_CURRENT_NOT_SUPPORT_FUNCTION     (0xFFFFFFEF)    // -17

/*-----------------------------------------------------------------------------
Àµ    √˜£∫  ”√À˘”–Ω”ø⁄£¨»Áπ˚APP√ª”– µœ÷¥ÀΩ”ø⁄£®º¥JNI’“≤ªµΩAPKµƒ∫Ø ˝∂®“Â£¨ªÚ’ﬂ
          iOSµƒApp√ª”–◊¢≤·Ω”ø⁄µƒªÿµ˜∫Ø ˝£©£¨∑µªÿ¥À÷µ
-----------------------------------------------------------------------------*/
#define DF_FUNCTION_APP_CURRENT_NOT_SUPPORT     (0xFFFFFFF0)    // -16

/*-----------------------------------------------------------------------------
Àµ    √˜£∫  ”√À˘”–Ω”ø⁄£¨»Áπ˚APP√ª”–¥À∂‘œÛ µ¿˝£¨∑µªÿ¥À÷µ
-----------------------------------------------------------------------------*/
#define DF_FUNCTION_APP_OBJ_NOT_CONSTRUCTOR     (0xFFFFFFF1)    // -15

/*-----------------------------------------------------------------------------
Àµ    √˜£∫  ”√À˘”–Ω”ø⁄£¨»Áπ˚APP√ª”–¥À∂‘œÛ µ¿˝£¨∑µªÿ¥À÷µ
-----------------------------------------------------------------------------*/
#define STR_FUNCTION_APP_OBJ_NOT_CONSTRUCTOR     ("object not construct!")

#define DF_CUR_BRAND_APP_NOT_SUPPORT  (DF_APP_CURRENT_NOT_SUPPORT_FUNCTION)


#if !defined(_WIN32)&!defined (_WIN64)
#define DT_TOP                      0x00000000
#define DT_LEFT                     0x00000000
#define DT_CENTER                   0x00000001
#define DT_RIGHT                    0x00000002
#define DT_BOTTOM                   0x00000008
#endif


#define DT_LEFT_TOP                 0x00000010  // ◊Û…œΩ«
#define DT_RIGHT_TOP                0x00000011  // ”“…œΩ«
#define DT_LEFT_BOTTOM              0x00000012  // ◊Ûœ¬Ω«
#define DT_RIGHT_BOTTOM             0x00000013  // ”“œ¬Ω«


/*-----------------------------------------------------------------------------
Àµ    √˜£∫ΩÁ√Ê◊Ë»˚/∑«◊Ë»˚   ”√”⁄À˘”–œ‘ æ¿‡
-----------------------------------------------------------------------------*/
#define DF_MB_NONBLOCK                          0x0000
#define DF_MB_BLOCK                             0x0100


/*-----------------------------------------------------------------------------
Àµ    √˜£∫πÃ∂®∞¥≈•
-----------------------------------------------------------------------------*/
#define DF_MB_NOBUTTON                       0x0000   //  Œﬁ∞¥≈•µƒ∑«◊Ë»˚œ˚œ¢øÚ
#define DF_MB_YES                            0x0101   //  Yes ∞¥≈•µƒ◊Ë»˚œ˚œ¢øÚ
#define DF_MB_NO                             0x0102   //  No ∞¥≈•µƒ◊Ë»˚œ˚œ¢øÚ
#define DF_MB_YESNO                          0x0103   //  Yes/No ∞¥≈•µƒ◊Ë»˚œ˚œ¢øÚ
#define DF_MB_OK                             0x0104   //  OK ∞¥≈•µƒ◊Ë»˚œ˚œ¢øÚ
#define DF_MB_CANCEL                         0x0108   //  Cancel ∞¥≈•µƒ◊Ë»˚œ˚œ¢øÚ
#define DF_MB_OKCANCEL                       0x010C   //  OK/Cancel ∞¥≈•µƒ◊Ë»˚œ˚œ¢øÚ
#define DF_MB_NEXTEXIT                       0x010D   //  Next/Exit ∞¥≈•µƒ◊Ë»˚œ˚œ¢øÚ


/*-----------------------------------------------------------------------------
Àµ    √˜£∫◊‘”…∞¥≈•ø™πÿ£®◊‘”…ÃÌº”∞¥≈•£©
-----------------------------------------------------------------------------*/
#define DF_MB_FREE                            0x0200  // ◊‘”…∞¥≈•µƒ∑«◊Ë»˚œ˚œ¢øÚ


/*-----------------------------------------------------------------------------
Àµ    √˜£∫πÃ∂®∞¥≈•∑µªÿ÷µ
-----------------------------------------------------------------------------*/
#define DF_ID_OK                             0x00000000
#define DF_ID_YES                            0x00000000
#define DF_ID_CANCEL                         0xFFFFFFFF
#define DF_ID_NO                             0xFFFFFFFF
#define DF_ID_BACK                           0xFFFFFFFF
#define DF_ID_EXIT                           0xFFFFFFFF
#define DF_ID_HELP                           0x80000001
#define DF_ID_CLEAR_DTC                      0x80000002   // µ„ª˜«Â≥˝π ’œ¬Î
#define DF_ID_REPORT                         0x80000003
#define DF_ID_READ_DTC                       0x80000006   // µ„ª˜∂¡π ’œ¬Î
#define DF_ID_NEXT                           0x80000010   // œ¬“ª∏ˆ
#define DF_ID_PREV                           0x80000011   // «∞“ª∏ˆ
#define DF_ID_RESTORE                        0x80000020   // ª÷∏¥ ˝æ›
#define DF_ID_SFD_THIRD                      0x80000030   // VWÕ¯πÿΩ‚À¯ΩÁ√Ê£¨°∞µ⁄»˝∑Ω¥¶¿Ì°±∑µªÿ÷µ
                                                          // ”√”⁄artiShowSpecialΩ”ø⁄µƒ∞¥≈•∑µªÿ÷µ


/*-----------------------------------------------------------------------------
Àµ    √˜£∫◊‘”…∞¥≈•∑µªÿ÷µ£®ªÚ’ﬂ±‡∫≈£©£¨ π”√”⁄∏˜÷÷ø…◊‘”…ÃÌº”∞¥≈•µƒøÿº˛
-----------------------------------------------------------------------------*/
#define DF_ID_FREEBTN_0                      0x00000100
#define DF_ID_FREEBTN_1                      0x00000101
#define DF_ID_FREEBTN_2                      0x00000102
#define DF_ID_FREEBTN_3                      0x00000103
//#define DF_ID_FREEBTN_XX                   0x000001XX //“ªπ≤FF∏ˆ◊‘”…∞¥≈•


#define DF_ST_BTN_ENABLE                     ((uint32_t)0x00)     // ∞¥≈•◊¥Ã¨Œ™ø…º˚≤¢«“ø…µ„ª˜
#define DF_ST_BTN_DISABLE                    ((uint32_t)0x01)     // ∞¥≈•◊¥Ã¨Œ™ø…º˚µ´≤ªø…µ„ª˜
#define DF_ST_BTN_UNVISIBLE                  ((uint32_t)0x02)     // ∞¥≈•◊¥Ã¨Œ™≤ªø…º˚£¨“˛≤ÿ



/*-----------------------------------------------------------------------------
Àµ    √˜£∫ªÒ»°πÃ∂®∞¥≈•Œƒ±æµƒ∫Í÷µID£¨”√”⁄Ω”ø⁄ GetButtonText
-----------------------------------------------------------------------------*/
#define DF_TEXT_ID_OK                             0x00000001
#define DF_TEXT_ID_YES                            0x00000002
#define DF_TEXT_ID_CANCEL                         0x00000003
#define DF_TEXT_ID_NO                             0x00000004
#define DF_TEXT_ID_BACK                           0x00000005
#define DF_TEXT_ID_EXIT                           0x00000006
#define DF_TEXT_ID_HELP                           0x00000007
#define DF_TEXT_ID_CLEAR_DTC                      0x00000008
#define DF_TEXT_ID_REPORT                         0x00000009
#define DF_TEXT_ID_NEXT                           0x0000000A
#define DF_TEXT_ID_PREV                           0x0000000B



/*-----------------------------------------------------------------------------
Àµ    √˜£∫Œﬁ≤Ÿ◊˜∑µªÿ÷µ
-----------------------------------------------------------------------------*/
#define DF_ID_NOKEY                               0x04000000


/*-----------------------------------------------------------------------------
Àµ    √˜£∫√ª”–—°÷–»Œ“‚“ª––∑µªÿ÷µ
          »Áπ˚’Ô∂œ”¶”√≥Ã–Úµ˜”√¡ÀSetSelectedTypeΩ”ø⁄£¨≤¢…Ë÷√Œ™ITEM_SELECT_DISABLED
          ≤¢«“√ª”–µ˜”√SetDefaultSelectedRow£¨«Èøˆœ¬
          CArtiListµƒShow∑µªÿ÷µŒ™√ª”–—°÷–»Œ“‚“ª––DF_LIST_LINE_NONE
          «“GetSelectedRow“≤∑µªÿ√ª”–—°÷–»Œ“‚“ª––DF_LIST_LINE_NONE
-----------------------------------------------------------------------------*/
#define DF_LIST_LINE_NONE                         0xFFFF


////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------
Àµ    √˜£∫CArtiSystem ∞¥≈•∑µªÿ÷µ∫Í Show µƒ∞¥≈•∑µªÿ÷µ
          ∞¥≈•∞¸¿®£∫“ªº¸…®√Ë£¨“ªº¸«Â¬Î£¨∞Ô÷˙£¨’Ô∂œ±®∏Ê£¨∑µªÿ
          ¿˝»Á£¨µ„ª˜°∞“ªº¸…®√Ë°±∑µªÿ DF_ID_START
-----------------------------------------------------------------------------*/
#define DF_ID_SYS_START                       0x80000004
#define DF_ID_SYS_STOP                        0x80000005
#define DF_ID_SYS_ERASE                       DF_ID_CLEAR_DTC
#define DF_ID_SYS_REPORT                      DF_ID_REPORT
#define DF_ID_SYS_HELP                        DF_ID_HELP
#define DF_ID_SYS_BACK                        DF_ID_BACK
#define DF_ID_SYS_NOKEY                       DF_ID_NOKEY



/*-----------------------------------------------------------------------------
Àµ    √˜£∫ CArtiSystem “≥√Ê¡–±ÌœÓ∑µªÿ÷µ(Show)£¨±Ì æµ„ª˜¡Àƒ«∏ˆœµÕ≥
-----------------------------------------------------------------------------*/
#define DF_ID_SYS_0                         0x00000000
#define DF_ID_SYS_1                         0x00000001
#define DF_ID_SYS_3                         0x00000003
//...
//#define DF_ID_SYS_X                       0x0000XXXX


// ////////////////////////////////////////////////////////////////////////////////////////////////
// CArtiSystem œµÕ≥…®√Ë≤Àµ•œ¬£¨µ„ª˜ADAS£¨(Show)∑µªÿ÷µ
#define DF_ID_SYS_ADAS_0                    0x01000000      // µ„ª˜¡Àµ⁄0∏ˆœµÕ≥µƒADAS
#define DF_ID_SYS_ADAS_1                    0x01000001      // µ„ª˜¡Àµ⁄1∏ˆœµÕ≥µƒADAS
#define DF_ID_SYS_ADAS_2                    0x01000002      // µ„ª˜¡Àµ⁄2∏ˆœµÕ≥µƒADAS
#define DF_ID_SYS_ADAS_3                    0x01000003      // µ„ª˜¡Àµ⁄3∏ˆœµÕ≥µƒADAS
//...
//#define DF_ID_SYS_ADAS_X
#define DF_ID_SYS_ADAS_MASK                 0x0000FFFF
#define DF_SYS_GET_ADAS_SYS_NO(x)           (((x) & DF_ID_SYS_DTC_MASK))   // œµÕ≥±‡∫≈


// ////////////////////////////////////////////////////////////////////////////////////////////////
// CArtiSystem œµÕ≥…®√Ë≤Àµ•œ¬£¨µ„ª˜øÏÀŸ≤Èø¥π ’œ¬Î£¨(Show)∑µªÿ÷µ
#define DF_ID_SYS_DTC_0                     0x00100000      // µ„ª˜¡Àµ⁄0∏ˆœµÕ≥µƒπ ’œ¬ÎøÏÀŸ‰Ø¿¿∞¥≈•
#define DF_ID_SYS_DTC_1                     0x00100001      // µ„ª˜¡Àµ⁄1∏ˆœµÕ≥µƒπ ’œ¬ÎøÏÀŸ‰Ø¿¿∞¥≈•
#define DF_ID_SYS_DTC_2                     0x00100002      // µ„ª˜¡Àµ⁄2∏ˆœµÕ≥µƒπ ’œ¬ÎøÏÀŸ‰Ø¿¿∞¥≈•
#define DF_ID_SYS_DTC_3                     0x00100003      // µ„ª˜¡Àµ⁄3∏ˆœµÕ≥µƒπ ’œ¬ÎøÏÀŸ‰Ø¿¿∞¥≈•
//...
//#define DF_ID_SYS_DTC_X
#define DF_ID_SYS_DTC_MASK                  0x0000FFFF
#define DF_SYS_GET_DTC_SYS_NO(x)            (((x) & DF_ID_SYS_DTC_MASK))   // œµÕ≥±‡∫≈


// ////////////////////////////////////////////////////////////////////////////////////////////////
// CArtiSystem ∂‡œﬂ≥ÃœµÕ≥’Ô∂œ£¨µ„ª˜¡Àƒƒ∏ˆœµÕ≥
#define DF_ID_SYS_TH1_0                     0x00010000      // ø™∆Ù°∞±‡∫≈Œ™0µƒœµÕ≥°±µ⁄1∏ˆœﬂ≥Ã
#define DF_ID_SYS_TH1_1                     0x00010001      // ø™∆Ù°∞±‡∫≈Œ™1µƒœµÕ≥°±µ⁄1∏ˆœﬂ≥Ã
#define DF_ID_SYS_TH1_2                     0x00010002      // ø™∆Ù°∞±‡∫≈Œ™2µƒœµÕ≥°±µ⁄1∏ˆœﬂ≥Ã
//...
//#define DF_ID_SYS_TH1_X                   0x0001000X
#define DF_ID_SYS_TH2_1                     0x00020001      // ø™∆Ù°∞±‡∫≈Œ™1µƒœµÕ≥°±µ⁄2∏ˆœﬂ≥Ã
#define DF_ID_SYS_TH3_2                     0x00030002      // ø™∆Ù°∞±‡∫≈Œ™2µƒœµÕ≥°±µ⁄3∏ˆœﬂ≥Ã
#define DF_ID_SYS_TH4_3                     0x00040003      // ø™∆Ù°∞±‡∫≈Œ™3µƒœµÕ≥°±µ⁄4∏ˆœﬂ≥Ã
//...
//#define DF_ID_SYS_TH2_X
//#define DF_ID_SYS_TH3_X
//#define DF_ID_SYS_TH4_X
#define DF_ID_SYS_TH_MASK                   0x000F0000
#define DF_SYS_GET_TH_NO(x)                 (((x) & DF_ID_SYS_TH_MASK) >> 16)   // œﬂ≥Ã±‡∫≈



////////////////////////////////////////////////////////////////////////////////////////////////
// CArtiSystem œµÕ≥…®√Ë¿‡–Õ
#define DF_SST_TYPE_DEFAULT                0        // ƒ¨»œœµÕ≥¿‡–Õ
#define DF_SST_TYPE_ADAS                   1        // ADASœµÕ≥…®√Ë¿‡–Õ



/*-----------------------------------------------------------------------------
Àµ    √˜£∫CArtiSystem œµÕ≥◊¥Ã¨∫Í£¨ uResult ÷∏∂®œµÕ≥œÓµƒ◊Ó÷’Ω·π˚
            ”√”⁄void SetItemResult(uint16_t uIndex, uint32_t uResult);
-----------------------------------------------------------------------------*/
#define DF_ENUM_UNKNOWN                     0x10000000  //Œ¥÷™
#define DF_ENUM_NOTEXIST                    0x20000000  //≤ª¥Ê‘⁄
#define DF_ENUM_NOTSUPPORT                  0x30000000  //≤ª÷ß≥÷
#define DF_ENUM_NODTC                       0x40000000  //Œﬁ¬Î
#define DF_ENUM_DTCNUM                      0x80000000  //”–¬Î
//DF_ENUM_DTCNUM + 1 Œ™”–1∏ˆπ ’œ¬Î



/*-----------------------------------------------------------------------------
Àµ    √˜£∫CArtiSystem ADASœµÕ≥◊¥Ã¨∫Í£¨ uAdasResult ÷∏∂®ADASœµÕ≥œÓµƒΩ·π˚
            ”√”⁄void SetItemAdas(uint16_t uIndex, uint32_t uAdasResult);
-----------------------------------------------------------------------------*/
#define DF_ENUM_NO_ADAS                     0  // ≤ª¥Ê‘⁄ADAS
#define DF_ENUM_ADAS_EXIST                  1  // ¥Ê‘⁄ADAS




/*-----------------------------------------------------------------------------
Àµ    √˜£∫CArtiSystem œµÕ≥…®√Ë◊¥Ã¨∫Í£¨”√”⁄ SetScanStatus
-----------------------------------------------------------------------------*/
#define DF_SYS_SCAN_START                        0  // ø™ º…®√Ë
#define DF_SYS_SCAN_PAUSE                        1  // ‘›Õ£…®√Ë
#define DF_SYS_SCAN_FINISH                       2  // …®√ËΩ· ¯


/*-----------------------------------------------------------------------------
Àµ    √˜£∫CArtiSystem œµÕ≥…®√Ë◊¥Ã¨∫Í£¨”√”⁄ SetClearStatus
-----------------------------------------------------------------------------*/
#define DF_SYS_CLEAR_START                       0  // “ªº¸«Â¬Îø™ º
#define DF_SYS_CLEAR_FINISH                      1  // “ªº¸«Â¬ÎΩ· ¯




////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------
Àµ    √˜£∫ ‰»ÎøÚ Show ∑µªÿ÷µ£¨  ”√”⁄ CArtiInput ¿‡
          »˝÷÷∞¥≈•¿‡–Õ£¨»∑∂®°¢»°œ˚°¢◊‘∂®“Â∞¥º¸
-----------------------------------------------------------------------------*/
#define DF_ID_INPUT_OK                      DF_ID_OK
#define DF_ID_INPUT_CANCLE                  DF_ID_CANCEL

#define DF_ID_INPUT_0                       DF_ID_FREEBTN_0
#define DF_ID_INPUT_1                       DF_ID_FREEBTN_1
#define DF_ID_INPUT_2                       DF_ID_FREEBTN_2
#define DF_ID_INPUT_3                       DF_ID_FREEBTN_3
//...
//#define DF_ID_INPUT_X                     DF_ID_FREEBTN_X





////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------
Àµ    √˜£∫≤Àµ•œÓ Show ∑µªÿ÷µ£¨  ”√”⁄ CArtiMenu ¿‡
-----------------------------------------------------------------------------*/
#define DF_ID_MENU_BACK                     DF_ID_BACK
#define DF_ID_MENU_HELP                     DF_ID_HELP

#define DF_ID_MENU_TREE                     0x80000000  // ≤Àµ• ˜≤ø∑÷£¨‘›∂®

#define DF_ID_MENU                          0x00000000
#define DF_ID_MENU_0                        0x00000000
#define DF_ID_MENU_1                        0x00000001
#define DF_ID_MENU_2                        0x00000002
#define DF_ID_MENU_3                        0x00000003
//...
//#define DF_ID_MENU_X                      0x0000XXXX

#define DF_ST_MENU_NORMAL                   0x00000000  // ’˝≥£◊¥Ã¨
#define DF_ST_MENU_EXPIR                    0x00000001  // »Ìº˛π˝∆⁄
#define DF_ST_MENU_DISABLE                  0x00000003  //  ßƒ‹◊¥Ã¨



////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------
Àµ    √˜£∫ ˝æ›¡˜ Show ∑µªÿ÷µ£¨  ”√”⁄ CArtiLiveData ¿‡
-----------------------------------------------------------------------------*/
#define DF_ID_LIVEDATA_BACK                 DF_ID_BACK
#define DF_ID_LIVEDATA_NEXT                 DF_ID_NEXT
#define DF_ID_LIVEDATA_PREV                 DF_ID_PREV
#define DF_ID_LIVEDATA_REPORT               DF_ID_REPORT




///////////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------
Àµ    √˜£∫π ’œ¬Î Show ∑µªÿ÷µ£¨  ”√”⁄ CArtiTrouble ¿‡
-----------------------------------------------------------------------------*/
#define DF_ID_TROUBLE_BACK                       DF_ID_BACK
#define DF_ID_TROUBLE_CLEAR                      DF_ID_CLEAR_DTC
#define DF_ID_TROUBLE_REPORT                     DF_ID_REPORT

// π ’œ¬Î µ„ª˜ "∂≥Ω·÷°" µƒ Show ∑µªÿ÷µ£¨  ”√”⁄ CArtiTrouble ¿‡
#define DF_ID_TROUBLE_0                          0x00000000
#define DF_ID_TROUBLE_1                          0x00000001
#define DF_ID_TROUBLE_2                          0x00000002
#define DF_ID_TROUBLE_3                          0x00000003
#define DF_ID_TROUBLE_4                          0x00000004
//...
//#define DF_ID_TROUBLE_X                        0x0000XXXX

// π ’œ¬Î µ„ª˜ "Œ¨–ﬁ◊ ¡œ" µƒ Show ∑µªÿ÷µ£¨  ”√”⁄ CArtiTrouble ¿‡
#define DF_ID_REPAIR_MANUAL_0                    0x40000000
#define DF_ID_REPAIR_MANUAL_1                    0x40000001
#define DF_ID_REPAIR_MANUAL_2                    0x40000002
#define DF_ID_REPAIR_MANUAL_3                    0x40000003
#define DF_ID_REPAIR_MANUAL_4                    0x40000004
//...
//#define DF_ID_REPAIR_MANUAL_XXXX               0x4000XXXX
////////////////////////////////////////////////////////////////////////////////////////////




///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
Àµ    √˜£∫’Ô∂œ±®∏Êπ ’œ¬Î◊¥Ã¨£¨”√”⁄π ’œ¬ÎœÓ£¨Ω·ππÃÂ stDtcNode µƒ uStatus
----------------------------------------------------------------------------------*/
#define DF_DTC_STATUS_NONE                 (0)            // Œﬁ◊¥Ã¨
#define DF_DTC_STATUS_CURRENT              (1 << 0)       // µ±«∞π ’œ¬Î    Current
#define DF_DTC_STATUS_HISTORY              (1 << 1)       // ¿˙ ∑π ’œ¬Î    History
#define DF_DTC_STATUS_PENDING              (1 << 2)       // ¥˝∂®π ’œ¬Î    Pending
#define DF_DTC_STATUS_TEMP                 (1 << 3)       // ¡Ÿ ±π ’œ¬Î    Temporary
#define DF_DTC_STATUS_NA                   (1 << 4)       // Œ¥÷™π ’œ¬Î    N/A
#define DF_DTC_STATUS_OTHERS               (0xFFFFFFFF)   // Œﬁ∑®πÈ¿‡µΩ“‘…œ√∂æŸ∑÷¿‡£¨÷±Ω”∞¥strStatusœ‘ æ




///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
Àµ    √˜£∫µØ≥ˆøÚ◊Èº˛£¨1°¢¥øœ˚œ¢Œƒ±æµØ≥ˆøÚ¿‡–Õ     2°¢±Ì∏Ò¿‡–ÕµƒµØ≥ˆøÚ
            ”√”⁄ CArtiPopup µƒ InitTitle Ω”ø⁄µƒ uPopupType ≤Œ ˝
----------------------------------------------------------------------------------*/
#define DF_POPUP_TYPE_MSG              0x00000001       // ¥øœ˚œ¢Œƒ±æµØ≥ˆøÚ¿‡–Õ
#define DF_POPUP_TYPE_LIST             0x00000002       // ±Ì∏Ò¿‡–ÕµƒµØ≥ˆøÚ





///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
Àµ    √˜£∫”√”⁄µØ≥ˆøÚ◊Èº˛ CArtiPopup Ω”ø⁄SetPopDirection£¨…Ë÷√µØ≥ˆøÚµØ≥ˆµƒ∑ΩœÚ
          void SetPopDirection(uint32_t uDirection);
----------------------------------------------------------------------------------*/
#define DF_POPUP_DIR_TOP              0x00000000       // ∂•≤øµØ≥ˆ
#define DF_POPUP_DIR_CENTER           0x00000001       // æ”÷–µØ≥ˆ
#define DF_POPUP_DIR_RIGHT            0x00000002       // ”“≤‡µØ≥ˆ
#define DF_POPUP_DIR_BOTTOM           0x00000004       // µ◊≤øµØ≥ˆ
#define DF_POPUP_DIR_LEFT             0x00000008       // ◊Û≤‡µØ≥ˆ



/*-----------------------------------------------------------------------------
Àµ    √˜£∫Õº∆¨ÃÌº”∑µªÿ÷µ£®ªÚ’ﬂ±‡∫≈£©£¨ π”√”⁄CArtiPictureµƒ
-----------------------------------------------------------------------------*/
#define DF_ID_PICTURE_NONE                   0xFFFFFFFF
#define DF_ID_PICTURE_0                      0x00000000
#define DF_ID_PICTURE_1                      0x00000001
#define DF_ID_PICTURE_2                      0x00000002
#define DF_ID_PICTURE_3                      0x00000003
//#define DF_ID_PICTURE_XX                   0x000000XX //“ªπ≤FF’≈Õº∆¨



/*-----------------------------------------------------------------------------
Àµ    √˜£∫–°≥µÃΩUI¿‡–Õ£¨  ”√”⁄ artiMsgBoxActTest µƒ–Œ≤Œ uTestType
          ªÚ’ﬂ”√”⁄ CArtiLiveData µƒΩ”ø⁄ SetComponentType
-----------------------------------------------------------------------------*/
#define DF_TYPE_ENTRY_COMMING                0x00000001     // ’˝‘⁄Õ®–≈÷–£¨¿˝»Áµ„ª˜≤øº˛≤‚ ‘°¢ ˝æ›¡˜µ»
#define DF_TYPE_COMM_FAILED                  0x00000002     // Õ®–≈ ß∞‹¿‡–Õ
#define DF_TYPE_ACT_TEST_NOT_SUPPORT         0x00000003     // ≤ª÷ß≥÷≤øº˛≤‚ ‘
#define DF_TYPE_THROTTLE_CARBON              0x00000010     // Ω⁄∆¯√≈ª˝ÃººÏ≤‚
#define DF_TYPE_FULE_CORRECTION              0x00000020     // »º”Õ–ﬁ’˝øÿ÷∆œµÕ≥ºÏ≤‚
#define DF_TYPE_MAF_TEST                     0x00000030     // ø’∆¯¡˜¡ø¥´∏–∆˜ºÏ≤‚
#define DF_TYPE_INTAKE_PRESSURE              0x00000040     // Ω¯∆¯—π¡¶¥´∏–∆˜ºÏ≤‚
#define DF_TYPE_INTAKE_PRESSURE_ACC          0x00000041     // Ω¯∆¯—π¡¶¥´∏–∆˜ºÏ≤‚÷–µƒÀ…ø™”Õ√≈Ã· æ
#define DF_TYPE_OXYGEN_SENSOR                0x00000050     // —ı¥´∏–∆˜ºÏ≤‚
#define DF_TYPE_ENGINE_TEST_NO_DTC           0x00000060     // CarPal∑¢∂Øª˙ºÏ≤‚£¨Œﬁπ ’œ¬Î“≥√Ê



/*-----------------------------------------------------------------------------
Àµ    √˜£∫≤øº˛≤‚ ‘Ω·π˚÷µ£¨”√”⁄ CArtiLiveData µƒΩ”ø⁄ SetComponentResult
-----------------------------------------------------------------------------*/
#define DF_RESULT_THROTTLE_NORMAL            0x00000001      // ∑¢∂Øª˙Ω⁄∆¯√≈‘À◊˜’˝≥£
#define DF_RESULT_THROTTLE_LIGHT_CARBON      0x00000002      // Ω⁄∆¯√≈“…À∆”–«·Œ¢ª˝Ãº
#define DF_RESULT_THROTTLE_SERIOUSLY         0x00000003      // Ω⁄∆¯√≈ª˝Ãº—œ÷ÿ

#define DF_RESULT_FULE_NORMAL                0x00000001      // »º”Õ–ﬁ’˝’˝≥£
#define DF_RESULT_FULE_HIGH                  0x00000002      // »º”Õ–ﬁ’˝∆´≈®
#define DF_RESULT_FULE_LOW                   0x00000003      // »º”Õ–ﬁ’˝∆´œ°
#define DF_RESULT_FULE_ABNORMAL              0x00000004      // »º”Õ–ﬁ’˝“Ï≥£

#define DF_RESULT_MAF_NORMAL                 0x00000001      // Ω¯∆¯¡ø’˝≥£
#define DF_RESULT_MAF_HIGH                   0x00000002      // Ω¯∆¯¡ø∆´¥Û
#define DF_RESULT_MAF_LOW                    0x00000003      // Ω¯∆¯¡ø∆´–°

#define DF_RESULT_INTAKE_PRESSURE_NORMAL     0x00000001      // Ω¯∆¯—π¡¶’˝≥£
#define DF_RESULT_INTAKE_PRESSURE_HIGH       0x00000002      // Ω¯∆¯—π¡¶∆´∏ﬂ

#define DF_RESULT_OXYGEN_NORMAL              0x00000001      // —ı¥´∏–∆˜’˝≥£
#define DF_RESULT_OXYGEN_ERROR               0x00000002      // —ı¥´∏–∆˜≥ˆœ÷π ’œ



/*-----------------------------------------------------------------------------
Àµ    √˜£∫µº∫Ω¿∏TAP¿‡–Õ
-----------------------------------------------------------------------------*/
#define DF_TAP_TYPE_IS_TOP_NAVIG           1          /* ∂•≤øµº∫Ω¿∏     ¿‡–Õ */
#define DF_TAP_TYPE_IS_MSGBOX              2          /* ArtiMsgBox     ¿‡–Õ */
#define DF_TAP_TYPE_IS_INPUT               3          /* ArtiInput      ¿‡–Õ */
#define DF_TAP_TYPE_IS_ACTIVE              4          /* ArtiActive     ¿‡–Õ */
#define DF_TAP_TYPE_IS_ECUINFO             5          /* ArtiEcuInfo    ¿‡–Õ */
#define DF_TAP_TYPE_IS_FILE_DIALOG         6          /* ArtiFileDialog ¿‡–Õ */
#define DF_TAP_TYPE_IS_FREEZE              7          /* ArtiFreeze     ¿‡–Õ */
#define DF_TAP_TYPE_IS_LIST                8          /* ArtiList       ¿‡–Õ */
#define DF_TAP_TYPE_IS_LIVE_DATA           9          /* ArtiLiveData   ¿‡–Õ */
#define DF_TAP_TYPE_IS_MENU                10         /* ArtiMenu       ¿‡–Õ */
#define DF_TAP_TYPE_IS_PICTURE             11         /* ArtiPicture    ¿‡–Õ */
#define DF_TAP_TYPE_IS_SYSTEM              12         /* ArtiSystem     ¿‡–Õ */
#define DF_TAP_TYPE_IS_TROUBLE             13         /* ArtiTrouble    ¿‡–Õ */


////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------
Àµ    √˜£∫µº∫Ω¿∏ Show ∑µªÿ÷µ£¨  ”√”⁄ CArtiNavigation ¿‡ ªÚ’ﬂ CArtiTopTap ¿‡
-----------------------------------------------------------------------------*/
#define DF_ID_TAP_0                        0x00000000
#define DF_ID_TAP_1                        0x00000001
#define DF_ID_TAP_2                        0x00000002
#define DF_ID_TAP_3                        0x00000003
#define DF_ID_TAP_4                        0x00000004
#define DF_ID_TAP_5                        0x00000005
#define DF_ID_TAP_6                        0x00000006
//...
//#define DF_ID_MENU_X                      0x0000XXXX

///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
Àµ    √˜£∫  ”√”⁄ artiShowMsgBoxDs Ω”ø⁄∑µªÿ÷µ
----------------------------------------------------------------------------------*/
#define DF_ID_ADAS_RESULT_BACK             DF_ID_BACK       // µ„ª˜¡À°∞∫ÛÕÀ°±
#define DF_ID_ADAS_RESULT_OK               DF_ID_OK         // µ„ª˜¡À°∞ÕÍ≥…°±
#define DF_ID_ADAS_RESULT_REPORT           DF_ID_REPORT     // µ„ª˜¡À°∞…˙≥…±®∏Ê°±



///////////////////////////////////////////////////////////////////////////////////
/*---------------------------------------------------------------------------------
Àµ    √˜£∫  ”√”⁄ CArtiHidden µƒ Show Ω”ø⁄∑µªÿ÷µ
----------------------------------------------------------------------------------*/
#define DF_ID_HIDDEN_BACK             DF_ID_BACK        // µ„ª˜¡À°∞∫ÛÕÀ°±
#define DF_ID_HIDDEN_OK               DF_ID_OK          // µ„ª˜¡À°∞»∑∂®÷¥––…Ë÷√°±
#define DF_ID_HIDDEN_RESTORE_DATA     DF_ID_RESTORE     // µ„ª˜¡À°∞ª÷∏¥ ˝æ›°±



/////////////////////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------------------------
Àµ    √˜£∫  ”√”⁄ CArtiTopoGraph µƒ SetSvgPath ∫Õ SetUsedLocalData Ω”ø⁄∑µªÿ÷µ
-------------------------------------------------------------------------------------------------*/
#define DF_SVG_PATH_IS_INVALID      0xFFFFFFFF    // ¬∑æ∂∑«∑®£¨ªÚ’ﬂŒƒº˛≤ª¥Ê‘⁄
#define DF_SVG_PATH_OK              0             // …Ë÷√’˝»∑
#define DF_SVG_USED_LOCAL_OK        0             // …Ë÷√’˝»∑
#define DF_SVG_LOCAL_NOT_SUPPORT    DF_APP_CURRENT_NOT_SUPPORT_FUNCTION  // ±Ì æ±æµÿSVG ˝æ›Œƒº˛≤ª÷ß≥÷
#define DF_SVG_API_NOT_SUPPORT      DF_FUNCTION_APP_CURRENT_NOT_SUPPORT  // ±Ì æµ±«∞APP∞Ê±æªπ√ª”–¥ÀΩ”ø⁄

////////////////////////////////////////////////////////////////////////////////////
/*-----------------------------------------------------------------------------
Àµ    √˜£∫œµÕ≥ Ù–‘∫Í∂®“Â£¨”√”⁄stSysReportItemExΩ·ππÃÂ÷–µƒœµÕ≥ Ù–‘uSysProp
-----------------------------------------------------------------------------*/
#define DF_SYS_PROP_DEFAULT                0x00000000   // ƒ¨»œ£¨≥£πÊ
#define DF_SYS_PROP_ADAS                   0x00000001   // æﬂ”–ADASπ¶ƒ‹ Ù–‘
#define DF_SYS_PROP_TPMS                   0x00000002   // æﬂ”–Ã•—ππ¶ƒ‹ Ù–‘


////////////////////////////////////////////////////////////////////////////////////
/*-------------------------------------------------------------------------------
Àµ    √˜£∫œµÕ≥÷¥––Ω·π˚◊¥Ã¨∫Í∂®“Â£¨”√”⁄stSysReportItemExΩ·ππÃÂ÷–µƒ÷¥––◊¥Ã¨uStatus
-------------------------------------------------------------------------------*/
#define DF_SYS_STATUS_ADAS_DEFAULT         0x00000000     // ADASπ¶ƒ‹≤ªø…÷¥––£®ø’∞◊£©
#define DF_SYS_STATUS_ADAS_OK              0x00000001     // ADASπ¶ƒ‹÷¥––OKªÚø…÷¥––£®Yes£©
#define DF_SYS_STATUS_ADAS_FAILED          0x00000002     // ADASπ¶ƒ‹÷¥–– ß∞‹
#endif
