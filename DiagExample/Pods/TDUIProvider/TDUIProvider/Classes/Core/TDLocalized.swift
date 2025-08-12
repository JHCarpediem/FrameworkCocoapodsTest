
extension String {
    fileprivate var localized: String {
        td.localized
    }
}
@objc public class UILocalized: NSObject {

    /** 向上拖动以刷新 */
    @objc public static var tip_drag_refresh: String { "tip_drag_refresh".localized }

    /** 正在加载内容... */
    @objc public static var tip_loading_more: String { "tip_loading_more".localized }
    
    /** 没有更多内容 */
    @objc public static var tip_no_more_content: String { "tip_no_more_content".localized }

    /** 下拉刷新 */
    @objc public static var lms_pull_to_refresh: String { "lms_pull_to_refresh".localized }

    /** 松开刷新 */
    @objc public static var lms_free_to_refresh: String { "lms_free_to_refresh".localized }

    /** 正在刷新 */
    @objc public static var lms_refreshing: String { "lms_refreshing".localized }

    /** 刷新成功 */
    @objc public static var lms_refresh_success: String { "lms_refresh_success".localized }

}
