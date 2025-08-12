
@objc public extension NSString {
    var TDDLocalized: String {
        let key = self as String
        let lan = UserDefaults.standard.string(forKey: "AppleTDDHLanguages") ?? "en"
                    
        let framework = Bundle(for: TDD_ArtiMenuModel.self)
                    
        guard let url = framework.url(forResource: "TopdonDiagnosis", withExtension: "bundle"), let bundle = Bundle(url: url) else{
           return key
        }
        guard let path = bundle.path(forResource: lan, ofType: "lproj") else {
           return key
        }
        let localStr = Bundle(path: path)?.localizedString(forKey: key, value: nil, table: nil)
        guard let localStr = localStr, localStr.count > 0 else {
            guard let enPath = Bundle.main.path(forResource: "en", ofType: "lproj") else {
                return key

            }
            let enDefaultStr = Bundle(path: enPath)?.localizedString(forKey: key, value: nil, table: nil)
            guard let enDefaultStr = enDefaultStr, enDefaultStr.count > 0 else {
                return key
            }
            return enDefaultStr
            
        }
        return localStr
    }
    var cnLocalized: String {
        let key = self as String
        guard let cnPath = Bundle.main.path(forResource: "zh-Hans", ofType: "lproj") else {
            return key
        }
        let cnDefaultStr = Bundle(path: cnPath)?.localizedString(forKey: key, value: nil, table: nil)
        guard let cnDefaultStr = cnDefaultStr, cnDefaultStr.count > 0  else {
            return key
        }
        return cnDefaultStr
    }
}
@objc public class TDDLocalized: NSObject {

    /** 确定 */
    @objc public static var app_confirm: String { "app_confirm".TDDLocalized }

    /** 取消 */
    @objc public static var app_cancel: String { "app_cancel".TDDLocalized }

    /** 请稍等... */
    @objc public static var tip_loading: String { "tip_loading".TDDLocalized }

    /** 提示 */
    @objc public static var app_tip: String { "app_tip".TDDLocalized }

    /** 下一步 */
    @objc public static var app_next: String { "app_next".TDDLocalized }

    /** 清除故障码 */
    @objc public static var diagnosis_clear_fault_code: String { "diagnosis_clear_fault_code".TDDLocalized }

    /** 诊断报告 */
    @objc public static var diagnosis_report: String { "diagnosis_report".TDDLocalized }

    /** 一键扫描 */
    @objc public static var diagnosis_scan: String { "diagnosis_scan".TDDLocalized }

    /** 继续 */
    @objc public static var diagnosis_scan_continue: String { "diagnosis_scan_continue".TDDLocalized }

    /** 一键清码 */
    @objc public static var diagnosis_remove_code: String { "diagnosis_remove_code".TDDLocalized }

    /** 显示全部 */
    @objc public static var diagnosis_show_all: String { "diagnosis_show_all".TDDLocalized }

    /** 显示实际 */
    @objc public static var diagnosis_show_actual: String { "diagnosis_show_actual".TDDLocalized }

    /** 帮助 */
    @objc public static var diagnosis_help: String { "diagnosis_help".TDDLocalized }

    /** 未知 */
    @objc public static var diagnosis_unknown: String { "diagnosis_unknown".TDDLocalized }

    /** 不存在 */
    @objc public static var diagnosis_no_exist: String { "diagnosis_no_exist".TDDLocalized }

    /** 有码 */
    @objc public static var diagnosis_dtc_num: String { "diagnosis_dtc_num".TDDLocalized }

    /** 无码 */
    @objc public static var diagnosis_no_dtc: String { "diagnosis_no_dtc".TDDLocalized }

    /** 正在读码，请稍后... */
    @objc public static var diagnosis_reading_code: String { "diagnosis_reading_code".TDDLocalized }

    /** 正在清码，请稍后... */
    @objc public static var diagnosis_clearing_code: String { "diagnosis_clearing_code".TDDLocalized }

    /** 您确定退出自动扫描吗？ */
    @objc public static var diagnosis_back_tip: String { "diagnosis_back_tip".TDDLocalized }

    /** 操作 */
    @objc public static var diagnosis_operation: String { "diagnosis_operation".TDDLocalized }

    /** 单位 */
    @objc public static var diagnosis_unit: String { "diagnosis_unit".TDDLocalized }

    /** 值 */
    @objc public static var diagnosis_value: String { "diagnosis_value".TDDLocalized }

    /** 名称 */
    @objc public static var diagnosis_name: String { "diagnosis_name".TDDLocalized }

    /** 参考值 */
    @objc public static var diagnosis_reference: String { "diagnosis_reference".TDDLocalized }

    /** 好的 */
    @objc public static var app_ok: String { "app_ok".TDDLocalized }

    /** 是 */
    @objc public static var app_yes: String { "app_yes".TDDLocalized }

    /** 否 */
    @objc public static var app_no: String { "app_no".TDDLocalized }

    /** 退出 */
    @objc public static var app_exit: String { "app_exit".TDDLocalized }

    /** 选择车辆 */
    @objc public static var select_vehicle: String { "select_vehicle".TDDLocalized }

    /** 标题 */
    @objc public static var feedback_title: String { "feedback_title".TDDLocalized }

    /** 去连接 */
    @objc public static var to_connect: String { "to_connect".TDDLocalized }

    /** 系统 */
    @objc public static var tsb_notice_system: String { "tsb_notice_system".TDDLocalized }

    /** 保存 */
    @objc public static var person_save: String { "person_save".TDDLocalized }

    /** 保存成功 */
    @objc public static var tip_save_success: String { "tip_save_success".TDDLocalized }

    /** 设置 */
    @objc public static var app_setting: String { "app_setting".TDDLocalized }

    /** 展开 */
    @objc public static var diagnosis_unfold: String { "diagnosis_unfold".TDDLocalized }

    /** 状态 */
    @objc public static var vci_status: String { "vci_status".TDDLocalized }

    /** 全选 */
    @objc public static var report_select_all: String { "report_select_all".TDDLocalized }

    /** 编辑 */
    @objc public static var app_edit: String { "app_edit".TDDLocalized }

    /** 报告 */
    @objc public static var app_report: String { "app_report".TDDLocalized }

    /** 录制 */
    @objc public static var live_data_recording: String { "live_data_recording".TDDLocalized }

    /** 选择数据流 */
    @objc public static var live_data_add: String { "live_data_add".TDDLocalized }

    /** 取消全选 */
    @objc public static var live_data_cancel_all: String { "live_data_cancel_all".TDDLocalized }

    /** 展示方式 */
    @objc public static var live_data_display: String { "live_data_display".TDDLocalized }

    /** 自定义范围 */
    @objc public static var live_data_scope: String { "live_data_scope".TDDLocalized }

    /** 当前值 */
    @objc public static var live_data_scope_current: String { "live_data_scope_current".TDDLocalized }

    /** 车牌号： */
    @objc public static var report_license_plate: String { "report_license_plate".TDDLocalized }

    /** 车辆品牌： */
    @objc public static var report_brand_of_vehicle: String { "report_brand_of_vehicle".TDDLocalized }

    /** 车型： */
    @objc public static var report_model: String { "report_model".TDDLocalized }

    /** 年款： */
    @objc public static var report_year: String { "report_year".TDDLocalized }

    /** 行驶里程： */
    @objc public static var report_driving_distance: String { "report_driving_distance".TDDLocalized }

    /** 发动机： */
    @objc public static var report_engine: String { "report_engine".TDDLocalized }

    /** 子型号： */
    @objc public static var report_sub_models: String { "report_sub_models".TDDLocalized }

    /** 诊断时间： */
    @objc public static var report_diagnosis_time: String { "report_diagnosis_time".TDDLocalized }

    /** 车型软件版本号： */
    @objc public static var report_model_software_version_number: String { "report_model_software_version_number".TDDLocalized }

    /** 诊断应用软件版本： */
    @objc public static var report_application_software_version: String { "report_application_software_version".TDDLocalized }

    /** 诊断路径： */
    @objc public static var report_diagnosis_path: String { "report_diagnosis_path".TDDLocalized }

    /** 客户： */
    @objc public static var report_customer: String { "report_customer".TDDLocalized }

    /** 客户电话： */
    @objc public static var report_customer_telephone_number: String { "report_customer_telephone_number".TDDLocalized }

    /** 概述 */
    @objc public static var report_generalize: String { "report_generalize".TDDLocalized }

    /** 范围值 */
    @objc public static var live_data_scope_title: String { "live_data_scope_title".TDDLocalized }

    /** 故障码 */
    @objc public static var report_fault_code: String { "report_fault_code".TDDLocalized }

    /** 无故障 */
    @objc public static var trouble_free: String { "trouble_free".TDDLocalized }

    /** 恢复默认值 */
    @objc public static var live_data_restore: String { "live_data_restore".TDDLocalized }

    /** 暂停 */
    @objc public static var download_pause: String { "download_pause".TDDLocalized }

    /** 请输入内容 */
    @objc public static var input_hint_report_dialog: String { "input_hint_report_dialog".TDDLocalized }

    /** 车辆信息 */
    @objc public static var report_car_info: String { "report_car_info".TDDLocalized }

    /** 报告名称 */
    @objc public static var report_name: String { "report_name".TDDLocalized }

    /** 数值 */
    @objc public static var report_data_stream_number: String { "report_data_stream_number".TDDLocalized }

    /** 参考数值 */
    @objc public static var report_data_stream_reference: String { "report_data_stream_reference".TDDLocalized }

    /** 历史 */
    @objc public static var report_trouble_code_status_his: String { "report_trouble_code_status_his".TDDLocalized }

    /** 当前 */
    @objc public static var report_trouble_code_status_curr: String { "report_trouble_code_status_curr".TDDLocalized }

    /** 本检测报告仅提供车辆检测维修参考，鼎匠公司不对由此产生的任何事故和故障承担责任。不得私自转让、盗用冒用、涂改或以其他形式篡改，均属无效，且本公司将追究法律责任。 */
    @objc public static var report_disclaimer_content: String { "report_disclaimer_content".TDDLocalized }

    /** 描述 */
    @objc public static var trouble_desc: String { "trouble_desc".TDDLocalized }

    /** 报告编号 */
    @objc public static var report_head_number: String { "report_head_number".TDDLocalized }

    /** 保存视频 */
    @objc public static var liveData_save: String { "liveData_save".TDDLocalized }

    /** 提示：最多只能添加4条组合数据流 */
    @objc public static var liveData_chart_tip: String { "liveData_chart_tip".TDDLocalized }

    /** 组合图形 */
    @objc public static var liveData_chart_more: String { "liveData_chart_more".TDDLocalized }

    /** 保存失败 */
    @objc public static var liveData_save_error: String { "liveData_save_error".TDDLocalized }

    /** 待定 */
    @objc public static var report_trouble_code_status_pending: String { "report_trouble_code_status_pending".TDDLocalized }

    /** 临时 */
    @objc public static var report_trouble_code_status_temporary: String { "report_trouble_code_status_temporary".TDDLocalized }

    /** 生成报告 */
    @objc public static var generate_report: String { "generate_report".TDDLocalized }

    /** VIN： */
    @objc public static var report_vin_code: String { "report_vin_code".TDDLocalized }

    /** 有故障 */
    @objc public static var report_has_error_code: String { "report_has_error_code".TDDLocalized }

    /** 至少选择一项数据流 */
    @objc public static var liveData_select_error: String { "liveData_select_error".TDDLocalized }

    /** 暂无数据 */
    @objc public static var home_no_data_tips: String { "home_no_data_tips".TDDLocalized }

    /** 请在手机设置—蓝牙选项中连接蓝牙：%@ */
    @objc public static var tip_connect_vci: String { "tip_connect_vci".TDDLocalized }

    /** 无此车型 */
    @objc public static var diagnosis_no_car: String { "diagnosis_no_car".TDDLocalized }

    /** 绑定的VCI和当前蓝牙连接的VCI SN不一致 */
    @objc public static var vci_sn_no_agree: String { "vci_sn_no_agree".TDDLocalized }

    /** 免责声明 */
    @objc public static var set_disclaimer: String { "set_disclaimer".TDDLocalized }

    /** 保存报告成功 */
    @objc public static var save_report_success: String { "save_report_success".TDDLocalized }

    /** 后退 */
    @objc public static var back: String { "back".TDDLocalized }

    /** 报告已保存 */
    @objc public static var report_already_save: String { "report_already_save".TDDLocalized }

    /** 总共扫描出%1$d个系统，其中%2$d个系统故障，故障数量为%3$d个。为了安全驾驶请你仔细的分析报告，并修复相关故障信息组件，及时处理排查。 */
    @objc public static var report_overview_content: String { "report_overview_content".TDDLocalized }

    /** 分享 */
    @objc public static var battery_share: String { "battery_share".TDDLocalized }

    /** 故障码报告 */
    @objc public static var fault_code_report: String { "fault_code_report".TDDLocalized }

    /** 数据流报告 */
    @objc public static var data_flow_report: String { "data_flow_report".TDDLocalized }

    /** 全系统报告 */
    @objc public static var full_system_report: String { "full_system_report".TDDLocalized }

    /** T-Darts */
    @objc public static var t_darts: String { "t_darts".TDDLocalized }

    /** 提醒 */
    @objc public static var remind: String { "remind".TDDLocalized }

    /** 请记得将您的VCI接口从车辆的OBD II 接口处移出 */
    @objc public static var diagnose_exit_remind: String { "diagnose_exit_remind".TDDLocalized }

    /** 最多选择$条 */
    @objc public static var most_select: String { "most_select".TDDLocalized }

    /** 请输入数据流名称 */
    @objc public static var search_field_placeholder: String { "search_field_placeholder".TDDLocalized }

    /** 上一步 */
    @objc public static var app_prev: String { "app_prev".TDDLocalized }

    /** 维修前 */
    @objc public static var report_system_type_before: String { "report_system_type_before".TDDLocalized }

    /** 维修后 */
    @objc public static var report_system_type_after: String { "report_system_type_after".TDDLocalized }

    /** 里程： */
    @objc public static var report_mileage: String { "report_mileage".TDDLocalized }

    /** 创建日期 */
    @objc public static var report_head_create_date: String { "report_head_create_date".TDDLocalized }

    /** 第%d页 */
    @objc public static var pages_no: String { "pages_no".TDDLocalized }

    /** 诊断文件读取错误 */
    @objc public static var the_model_file_is_incorrect: String { "the_model_file_is_incorrect".TDDLocalized }

    /** 当前正在数据流录制，是否退出? */
    @objc public static var live_recording_quit_tip: String { "live_recording_quit_tip".TDDLocalized }

    /** 我知道了 */
    @objc public static var app_i_known: String { "app_i_known".TDDLocalized }

    /** 翻译异常 */
    @objc public static var translate_error: String { "translate_error".TDDLocalized }

    /** 就绪 */
    @objc public static var obd_review_ready: String { "obd_review_ready".TDDLocalized }

    /** 未就绪 */
    @objc public static var obd_review_unready: String { "obd_review_unready".TDDLocalized }

    /** 搜索 */
    @objc public static var app_search: String { "app_search".TDDLocalized }

    /** 请输入VIN */
    @objc public static var plase_enter_VIN_code: String { "plase_enter_VIN_code".TDDLocalized }

    /** 请输入17位VIN码 */
    @objc public static var please_input_vin: String { "please_input_vin".TDDLocalized }

    /** 点击此处查看更多功能。 */
    @objc public static var diagnose_guide_tip_one: String { "diagnose_guide_tip_one".TDDLocalized }

    /** 点击进行模糊搜索 */
    @objc public static var diagnose_guide_tip_two: String { "diagnose_guide_tip_two".TDDLocalized }

    /** 遇到诊断问题时，你可以点击反馈按钮将遇到的问题反馈给我们 */
    @objc public static var diagnose_guide_tip_three: String { "diagnose_guide_tip_three".TDDLocalized }

    /** 对当前页面的文字进行翻译或校准 */
    @objc public static var diagnose_guide_tip_four: String { "diagnose_guide_tip_four".TDDLocalized }

    /** 一键退出。 */
    @objc public static var diagnose_guide_tip_five: String { "diagnose_guide_tip_five".TDDLocalized }

    /** 结果 */
    @objc public static var engine_results: String { "engine_results".TDDLocalized }

    /** 条件 */
    @objc public static var list_conditions: String { "list_conditions".TDDLocalized }

    /** 扫描进度 %@% */
    @objc public static var scan_progress: String { "scan_progress".TDDLocalized }

    /** 可忽略 */
    @objc public static var diag_ignore: String { "diag_ignore".TDDLocalized }

    /** 正常 */
    @objc public static var diag_normal: String { "diag_normal".TDDLocalized }

    /** 用户： */
    @objc public static var title_user: String { "title_user".TDDLocalized }

    /** 用户电话： */
    @objc public static var title_user_phone: String { "title_user_phone".TDDLocalized }

    /** 全车健康检测报告 */
    @objc public static var func_system_scan_report: String { "func_system_scan_report".TDDLocalized }

    /** 检测报告 */
    @objc public static var func_diagnose_report: String { "func_diagnose_report".TDDLocalized }

    /** 实时数据报告 */
    @objc public static var func_data_report: String { "func_data_report".TDDLocalized }

    /** 此过程可能持续1-3分钟，请耐心等待。 */
    @objc public static var autovin_time_tips: String { "autovin_time_tips".TDDLocalized }

    /** 自定义 */
    @objc public static var pseudo_custom_title: String { "pseudo_custom_title".TDDLocalized }

    /** 实时数据读取 */
    @objc public static var obd_data_line_title: String { "obd_data_line_title".TDDLocalized }

    /** 本报告可提供给专业汽修厂及相关技师参考。 */
    @objc public static var report_summarize_tips: String { "report_summarize_tips".TDDLocalized }

    /** 复制成功 */
    @objc public static var copy_success: String { "copy_success".TDDLocalized }

    /** 分 */
    @objc public static var divide: String { "divide".TDDLocalized }

    /** 全车系统健康检测评分 */
    @objc public static var system_fraction_title: String { "system_fraction_title".TDDLocalized }

    /** 您的爱车非常健康，请继续保持！ */
    @objc public static var system_score_hint_good: String { "system_score_hint_good".TDDLocalized }

    /** 您的爱车处于亚健康状态，请生成检测报告，尝试清除故障码，并注意维护保养。 */
    @objc public static var system_score_hint_general: String { "system_score_hint_general".TDDLocalized }

    /** 您的爱车存在故障问题，请生成检测报告，尝试清除故障码，并及时维护保养，提前规避风险哦！ */
    @objc public static var system_score_hint_bad: String { "system_score_hint_bad".TDDLocalized }

    /** 请检查您的爱车点火开关是否打开以及%1$s与车辆的连接状态，麻烦重新尝试或咨询客服。 */
    @objc public static var system_score_hint_error: String { "system_score_hint_error".TDDLocalized }

    /** 全系统健康检测 */
    @objc public static var system_title: String { "system_title".TDDLocalized }

    /** 暂无数据，请确认检索内容 */
    @objc public static var all_search_no_data: String { "all_search_no_data".TDDLocalized }

    /** 严重 */
    @objc public static var report_trouble_code_status_seriousness: String { "report_trouble_code_status_seriousness".TDDLocalized }

    /** 轻微 */
    @objc public static var report_trouble_code_status_slight: String { "report_trouble_code_status_slight".TDDLocalized }

    /** 故障 */
    @objc public static var popup_trouble_code_status_title: String { "popup_trouble_code_status_title".TDDLocalized }

    /** 清除故障码前，请确保车辆点火开关已打开，发动机处于熄火状态！是否继续清除故障码？ */
    @objc public static var diagnosis_clear_fault_code_tips: String { "diagnosis_clear_fault_code_tips".TDDLocalized }

    /** 自定义当前数据流的展示方式： */
    @objc public static var live_data_control_title: String { "live_data_control_title".TDDLocalized }

    /** 数据名称 */
    @objc public static var live_data_unit_name_title: String { "live_data_unit_name_title".TDDLocalized }

    /** 参考值范围 */
    @objc public static var live_data_reference_range: String { "live_data_reference_range".TDDLocalized }

    /** 数字 */
    @objc public static var live_data_style_number: String { "live_data_style_number".TDDLocalized }

    /** 表盘 */
    @objc public static var live_data_style_dial: String { "live_data_style_dial".TDDLocalized }

    /** 线形图 */
    @objc public static var live_data_style_line_graph: String { "live_data_style_line_graph".TDDLocalized }

    /** 图例 */
    @objc public static var live_date_legend: String { "live_date_legend".TDDLocalized }

    /** 离开页面但不保存修改？ */
    @objc public static var live_date_leave_tip: String { "live_date_leave_tip".TDDLocalized }

    /** 区域 */
    @objc public static var region: String { "region".TDDLocalized }

    /** 北美 */
    @objc public static var region_american: String { "region_american".TDDLocalized }

    /** 其他 */
    @objc public static var feedback_problem_type_6: String { "feedback_problem_type_6".TDDLocalized }

    /** FCA登录 */
    @objc public static var diag_fca_login: String { "diag_fca_login".TDDLocalized }

    /** 请输入邮箱账号 */
    @objc public static var hint_email: String { "hint_email".TDDLocalized }

    /** 忘记密码? */
    @objc public static var user_login_forgotten: String { "user_login_forgotten".TDDLocalized }

    /** 请输入登录密码 */
    @objc public static var hint_login_password: String { "hint_login_password".TDDLocalized }

    /** 注册 */
    @objc public static var app_sign_up: String { "app_sign_up".TDDLocalized }

    /** 检测结果仅供车辆维修参考，仅用于数据分析。对于检测结果的使用、使用所产生的直接或间接损失和一切法律后果，本公司不承担任何经济和法律责任。 */
    @objc public static var report_disclaimer_content_one: String { "report_disclaimer_content_one".TDDLocalized }

    /** 测试报告不得复制、私自转让、盗用、冒用、涂改或以其他形式篡改，均属无效，且本公司将追求上述行为的法律责任。 */
    @objc public static var report_disclaimer_content_two: String { "report_disclaimer_content_two".TDDLocalized }

    /** 备注: */
    @objc public static var note: String { "note".TDDLocalized }

    /** 请输入用户名或邮箱地址 */
    @objc public static var ple_input_email_or_psd: String { "ple_input_email_or_psd".TDDLocalized }

    /** 账号或密码不能为空 */
    @objc public static var tip_input_email_or_psd_empty: String { "tip_input_email_or_psd_empty".TDDLocalized }

    /** 还没有账号? */
    @objc public static var no_account: String { "no_account".TDDLocalized }

    /** 点击注册 */
    @objc public static var click_register: String { "click_register".TDDLocalized }

    /** 欧洲 */
    @objc public static var region_europe: String { "region_europe".TDDLocalized }

    /** 北美 */
    @objc public static var region_north_american: String { "region_north_american".TDDLocalized }

    /** 故障码数量 */
    @objc public static var trouble_code_count: String { "trouble_code_count".TDDLocalized }

    /** 扫描 */
    @objc public static var diagnostic_button_scan: String { "diagnostic_button_scan".TDDLocalized }

    /** 继续扫描 */
    @objc public static var system_continue_scan: String { "system_continue_scan".TDDLocalized }

    /** 故障 */
    @objc public static var fault: String { "fault".TDDLocalized }

    /** 更多 */
    @objc public static var upgrade_more: String { "upgrade_more".TDDLocalized }

    /** 使用12+8转接头测试（需要拆下网关，支持全部功能）\n不使用转接头（仅支持版本信息、读故障码和数据流功能） */
    @objc public static var fca_other_hint: String { "fca_other_hint".TDDLocalized }

    /** 请输入AutoAuth注册的用户名或邮箱地址 */
    @objc public static var ple_input_autoauth_email_hint: String { "ple_input_autoauth_email_hint".TDDLocalized }

    /** 知道了 */
    @objc public static var got_it: String { "got_it".TDDLocalized }

    /** 发动机转速 */
    @objc public static var engine_speed: String { "engine_speed".TDDLocalized }

    /** 无 */
    @objc public static var app_no_data: String { "app_no_data".TDDLocalized }

    /** 维修建议 */
    @objc public static var maintenance_proposal: String { "maintenance_proposal".TDDLocalized }

    /** 位置 */
    @objc public static var diag_position: String { "diag_position".TDDLocalized }

    /** 根目录 */
    @objc public static var diag_root_dict: String { "diag_root_dict".TDDLocalized }

    /** 上一级目录 */
    @objc public static var diag_pre_dict: String { "diag_pre_dict".TDDLocalized }

    /** 技术支持 */
    @objc public static var tech_support: String { "tech_support".TDDLocalized }

    /** 支持电子邮件 */
    @objc public static var support_email: String { "support_email".TDDLocalized }

    /** 网址 */
    @objc public static var web: String { "web".TDDLocalized }

    /** 全车健康检测 */
    @objc public static var func_system_scan: String { "func_system_scan".TDDLocalized }

    /** 位置 */
    @objc public static var app_position: String { "app_position".TDDLocalized }

    /** 正在通讯，请稍候... */
    @objc public static var system_readdtcing: String { "system_readdtcing".TDDLocalized }

    /** 发动机检测报告 */
    @objc public static var engine_report_default_name: String { "engine_report_default_name".TDDLocalized }

    /** 请在iPhone的"设置-隐私-相机"中允许%@访问相机 */
    @objc public static var allow_access_iPhone_camera: String { "allow_access_iPhone_camera".TDDLocalized }

    /** 请在iPhone的"设置-隐私-照片"选项中，允许%@访问你的手机相册 */
    @objc public static var allow_access_iPhone_photos: String { "allow_access_iPhone_photos".TDDLocalized }

    /** 从相册获取 */
    @objc public static var select_photo_from_photos: String { "select_photo_from_photos".TDDLocalized }

    /** 拍照 */
    @objc public static var report_image_camera: String { "report_image_camera".TDDLocalized }

    /** 从相册获取 */
    @objc public static var report_image_photos: String { "report_image_photos".TDDLocalized }

    /** 燃油表 */
    @objc public static var fuel_meter: String { "fuel_meter".TDDLocalized }

    /** 总校准时长 */
    @objc public static var total_exec_time: String { "total_exec_time".TDDLocalized }

    /** 校准时间 */
    @objc public static var exec_time: String { "exec_time".TDDLocalized }

    /** 校准参数 */
    @objc public static var exec_parameters: String { "exec_parameters".TDDLocalized }

    /** 校准成功! */
    @objc public static var calibration_success: String { "calibration_success".TDDLocalized }

    /** 校准失败! */
    @objc public static var calibration_fail: String { "calibration_fail".TDDLocalized }

    /** 左前轮 */
    @objc public static var left_front_wheel: String { "left_front_wheel".TDDLocalized }

    /** 左后轮 */
    @objc public static var left_rear_wheel: String { "left_rear_wheel".TDDLocalized }

    /** 右前轮 */
    @objc public static var right_front_wheel: String { "right_front_wheel".TDDLocalized }

    /** 右后轮 */
    @objc public static var right_rear_wheel: String { "right_rear_wheel".TDDLocalized }

    /** 图片 */
    @objc public static var picture: String { "picture".TDDLocalized }

    /** 轮胎压力 */
    @objc public static var tire_pressure: String { "tire_pressure".TDDLocalized }

    /** 轮眉高度 */
    @objc public static var wheel_eyebrow_height: String { "wheel_eyebrow_height".TDDLocalized }

    /** 请输入 */
    @objc public static var please_enter: String { "please_enter".TDDLocalized }

    /** ADAS执行信息 */
    @objc public static var adas_execution_info: String { "adas_execution_info".TDDLocalized }

    /** 无ADAS校准记录 */
    @objc public static var exec_adas_none: String { "exec_adas_none".TDDLocalized }

    /** 燃油液位 */
    @objc public static var fuel_level: String { "fuel_level".TDDLocalized }

    /** 请输入%1$s内的数字 */
    @objc public static var input_num_range: String { "input_num_range".TDDLocalized }

    /** 燃油不足，建议补充燃油再重试 */
    @objc public static var insufficient_fuel_tip: String { "insufficient_fuel_tip".TDDLocalized }

    /** 车辆数据 */
    @objc public static var vehicle_data: String { "vehicle_data".TDDLocalized }

    /** 输入车辆的燃油液位高度，方便计算动态校准数据 */
    @objc public static var input_oli: String { "input_oli".TDDLocalized }

    /** ADAS标定 */
    @objc public static var adas_calibration: String { "adas_calibration".TDDLocalized }

    /** 当前车辆不支持ADAS标定功能 */
    @objc public static var adas_calibration_no_support: String { "adas_calibration_no_support".TDDLocalized }

    /** 输入车辆的轮眉高度，方便计算动态校准数据 */
    @objc public static var input_wheel_brow: String { "input_wheel_brow".TDDLocalized }

    /** 轮眉高度偏差过大（%1$s），建议修改后再试 */
    @objc public static var wheel_brow_error: String { "wheel_brow_error".TDDLocalized }

    /** 提示：点击或拖动下方区域以确定燃油液位。 */
    @objc public static var oli_select_tip: String { "oli_select_tip".TDDLocalized }

    /** 前轮左右轮眉高度偏差过大（%1$s），建议修改后再试 */
    @objc public static var wheel_brow_front_error: String { "wheel_brow_front_error".TDDLocalized }

    /** 后轮左右轮眉高度偏差过大（%1$s），建议修改后再试 */
    @objc public static var wheel_brow_rear_error: String { "wheel_brow_rear_error".TDDLocalized }

    /** 保存位置：我的 / 数据流 */
    @objc public static var save_location: String { "save_location".TDDLocalized }

    /** 暂停扫描 */
    @objc public static var system_pause_scan: String { "system_pause_scan".TDDLocalized }

    /** 你的爱车有故障码，请生成检测报告，尝试清除故障码，并及时维护保养。 */
    @objc public static var system_score_hint_general_carpal: String { "system_score_hint_general_carpal".TDDLocalized }

    /** 维修中 */
    @objc public static var report_system_type_ing: String { "report_system_type_ing".TDDLocalized }

    /** 维修单号： */
    @objc public static var maintenance_bill_number: String { "maintenance_bill_number".TDDLocalized }

    /** 二维码 */
    @objc public static var qr_code: String { "qr_code".TDDLocalized }

    /** 邮箱 */
    @objc public static var sign_email: String { "sign_email".TDDLocalized }

    /** 扫描二维码 */
    @objc public static var scan_qr: String { "scan_qr".TDDLocalized }

    /** 扫描二维码分享 */
    @objc public static var scan_qr_code_to_share: String { "scan_qr_code_to_share".TDDLocalized }

    /** 请输入正确的邮箱账号 */
    @objc public static var lms_enter_email_error_tips: String { "lms_enter_email_error_tips".TDDLocalized }

    /** 发送 */
    @objc public static var send: String { "send".TDDLocalized }

    /** 到： */
    @objc public static var to: String { "to".TDDLocalized }

    /** 本次运行不再提醒 */
    @objc public static var dialog_vci_vol_tips: String { "dialog_vci_vol_tips".TDDLocalized }

    /** 当前车辆电压过低，请及时对电瓶进行充电。电瓶保持12V左右的电压测试效果最佳。\n测试过程中，请按提示要求进行车辆操作。 */
    @objc public static var dialog_vci_vol_content: String { "dialog_vci_vol_content".TDDLocalized }

    /** 因操作中断当前诊断服务异常，请退出功能重新进入后再检测。 */
    @objc public static var dialog_diag_process_content: String { "dialog_diag_process_content".TDDLocalized }

    /** 因操作中断当前蓝牙已断开，请保持蓝牙连接状态进行测试。 */
    @objc public static var dialog_blue_process_content: String { "dialog_blue_process_content".TDDLocalized }

    /** 蓝牙已断开，请保持蓝牙连接状态进行测试。 */
    @objc public static var dialog_blue_content: String { "dialog_blue_content".TDDLocalized }

    /** 登录 */
    @objc public static var app_sign_in: String { "app_sign_in".TDDLocalized }

    /** 请输入邮件内容 */
    @objc public static var email_content_error_tip: String { "email_content_error_tip".TDDLocalized }

    /** 网络连接错误，请检查网络。 */
    @objc public static var network_is_abnormal_check_the_network: String { "network_is_abnormal_check_the_network".TDDLocalized }

    /** 当前%s用户无%s的解锁权益，请购买后使用 */
    @objc public static var unlock_rights_need_buy: String { "unlock_rights_need_buy".TDDLocalized }

    /** 雷诺同意在法国时间当天午夜至晚上 23:59 的 24 小时内，对同一 VIN 的三 (3) 次连接只收取一次费用。 */
    @objc public static var unlock_count_rule_detail: String { "unlock_count_rule_detail".TDDLocalized }

    /** 1. 网关 ECU（CGW）目前处于锁定状态。请先解锁，以执行高级诊断测试，例如特殊功能、动作测试以及将存储的数据写入 ECU。\n\n2. 解锁网关 ECU（CGW）需要您的设备连接到互联网，并登录 TOPDON 用户中心。请确保您已使用与此设备关联的帐户登录。 */
    @objc public static var renault_gateway_hint: String { "renault_gateway_hint".TDDLocalized }

    /** 无解锁权限 */
    @objc public static var unlock_rights_zero: String { "unlock_rights_zero".TDDLocalized }

    /** 网关解锁权限剩余 */
    @objc public static var unlock_rights_left: String { "unlock_rights_left".TDDLocalized }

    /** 当前账号 */
    @objc public static var now_acocunt: String { "now_acocunt".TDDLocalized }

    /** 网关解锁权限购买 */
    @objc public static var unlock_rights_to_buy: String { "unlock_rights_to_buy".TDDLocalized }

    /** 解锁 */
    @objc public static var diag_unlock: String { "diag_unlock".TDDLocalized }

    /** 信息 */
    @objc public static var detail_info: String { "detail_info".TDDLocalized }

    /** 请输入邮箱地址 */
    @objc public static var please_enter_email: String { "please_enter_email".TDDLocalized }

    /** 解锁使用次数统计规则 */
    @objc public static var unlock_count_rule: String { "unlock_count_rule".TDDLocalized }

    /** 电话 */
    @objc public static var contact_number: String { "contact_number".TDDLocalized }

    /** 续费 */
    @objc public static var renewal: String { "renewal".TDDLocalized }

    /** 邮箱格式错误 */
    @objc public static var login_email_error_tip: String { "login_email_error_tip".TDDLocalized }

    /** 当前连接SN */
    @objc public static var current_connect_sn: String { "current_connect_sn".TDDLocalized }

    /** 诊断软件有效期 */
    @objc public static var software_period_of_validity: String { "software_period_of_validity".TDDLocalized }

    /** 获取失败 */
    @objc public static var get_faild: String { "get_faild".TDDLocalized }

    /** 切换查询权益账号 */
    @objc public static var exchange_query_account: String { "exchange_query_account".TDDLocalized }

    /** 该账号不存在或者已被禁用 */
    @objc public static var account_not_exist_or_forbidden: String { "account_not_exist_or_forbidden".TDDLocalized }

    /** 1.安全网关当前处于锁定状态，请先进行网关解锁以便执行如特殊功能、主动测试以及向ECU写入存储数据等高阶诊断功能。\n\n2.解锁安全网关需要您的设备连接到网络并登录有解锁权限的Topdon账号。 \n\n3.雷诺网关解锁包的有效期为一年。并且对于同一车辆识别码（VIN）在 24 小时内的三次连接仅做一次计费（从法国时间当天零点至晚上 23:59）。 */
    @objc public static var gateway_buy_tips: String { "gateway_buy_tips".TDDLocalized }

    /** 点击查看操作指引 */
    @objc public static var click_for_instructions: String { "click_for_instructions".TDDLocalized }

    /** 更换账号 */
    @objc public static var update_account: String { "update_account".TDDLocalized }

    /** 权益所属账号 */
    @objc public static var equity_account_2: String { "equity_account_2".TDDLocalized }

    /** 备注：切换账号后，本次购买权益在该账号生效。 */
    @objc public static var update_equity_account_tips: String { "update_equity_account_tips".TDDLocalized }

    /** 加载超时，请稍后重试 */
    @objc public static var http_time_out: String { "http_time_out".TDDLocalized }

    /** 请输入账号 */
    @objc public static var please_enter_account: String { "please_enter_account".TDDLocalized }

    /** 录制数据流时请勿切换到图形模式 */
    @objc public static var live_record_switch_tip: String { "live_record_switch_tip".TDDLocalized }

    /** VCI连接异常，请检查VCI连接状态 */
    @objc public static var tips_vci_unconnect: String { "tips_vci_unconnect".TDDLocalized }

    /** 1. 网关 ECU（CGW）目前处于锁定状态。请先解锁，以执行高级诊断测试，例如特殊功能、动作测试以及将存储的数据写入 ECU。\n\n2. 解锁网关 ECU（CGW）需要您的设备连接到互联网，并登录用户中心。请确保您已使用与此设备关联的帐户登录。 */
    @objc public static var renault_gateway_hint_neutral: String { "renault_gateway_hint_neutral".TDDLocalized }

    /** 1.安全网关当前处于锁定状态，请先进行网关解锁以便执行如特殊功能、主动测试以及向ECU写入存储数据等高阶诊断功能。\n\n2.解锁安全网关需要您的设备连接到网络并登录有解锁权限的账号。 \n\n3.雷诺网关解锁包的有效期为一年。并且对于同一车辆识别码（VIN）在 24 小时内的三次连接仅做一次计费（从法国时间当天零点至晚上 23:59）。 */
    @objc public static var gateway_buy_tips_neutral: String { "gateway_buy_tips_neutral".TDDLocalized }

    /** 本检测报告仅提供车辆检测维修参考，本公司不对由此产生的任何事故和故障承担责任。不得私自转让、盗用冒用、涂改或以其他形式篡改，均属无效，且本公司将追究法律责任。 */
    @objc public static var report_disclaimer_content_neutral: String { "report_disclaimer_content_neutral".TDDLocalized }

    /** 您的诊断软件已到期，如果您想进一步查看详细故障码或进行清码，请续费 */
    @objc public static var software_fuction_expire_tip: String { "software_fuction_expire_tip".TDDLocalized }

    /** 去购买 */
    @objc public static var buy_car: String { "buy_car".TDDLocalized }

    /** 点击Topfix功能，我们将解答您遇到的关于车辆故障维修的所有问题 */
    @objc public static var diag_trouble_ai_leed: String { "diag_trouble_ai_leed".TDDLocalized }

    /** 去续费 */
    @objc public static var go_to_renewal: String { "go_to_renewal".TDDLocalized }

    /** 当前软件已过期！继续使用请联系供应商进行购买。 */
    @objc public static var software_is_out_of_date_custom: String { "software_is_out_of_date_custom".TDDLocalized }

    /** 网关解锁权限购买（仅欧洲） */
    @objc public static var gateway_purchase_nissan: String { "gateway_purchase_nissan".TDDLocalized }

    /** 1.安全网关当前处于锁定状态，请先进行网关解锁以便执行如特殊功能、主动测试以及向ECU写入存储数据等高阶诊断功能。\n2.解锁安全网关需要您的设备连接到网络并登录有解锁权限的Topdon账号。 */
    @objc public static var renault_gateway_hint_new_nissan: String { "renault_gateway_hint_new_nissan".TDDLocalized }

    /** 权益账号： */
    @objc public static var fca_current_account_number: String { "fca_current_account_number".TDDLocalized }

    /** 系统状态 */
    @objc public static var report_system_status: String { "report_system_status".TDDLocalized }

    /** 权限状态 */
    @objc public static var permission_status: String { "permission_status".TDDLocalized }

    /** 次数 */
    @objc public static var count: String { "count".TDDLocalized }

    /** 截止日期 */
    @objc public static var deadline: String { "deadline".TDDLocalized }

    /** 无限制 */
    @objc public static var unlimited: String { "unlimited".TDDLocalized }

    /** 邮箱格式不正确 */
    @objc public static var tips_email_improper: String { "tips_email_improper".TDDLocalized }

    /** AutoAuth账号解锁 */
    @objc public static var auto_auth_unlock: String { "auto_auth_unlock".TDDLocalized }

    /** TOPDON账号解锁 */
    @objc public static var topdon_unlock: String { "topdon_unlock".TDDLocalized }

    /** 为进一步优化我们的产品服务，防止出现功能盗用情况，我们需要进行身份验证流程。请开启验证流程后再使用 */
    @objc public static var tips_authentication: String { "tips_authentication".TDDLocalized }

    /** 立即开启 */
    @objc public static var user_immediate_open: String { "user_immediate_open".TDDLocalized }

    /** 说明 */
    @objc public static var explanation: String { "explanation".TDDLocalized }

    /** 当前APP登录账号与网关解锁账号不一致，为保护您的用户权益，我们将进行身份验证流程。请以%@账号登录APP并进入个人中心开启二次验证功能。 */
    @objc public static var tips_authentication_account_error: String { "tips_authentication_account_error".TDDLocalized }

    /** 第三方处理 */
    @objc public static var third_party_processing: String { "third_party_processing".TDDLocalized }

    /** 1.识别到该车配备了SGW(安全网关)模块，部分功能需要解锁该功能才能进行。\n\n2.解锁安全网关需要您的设备连接到网络并登录有解锁权限的Topdon账号。\n\n3.该功能需要进行双重身份验证。您需要在个人中心或有功能提示时按照指示进行身份验证。正常情况下，一旦解锁模块，同一次APP运行过程中将保持90分钟，在此过程中无需重复解锁。 */
    @objc public static var fca_gateway_hint: String { "fca_gateway_hint".TDDLocalized }

    /** 1.安全网关当前处于锁定状态，请先进行网关解锁以便执行如特殊功能、主动测试以及向ECU写入存储数据等高阶诊断功能。\n\n2.解锁安全网关需要您的设备连接到网络并登录有解锁权限的Topdon账号。\n\n3.该功能需要进行双重身份验证。您需要在个人中心或有功能提示时按照指示进行身份验证。正常情况下，一旦解锁模块，同一次APP运行过程中将保持90分钟，在此过程中无需重复解锁。 */
    @objc public static var vw_gateway_hint: String { "vw_gateway_hint".TDDLocalized }

    /** 1.本次解锁仅为一个网关解锁的演示过程，所有数据均为虚拟。\n\n2.是否需要解锁根据车辆而定，当前FCA、VAG、Nissan、Renault等品牌需要解锁。\n\n3.相关网关解锁权限需要从软件商城购买。 */
    @objc public static var demo_gateway_hint: String { "demo_gateway_hint".TDDLocalized }

    /** 1.识别到该车配备了SGW(安全网关)模块，部分功能需要解锁该功能才能进行。\n\n2.解锁安全网关需要您的设备连接到网络并登录有解锁权限的账号。\n\n3.该功能需要进行双重身份验证。您需要在个人中心或有功能提示时按照指示进行身份验证。正常情况下，一旦解锁模块，同一次APP运行过程中将保持90分钟，在此过程中无需重复解锁。 */
    @objc public static var fca_gateway_hint_deepscan: String { "fca_gateway_hint_deepscan".TDDLocalized }

    /** 1.安全网关当前处于锁定状态，请先进行网关解锁以便执行如特殊功能、主动测试以及向ECU写入存储数据等高阶诊断功能。\n\n2.解锁安全网关需要您的设备连接到网络并登录有解锁权限的账号。\n\n3.雷诺网关解锁包的有效期为一年。并且对于同一车辆识别码（VIN）在 24 小时内的三次连接仅做一次计费（从法国时间当天零点至晚上 23:59）。 */
    @objc public static var gateway_buy_tips_neutral_deepscan: String { "gateway_buy_tips_neutral_deepscan".TDDLocalized }

    /** 1.安全网关当前处于锁定状态，请先进行网关解锁以便执行如特殊功能、主动测试以及向ECU写入存储数据等高阶诊断功能。\n\n2.解锁安全网关需要您的设备连接到网络并登录有解锁权限的账号。 */
    @objc public static var renault_gateway_hint_new_nissan_deepscan: String { "renault_gateway_hint_new_nissan_deepscan".TDDLocalized }

    /** 1.安全网关当前处于锁定状态，请先进行网关解锁以便执行如特殊功能、主动测试以及向ECU写入存储数据等高阶诊断功能。\n\n2.解锁安全网关需要您的设备连接到网络并登录有解锁权限的账号。\n\n3.该功能需要进行双重身份验证。您需要在个人中心或有功能提示时按照指示进行身份验证。正常情况下，一旦解锁模块，同一次APP运行过程中将保持90分钟，在此过程中无需重复解锁。 */
    @objc public static var vw_gateway_hint_deepscan: String { "vw_gateway_hint_deepscan".TDDLocalized }

    /** 购买提示 */
    @objc public static var buy_tips: String { "buy_tips".TDDLocalized }

    /** 当前车型软件为演示程序，无需进行购买。后续使用其他车型软件时如无权限则需进入商城进行购买。 */
    @objc public static var demo_buy_tips: String { "demo_buy_tips".TDDLocalized }

    /** 扫描文本 */
    @objc public static var scan_text: String { "scan_text".TDDLocalized }

    /** 注意 */
    @objc public static var setting_notice: String { "setting_notice".TDDLocalized }

    /** 蓝牙已断开 */
    @objc public static var bluetooth_disconnect_tips: String { "bluetooth_disconnect_tips".TDDLocalized }

    /** 电压过低 */
    @objc public static var voltage_low: String { "voltage_low".TDDLocalized }

    /** 软件已过期 */
    @objc public static var software_expired: String { "software_expired".TDDLocalized }

    /** 您的诊断软件已过期，如果想执行清码功能，请续费。 */
    @objc public static var software_fuction_expire_tip_new: String { "software_fuction_expire_tip_new".TDDLocalized }

    /** 粘贴 */
    @objc public static var paste_text: String { "paste_text".TDDLocalized }

    /** TOPDON账号 */
    @objc public static var topdon_account: String { "topdon_account".TDDLocalized }

    /** 1.识别到该车配备了SGW(安全网关)模块，部分功能需要解锁该功能才能进行。\n2.解锁安全网关需要您的设备连接到网络并登录有解锁权限的账号。\n3.请根据您所在区域选择合适的解锁方式，北美地区（美国，加拿大，墨西哥）请选择autoauth \n4.同时部分品牌存在差异性，具体可咨询汽车制造商 */
    @objc public static var fca_north_america_gateway_hint: String { "fca_north_america_gateway_hint".TDDLocalized }

    /** 1.识别到该车配备了SGW(安全网关)模块，部分功能需要解锁该功能才能进行。\n2.解锁安全网关需要您的设备连接到网络并登录有解锁权限的账号。\n3.该功能需要进行双重身份验证。您需要在个人中心或有功能提示时按照指示进行身份验证。正常情况下，一旦解锁模块，同一次APP运行过程中将保持90分钟，在此过程中无需重复解锁。\n4.请根据您所在区域选择合适的解锁方式，北美地区（美国，加拿大，墨西哥）请选择autoauth \n5.同时部分品牌存在差异性，具体可咨询汽车制造商 */
    @objc public static var fca_other_gateway_hint: String { "fca_other_gateway_hint".TDDLocalized }

    /** 1.安全网关当前处于锁定状态，请先进行网关解锁以便执行如特殊功能、主动测试以及向ECU写入存储数据等高阶诊断功能。\n2.解锁安全网关需要您的设备连接到网络并登录有解锁权限的账号。\n3.请根据您所在区域选择合适的解锁方式，北美地区（美国，加拿大，墨西哥）请选择autoauth \n4.同时部分品牌存在差异性，具体可咨询汽车制造商 */
    @objc public static var nissan_gateway_hint: String { "nissan_gateway_hint".TDDLocalized }

    /** 解锁方式 */
    @objc public static var unlock_method: String { "unlock_method".TDDLocalized }

    /** 其他区域 */
    @objc public static var other_regions: String { "other_regions".TDDLocalized }

    /** 欧洲FCA官网 */
    @objc public static var europe_fca_official_site: String { "europe_fca_official_site".TDDLocalized }

    /** 全部删除 */
    @objc public static var clear_all: String { "clear_all".TDDLocalized }

    /** 确定删除全部历史记录 */
    @objc public static var clear_all_history_tips: String { "clear_all_history_tips".TDDLocalized }

    /** 支持X轴Y轴的手势缩放 */
    @objc public static var support_xy_scaling: String { "support_xy_scaling".TDDLocalized }

    /** 操作指引 */
    @objc public static var operation_guide: String { "operation_guide".TDDLocalized }

}
