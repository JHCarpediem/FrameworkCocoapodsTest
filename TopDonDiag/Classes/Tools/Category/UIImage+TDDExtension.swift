//
//  UIImage+TDDExtension.swift
//  TopdonDiagnosis
//
//  Created by Fench on 2025/8/28.
//

import Foundation
import TDBasis
import TDTheme
import TDUIProvider

//MARK: - 拓展 UIImage 的换肤资源图片
public extension TDThemeBasis where Base == UIImage {
    static var tdd_diagReportHeader: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "section_title_bg") }
    static var tdd_diagReportInfo: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "topdon_report_bg") }
    static var tdd_vciConnect: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "navi_vci_connect") }
    static var tdd_diagVCIConnect: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "navi_vci_connect") }
    static var tdd_diagVCIUnConnect: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "navi_vci_unconnect") }
    static var tdd_diagNavFeedBack: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "navi_feedback_diagnosis") }
    static var tdd_diagNavMore: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "navi_more_diagnosis") }
    static var tdd_diagNavTranslate: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "navi_translate_normal") }
    static var tdd_diagNavTranslateFinish: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "navi_translate_finish") }
    static var tdd_diagNavSearch: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "nav_search_ic") }
    static var tdd_diagNavMoreBG: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "diagnosis_navipop_icon_bg") }
    static var tdd_diagReportPageFooter: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "arti_reportTable_foot") }
    static var tdd_diagReportPageHeader: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "arti_reportTable_head") }
    static var tdd_checkboxSquareSelected: ThemeImagePicker? { UIProvider.Image.checkboxSquareSelected }
    static var tdd_checkboxRoundNormal: ThemeImagePicker? { UIProvider.Image.checkboxRoundNormal }
    static var tdd_checkboxRoundSelect: ThemeImagePicker? { UIProvider.Image.checkboxRoundSelected }
    static var tdd_liveDataSetNumLegend: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "artLive_show_type_one") }
    static var tdd_liveDataSetNumChartLegend: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "artLive_show_type_two") }
    static var tdd_liveDataSetDialLegend: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "artLive_show_type_three") }
    static var tdd_diagLiveDataSetSelectText: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "artiLiveData_select_text") }
    static var tdd_diagLiveDataSetSelectChart: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "artiLiveData_select_chart") }
    static var tdd_diagLiveDataSetSelectDial: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "artiLiveData_select_dial") }
    static var tdd_diagLiveDataSetSelectTextHL: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "artiLiveData_select_text_select") }
    static var tdd_diagLiveDataSetSelectChartHL: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "artiLiveData_select_chart_select") }
    static var tdd_diagLiveDataSetSelectDialHL: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "artiLiveData_select_dial_select") }
    static var tdd_diagLiveDataMore: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "artiLiveData_more") }
    static var tdd_diagKeyboardHightlightBG: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "keyboard_hightlight") }
    static var tdd_diagKeyboardDelete: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "keyboard_exit") }
    static var tdd_diagUpArrow: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "trouble_icon_up_arrow") }
    static var tdd_diagDownArrow: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "trouble_icon_down_arrow") }
    static var tdd_diagBottomTipIcon: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "trouble_icon_note") }
    static var tdd_diagBottomNoteIcon: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "trouble_small_icon_note") }
    static var tdd_diagBottomCloseIcon: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "close_icon") }
    static var tdd_diagHelpUnableIcon: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "artiFreeze_no_help") }
    static var tdd_diagFileDictIcon: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "arti_diag_log_dict") }
    static var tdd_checkboxSquareNormal: ThemeImagePicker? { UIProvider.Image.checkboxSquareNormal }
    static var tdd_checkboxSquareUnselectDisabled: ThemeImagePicker? { UIProvider.Image.checkboxSquareUnselectDisabled }
    static var tdd_diagAIIcon: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "trouble_button_ai_beta") }
    static var tdd_diagAIDisableIcon: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "trouble_button_ai_beta_disable") }
    static var tdd_diagGuildAIIcon: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "diag_trouble_ai_guild_icon") }
    static var tdd_diagBtnLockIcon: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "diag_btn_lock") }
    static var tdd_diageGateWayToBuyImage: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "diag_gateway_purchase_bg") }
    static var tdd_diageGateWayToBuyArrow: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "diag_getway_buy_arrow") }
    static var tdd_diageGateWayChangeAccount: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "diag_change_account") }
    static var tdd_diageGateWayRefresh: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "diag_refresh") }
    static var tdd_diagGateWayFCATopDonLogo: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "FCA_topdon_logo") }
    static var tdd_diagGateWayRenualtLogo: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "FCA_Logo_renualt") }
    static var tdd_diagGateWayNissanLogo: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "FCA_Logo_nissan") }
    static var tdd_diagGateWayVWSFDLogo: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "vw_sfd_logo") }
    static var tdd_diagGateWayDEMOLogo: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "gateway_demo_logo") }
    static var tdd_diagGateWaySwitchBG: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "gateway_switch_unlock_type") }
    static var tdd_SFDSharePopBG: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "artiList_share_back") }
    static var tdd_SFDQrIcon: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "artiList_share_qr") }
    static var tdd_SFDEmailIcon: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "artiList_share_email") }
    static var tdd_diagReportHeaderLogo: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "pdf_car_check_logo") }
    static var tdd_diagReportPageWatermark: ThemeImagePicker? { TDD_UIProvider.themeImage(with: "pdf_fullscreen_watermark") }
}

//MARK: - UIImage 图片资源拓展
public extension UIImage {
    @objc class var tdd_diagReportHeader: UIImage? { UIImage.theme.tdd_diagReportHeader?.image }
    @objc class var tdd_diagReportInfo: UIImage? { UIImage.theme.tdd_diagReportInfo?.image }
    @objc class var tdd_vciConnect: UIImage? { UIImage.theme.tdd_vciConnect?.image }
    @objc class var tdd_diagVCIConnect: UIImage? { UIImage.theme.tdd_diagVCIConnect?.image }
    @objc class var tdd_diagVCIUnConnect: UIImage? { UIImage.theme.tdd_diagVCIUnConnect?.image }
    @objc class var tdd_diagNavFeedBack: UIImage? { UIImage.theme.tdd_diagNavFeedBack?.image }
    @objc class var tdd_diagNavMore: UIImage? { UIImage.theme.tdd_diagNavMore?.image }
    @objc class var tdd_diagNavTranslate: UIImage? { UIImage.theme.tdd_diagNavTranslate?.image }
    @objc class var tdd_diagNavTranslateFinish: UIImage? { UIImage.theme.tdd_diagNavTranslateFinish?.image }
    @objc class var tdd_diagNavSearch: UIImage? { UIImage.theme.tdd_diagNavSearch?.image }
    @objc class var tdd_diagNavMoreBG: UIImage? { UIImage.theme.tdd_diagNavMoreBG?.image }
    @objc class var tdd_diagReportPageFooter: UIImage? { UIImage.theme.tdd_diagReportPageFooter?.image }
    @objc class var tdd_diagReportPageHeader: UIImage? { UIImage.theme.tdd_diagReportPageHeader?.image }
    @objc class var tdd_checkboxSquareSelected: UIImage? { UIImage.theme.tdd_checkboxSquareSelected?.image }
    @objc class var tdd_checkboxRoundNormal: UIImage? { UIImage.theme.tdd_checkboxRoundNormal?.image }
    @objc class var tdd_checkboxRoundSelect: UIImage? { UIImage.theme.tdd_checkboxRoundSelect?.image }
    @objc class var tdd_liveDataSetNumLegend: UIImage? { UIImage.theme.tdd_liveDataSetNumLegend?.image }
    @objc class var tdd_liveDataSetNumChartLegend: UIImage? { UIImage.theme.tdd_liveDataSetNumChartLegend?.image }
    @objc class var tdd_liveDataSetDialLegend: UIImage? { UIImage.theme.tdd_liveDataSetDialLegend?.image }
    @objc class var tdd_diagLiveDataSetSelectText: UIImage? { UIImage.theme.tdd_diagLiveDataSetSelectText?.image }
    @objc class var tdd_diagLiveDataSetSelectChart: UIImage? { UIImage.theme.tdd_diagLiveDataSetSelectChart?.image }
    @objc class var tdd_diagLiveDataSetSelectDial: UIImage? { UIImage.theme.tdd_diagLiveDataSetSelectDial?.image }
    @objc class var tdd_diagLiveDataSetSelectTextHL: UIImage? { UIImage.theme.tdd_diagLiveDataSetSelectTextHL?.image }
    @objc class var tdd_diagLiveDataSetSelectChartHL: UIImage? { UIImage.theme.tdd_diagLiveDataSetSelectChartHL?.image }
    @objc class var tdd_diagLiveDataSetSelectDialHL: UIImage? { UIImage.theme.tdd_diagLiveDataSetSelectDialHL?.image }
    @objc class var tdd_diagLiveDataMore: UIImage? { UIImage.theme.tdd_diagLiveDataMore?.image }
    @objc class var tdd_diagKeyboardHightlightBG: UIImage? { UIImage.theme.tdd_diagKeyboardHightlightBG?.image }
    @objc class var tdd_diagKeyboardDelete: UIImage? { UIImage.theme.tdd_diagKeyboardDelete?.image }
    @objc class var tdd_diagUpArrow: UIImage? { UIImage.theme.tdd_diagUpArrow?.image }
    @objc class var tdd_diagDownArrow: UIImage? { UIImage.theme.tdd_diagDownArrow?.image }
    @objc class var tdd_diagBottomTipIcon: UIImage? { UIImage.theme.tdd_diagBottomTipIcon?.image }
    @objc class var tdd_diagBottomNoteIcon: UIImage? { UIImage.theme.tdd_diagBottomNoteIcon?.image }
    @objc class var tdd_diagBottomCloseIcon: UIImage? { UIImage.theme.tdd_diagBottomCloseIcon?.image }
    @objc class var tdd_diagHelpUnableIcon: UIImage? { UIImage.theme.tdd_diagHelpUnableIcon?.image }
    @objc class var tdd_diagFileDictIcon: UIImage? { UIImage.theme.tdd_diagFileDictIcon?.image }
    @objc class var tdd_checkboxSquareNormal: UIImage? { UIImage.theme.tdd_checkboxSquareNormal?.image }
    @objc class var tdd_checkboxSquareUnselectDisabled: UIImage? { UIImage.theme.tdd_checkboxSquareUnselectDisabled?.image }
    @objc class var tdd_diagAIIcon: UIImage? { UIImage.theme.tdd_diagAIIcon?.image }
    @objc class var tdd_diagAIDisableIcon: UIImage? { UIImage.theme.tdd_diagAIDisableIcon?.image }
    @objc class var tdd_diagGuildAIIcon: UIImage? { UIImage.theme.tdd_diagGuildAIIcon?.image }
    @objc class var tdd_diagBtnLockIcon: UIImage? { UIImage.theme.tdd_diagBtnLockIcon?.image }
    @objc class var tdd_diageGateWayToBuyImage: UIImage? { UIImage.theme.tdd_diageGateWayToBuyImage?.image }
    @objc class var tdd_diageGateWayToBuyArrow: UIImage? { UIImage.theme.tdd_diageGateWayToBuyArrow?.image }
    @objc class var tdd_diageGateWayChangeAccount: UIImage? { UIImage.theme.tdd_diageGateWayChangeAccount?.image }
    @objc class var tdd_diageGateWayRefresh: UIImage? { UIImage.theme.tdd_diageGateWayRefresh?.image }
    @objc class var tdd_diagGateWayFCATopDonLogo: UIImage? { UIImage.theme.tdd_diagGateWayFCATopDonLogo?.image }
    @objc class var tdd_diagGateWayRenualtLogo: UIImage? { UIImage.theme.tdd_diagGateWayRenualtLogo?.image }
    @objc class var tdd_diagGateWayNissanLogo: UIImage? { UIImage.theme.tdd_diagGateWayNissanLogo?.image }
    @objc class var tdd_diagGateWayVWSFDLogo: UIImage? { UIImage.theme.tdd_diagGateWayVWSFDLogo?.image }
    @objc class var tdd_diagGateWayDEMOLogo: UIImage? { UIImage.theme.tdd_diagGateWayDEMOLogo?.image }
    @objc class var tdd_diagGateWaySwitchBG: UIImage? { UIImage.theme.tdd_diagGateWaySwitchBG?.image }
    @objc class var tdd_SFDSharePopBG: UIImage? { UIImage.theme.tdd_SFDSharePopBG?.image }
    @objc class var tdd_SFDQrIcon: UIImage? { UIImage.theme.tdd_SFDQrIcon?.image }
    @objc class var tdd_SFDEmailIcon: UIImage? { UIImage.theme.tdd_SFDEmailIcon?.image }
    @objc class var tdd_diagReportHeaderLogo: UIImage? { UIImage.theme.tdd_diagReportHeaderLogo?.image }
    @objc class var tdd_diagReportPageWatermark: UIImage? { UIImage.theme.tdd_diagReportPageWatermark?.image }
}


//MARK: - 图片资源
public extension TDD_UIProvider {
    struct Image { }
    struct ThemeImage { }
}

public extension TDD_UIProvider.Image {
    static var diagReportHeader: UIImage? { UIImage.tdd_diagReportHeader }
    static var diagReportInfo: UIImage? { UIImage.tdd_diagReportInfo }
    static var vciConnect: UIImage? { UIImage.tdd_vciConnect }
    static var diagVCIConnect: UIImage? { UIImage.tdd_diagVCIConnect }
    static var diagVCIUnConnect: UIImage? { UIImage.tdd_diagVCIUnConnect }
    static var diagNavFeedBack: UIImage? { UIImage.tdd_diagNavFeedBack }
    static var diagNavMore: UIImage? { UIImage.tdd_diagNavMore }
    static var diagNavTranslate: UIImage? { UIImage.tdd_diagNavTranslate }
    static var diagNavTranslateFinish: UIImage? { UIImage.tdd_diagNavTranslateFinish }
    static var diagNavSearch: UIImage? { UIImage.tdd_diagNavSearch }
    static var diagNavMoreBG: UIImage? { UIImage.tdd_diagNavMoreBG }
    static var diagReportPageFooter: UIImage? { UIImage.tdd_diagReportPageFooter }
    static var diagReportPageHeader: UIImage? { UIImage.tdd_diagReportPageHeader }
    static var checkDidSelect: UIImage? { UIImage.tdd_checkboxSquareSelected }
    static var checkboxRoundNormal: UIImage? { UIImage.tdd_checkboxRoundNormal }
    static var checkboxRoundSelect: UIImage? { UIImage.tdd_checkboxRoundSelect }
    static var liveDataSetNumLegend: UIImage? { UIImage.tdd_liveDataSetNumLegend }
    static var liveDataSetNumChartLegend: UIImage? { UIImage.tdd_liveDataSetNumChartLegend }
    static var liveDataSetDialLegend: UIImage? { UIImage.tdd_liveDataSetDialLegend }
    static var diagLiveDataSetSelectText: UIImage? { UIImage.tdd_diagLiveDataSetSelectText }
    static var diagLiveDataSetSelectChart: UIImage? { UIImage.tdd_diagLiveDataSetSelectChart }
    static var diagLiveDataSetSelectDial: UIImage? { UIImage.tdd_diagLiveDataSetSelectDial }
    static var diagLiveDataSetSelectTextHL: UIImage? { UIImage.tdd_diagLiveDataSetSelectTextHL }
    static var diagLiveDataSetSelectChartHL: UIImage? { UIImage.tdd_diagLiveDataSetSelectChartHL }
    static var diagLiveDataSetSelectDialHL: UIImage? { UIImage.tdd_diagLiveDataSetSelectDialHL }
    static var diagLiveDataMore: UIImage? { UIImage.tdd_diagLiveDataMore }
    static var diagKeyboardHightlightBG: UIImage? { UIImage.tdd_diagKeyboardHightlightBG }
    static var diagKeyboardDelete: UIImage? { UIImage.tdd_diagKeyboardDelete }
    static var diagUpArrow: UIImage? { UIImage.tdd_diagUpArrow }
    static var diagDownArrow: UIImage? { UIImage.tdd_diagDownArrow }
    static var diagBottomTipIcon: UIImage? { UIImage.tdd_diagBottomTipIcon }
    static var diagBottomNoteIcon: UIImage? { UIImage.tdd_diagBottomNoteIcon }
    static var diagBottomCloseIcon: UIImage? { UIImage.tdd_diagBottomCloseIcon }
    static var diagHelpUnableIcon: UIImage? { UIImage.tdd_diagHelpUnableIcon }
    static var diagFileDictIcon: UIImage? { UIImage.tdd_diagFileDictIcon }
    static var checkboxSquareNormal: UIImage? { UIImage.tdd_checkboxSquareNormal }
    static var checkboxSquareUnselectDisabled: UIImage? { UIImage.tdd_checkboxSquareUnselectDisabled }
    static var diagAIIcon: UIImage? { UIImage.tdd_diagAIIcon }
    static var diagAIDisableIcon: UIImage? { UIImage.tdd_diagAIDisableIcon }
    static var diagGuildAIIcon: UIImage? { UIImage.tdd_diagGuildAIIcon }
    static var diagBtnLockIcon: UIImage? { UIImage.tdd_diagBtnLockIcon }
    static var diageGateWayToBuyImage: UIImage? { UIImage.tdd_diageGateWayToBuyImage }
    static var diageGateWayToBuyArrow: UIImage? { UIImage.tdd_diageGateWayToBuyArrow }
    static var diageGateWayChangeAccount: UIImage? { UIImage.tdd_diageGateWayChangeAccount }
    static var diageGateWayRefresh: UIImage? { UIImage.tdd_diageGateWayRefresh }
    static var diagGateWayFCATopDonLogo: UIImage? { UIImage.tdd_diagGateWayFCATopDonLogo }
    static var diagGateWayRenualtLogo: UIImage? { UIImage.tdd_diagGateWayRenualtLogo }
    static var diagGateWayNissanLogo: UIImage? { UIImage.tdd_diagGateWayNissanLogo }
    static var diagGateWayVWSFDLogo: UIImage? { UIImage.tdd_diagGateWayVWSFDLogo }
    static var diagGateWayDEMOLogo: UIImage? { UIImage.tdd_diagGateWayDEMOLogo }
    static var diagGateWaySwitchBG: UIImage? { UIImage.tdd_diagGateWaySwitchBG }
    static var SFDSharePopBG: UIImage? { UIImage.tdd_SFDSharePopBG }
    static var SFDQrIcon: UIImage? { UIImage.tdd_SFDQrIcon }
    static var SFDEmailIcon: UIImage? { UIImage.tdd_SFDEmailIcon }
    static var diagReportHeaderLogo: UIImage? { UIImage.tdd_diagReportHeaderLogo }
    static var diagReportPageWatermark: UIImage? { UIImage.tdd_diagReportPageWatermark }
}

public extension TDD_UIProvider.ThemeImage {
    static var diagReportHeader: ThemeImagePicker? { UIImage.theme.tdd_diagReportHeader }
    static var diagReportInfo: ThemeImagePicker? { UIImage.theme.tdd_diagReportInfo }
    static var vciConnect: ThemeImagePicker? { UIImage.theme.tdd_vciConnect }
    static var diagVCIConnect: ThemeImagePicker? { UIImage.theme.tdd_diagVCIConnect }
    static var diagVCIUnConnect: ThemeImagePicker? { UIImage.theme.tdd_diagVCIUnConnect }
    static var diagNavFeedBack: ThemeImagePicker? { UIImage.theme.tdd_diagNavFeedBack }
    static var diagNavMore: ThemeImagePicker? { UIImage.theme.tdd_diagNavMore }
    static var diagNavTranslate: ThemeImagePicker? { UIImage.theme.tdd_diagNavTranslate }
    static var diagNavTranslateFinish: ThemeImagePicker? { UIImage.theme.tdd_diagNavTranslateFinish }
    static var diagNavSearch: ThemeImagePicker? { UIImage.theme.tdd_diagNavSearch }
    static var diagNavMoreBG: ThemeImagePicker? { UIImage.theme.tdd_diagNavMoreBG }
    static var diagReportPageFooter: ThemeImagePicker? { UIImage.theme.tdd_diagReportPageFooter }
    static var diagReportPageHeader: ThemeImagePicker? { UIImage.theme.tdd_diagReportPageHeader }
    static var checkDidSelect: ThemeImagePicker? { UIImage.theme.tdd_checkboxSquareSelected }
    static var checkboxRoundNormal: ThemeImagePicker? { UIImage.theme.tdd_checkboxRoundNormal }
    static var checkboxRoundSelect: ThemeImagePicker? { UIImage.theme.tdd_checkboxRoundSelect }
    static var liveDataSetNumLegend: ThemeImagePicker? { UIImage.theme.tdd_liveDataSetNumLegend }
    static var liveDataSetNumChartLegend: ThemeImagePicker? { UIImage.theme.tdd_liveDataSetNumChartLegend }
    static var liveDataSetDialLegend: ThemeImagePicker? { UIImage.theme.tdd_liveDataSetDialLegend }
    static var diagLiveDataSetSelectText: ThemeImagePicker? { UIImage.theme.tdd_diagLiveDataSetSelectText }
    static var diagLiveDataSetSelectChart: ThemeImagePicker? { UIImage.theme.tdd_diagLiveDataSetSelectChart }
    static var diagLiveDataSetSelectDial: ThemeImagePicker? { UIImage.theme.tdd_diagLiveDataSetSelectDial }
    static var diagLiveDataSetSelectTextHL: ThemeImagePicker? { UIImage.theme.tdd_diagLiveDataSetSelectTextHL }
    static var diagLiveDataSetSelectChartHL: ThemeImagePicker? { UIImage.theme.tdd_diagLiveDataSetSelectChartHL }
    static var diagLiveDataSetSelectDialHL: ThemeImagePicker? { UIImage.theme.tdd_diagLiveDataSetSelectDialHL }
    static var diagLiveDataMore: ThemeImagePicker? { UIImage.theme.tdd_diagLiveDataMore }
    static var diagKeyboardHightlightBG: ThemeImagePicker? { UIImage.theme.tdd_diagKeyboardHightlightBG }
    static var diagKeyboardDelete: ThemeImagePicker? { UIImage.theme.tdd_diagKeyboardDelete }
    static var diagUpArrow: ThemeImagePicker? { UIImage.theme.tdd_diagUpArrow }
    static var diagDownArrow: ThemeImagePicker? { UIImage.theme.tdd_diagDownArrow }
    static var diagBottomTipIcon: ThemeImagePicker? { UIImage.theme.tdd_diagBottomTipIcon }
    static var diagBottomNoteIcon: ThemeImagePicker? { UIImage.theme.tdd_diagBottomNoteIcon }
    static var diagBottomCloseIcon: ThemeImagePicker? { UIImage.theme.tdd_diagBottomCloseIcon }
    static var diagHelpUnableIcon: ThemeImagePicker? { UIImage.theme.tdd_diagHelpUnableIcon }
    static var diagFileDictIcon: ThemeImagePicker? { UIImage.theme.tdd_diagFileDictIcon }
    static var checkboxSquareNormal: ThemeImagePicker? { UIImage.theme.tdd_checkboxSquareNormal }
    static var checkboxSquareUnselectDisabled: ThemeImagePicker? { UIImage.theme.tdd_checkboxSquareUnselectDisabled }
    static var diagAIIcon: ThemeImagePicker? { UIImage.theme.tdd_diagAIIcon }
    static var diagAIDisableIcon: ThemeImagePicker? { UIImage.theme.tdd_diagAIDisableIcon }
    static var diagGuildAIIcon: ThemeImagePicker? { UIImage.theme.tdd_diagGuildAIIcon }
    static var diagBtnLockIcon: ThemeImagePicker? { UIImage.theme.tdd_diagBtnLockIcon }
    static var diageGateWayToBuyImage: ThemeImagePicker? { UIImage.theme.tdd_diageGateWayToBuyImage }
    static var diageGateWayToBuyArrow: ThemeImagePicker? { UIImage.theme.tdd_diageGateWayToBuyArrow }
    static var diageGateWayChangeAccount: ThemeImagePicker? { UIImage.theme.tdd_diageGateWayChangeAccount }
    static var diageGateWayRefresh: ThemeImagePicker? { UIImage.theme.tdd_diageGateWayRefresh }
    static var diagGateWayFCATopDonLogo: ThemeImagePicker? { UIImage.theme.tdd_diagGateWayFCATopDonLogo }
    static var diagGateWayRenualtLogo: ThemeImagePicker? { UIImage.theme.tdd_diagGateWayRenualtLogo }
    static var diagGateWayNissanLogo: ThemeImagePicker? { UIImage.theme.tdd_diagGateWayNissanLogo }
    static var diagGateWayVWSFDLogo: ThemeImagePicker? { UIImage.theme.tdd_diagGateWayVWSFDLogo }
    static var diagGateWayDEMOLogo: ThemeImagePicker? { UIImage.theme.tdd_diagGateWayDEMOLogo }
    static var diagGateWaySwitchBG: ThemeImagePicker? { UIImage.theme.tdd_diagGateWaySwitchBG }
    static var SFDSharePopBG: ThemeImagePicker? { UIImage.theme.tdd_SFDSharePopBG }
    static var SFDQrIcon: ThemeImagePicker? { UIImage.theme.tdd_SFDQrIcon }
    static var SFDEmailIcon: ThemeImagePicker? { UIImage.theme.tdd_SFDEmailIcon }
    static var diagReportHeaderLogo: ThemeImagePicker? { UIImage.theme.tdd_diagReportHeaderLogo }
    static var diagReportPageWatermark: ThemeImagePicker? { UIImage.theme.tdd_diagReportPageWatermark }
}
