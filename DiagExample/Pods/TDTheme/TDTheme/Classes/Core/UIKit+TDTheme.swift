//
//  UIKit+Theme.swift
//  TDTheme
//
//  Created by fench on 2023/7/17.
//

import UIKit

//MARK: - UIImage OC 扩展
/**
    oc:  `UIImage * image = [UIImage theme_imageSourced: @"xxx"];`
       `UIImageView *imageView = [UIImageView new];`
       `imageView.theme_image = image;`
 */
@objc public extension UIImage {
    @objc static func theme_image(sourceNamed: String) -> ThemeImagePicker? {
        self.theme.image(sourceNamed: sourceNamed)
    }
    
    @objc static func theme_image(keyPath: String) -> ThemeImagePicker? {
        self.theme.image(keyPath: keyPath)
    }
}

//MARK: - UIImage 扩展
/**
 使用： Swift :  `UIImage.theme.image(sourceNamed: "xxx")`
 `let imageView = UIImageView()`
 `imageView.theme.image = UIImage.theme.image(sourceName: "xxx")`
 */
public extension TDThemeBasis where Base: UIImage {
    
    /// 获取图片 图片图片名的方式。会有缓存
    /// 会先根据配置的皮肤对应的资源路径下读取图片资源 如果读取不到会尝试利用 `imageWithName:`的方式创建
    /// - Parameter sourceNamed: 图片名  如果图片在配置文件所在的目录 直接传入图片名  如果是在子目录中  需要传入  `子目录/图片名`
    /// - Returns: 图片选择器
   static func image(sourceNamed: String) -> ThemeImagePicker? {
        ThemeImagePicker(keyPath: sourceNamed) { _ in
            let imageId = sourceNamed + "-\(TDThemeConfig.skinType)"
            // 先从缓存中读取 如果读取不到再从磁盘读取
            if let img = TDImageCace.shared.image(withIdentifier: imageId) {
                return img
            }
            // 从磁盘中获取图片
            guard let path = ThemeManager.currentThemePath?.URL?.appendingPathComponent(sourceNamed).path,
                  let dicImg = UIImage(contentsOfFile: path) else {
                return UIImage(named: sourceNamed) ?? UIImage()
            }
            // 将图片加入内存缓存
            TDImageCace.shared.add(dicImg, withIdentifier: imageId)
            return dicImg
        }
    }
    
    static func image(keyPath: String) -> ThemeImagePicker? {
        ThemeImagePicker(keyPath: keyPath)
    }
}

//MARK: - UIColor 扩展
/**
 使用： Swift :  `UIColor.theme.color(keyPath: "titleColor")`
 let label = UILabel()
 label.theme.textColor = UIColor.theme.color(keyPath: "titleColor")
 */
public extension TDThemeBasis where Base: UIColor {
    static func color(keyPath: String) -> ThemeColorPicker? {
        ThemeColorPicker(keyPath: keyPath)
    }
}

//MARK: - UIFont 扩展
public extension TDThemeBasis where Base: UIFont {
    static func font(name: String, size: CGFloat, weight: UIFont.Weight) -> ThemeFontPicker? {
        ThemeFontPicker(keyPath: name) { _ in
            guard let fontName = ThemeManager.currentTheme?["name"] as? String else {
                return UIFont.systemFont(ofSize: size, weight: weight)
            }
            return UIFont(name: fontName, size: size)
        }
    }
}

//MARK: - UIView 扩展
public extension TDThemeBasis where Base: UIView {
    var alpha: ThemeCGFloatPicker? {
        get { base.theme_alpha }
        set { base.theme_alpha = newValue }
    }
    var backgroundColor: ThemeColorPicker? {
        get { base.theme_backgroundColor }
        set { base.theme_backgroundColor = newValue }
    }
    var tintColor: ThemeColorPicker? {
        get { base.theme_tintColor }
        set { base.theme_tintColor = newValue }
    }
}

//MARK: - UIImageView 扩展
public extension TDThemeBasis where Base: UIImageView {
    var image: ThemeImagePicker? {
        get {  base.theme_image }
        set { base.theme_image = newValue }
    }
    
    var highlightedImage: ThemeImagePicker? {
        get { base.theme_highlightedImage }
        set { base.theme_highlightedImage = newValue }
    }
}

//MARK: - UIButton 扩展
public extension TDThemeBasis where Base: UIButton {
    func setImage(_ picker: ThemeImagePicker?, forState state: UIControl.State) {
        base.theme_setImage(picker, forState: state)
    }
    func setBackgroundImage(_ picker: ThemeImagePicker?, forState state: UIControl.State) {
        base.theme_setBackgroundImage(picker, forState: state)
    }
    func setTitleColor(_ picker: ThemeColorPicker?, forState state: UIControl.State) {
        base.theme_setTitleColor(picker, forState: state)
    }
    func setAttributedTitle(_ picker: ThemeAttributedStringPicker?, forState state: UIControl.State) {
        base.theme_setAttributedTitle(picker, forState: state)
    }
    
    func setImage(_ picker: ThemeImagePicker?, for state: UIControl.State) {
        base.theme_setImage(picker, forState: state)
    }
    func setBackgroundImage(_ picker: ThemeImagePicker?, for state: UIControl.State) {
        base.theme_setBackgroundImage(picker, forState: state)
    }
    func setTitleColor(_ picker: ThemeColorPicker?, for state: UIControl.State) {
        base.theme_setTitleColor(picker, forState: state)
    }
    func setAttributedTitle(_ picker: ThemeAttributedStringPicker?, for state: UIControl.State) {
        base.theme_setAttributedTitle(picker, forState: state)
    }
}

//MARK: - UILabel 扩展
public extension TDThemeBasis where Base: UILabel {
    var font: ThemeFontPicker? {
        get { base.theme_font }
        set { base.theme_font = newValue }
    }
    var textColor: ThemeColorPicker? {
        get { base.theme_textColor }
        set { base.theme_textColor = newValue }
    }
    var highlightedTextColor: ThemeColorPicker? {
        get { base.theme_highlightedTextColor }
        set { base.theme_highlightedTextColor = newValue }
    }
    var shadowColor: ThemeColorPicker? {
        get { base.theme_shadowColor }
        set { base.theme_shadowColor = newValue }
    }
    var textAttributes: ThemeStringAttributesPicker? {
        get { base.theme_textAttributes }
        set { base.theme_textAttributes = newValue }
    }
    var attributedText: ThemeAttributedStringPicker? {
        get { base.theme_attributedText }
        set { base.theme_attributedText = newValue }
    }
}

//MARK: - CALayer 扩展
public extension TDThemeBasis where Base: CALayer {
    var backgroundColor: ThemeCGColorPicker? {
        get { base.theme_backgroundColor }
        set { base.theme_backgroundColor = newValue }
    }
    var borderWidth: ThemeCGFloatPicker? {
        get { base.theme_borderWidth }
        set { base.theme_borderWidth = newValue }
    }
    var borderColor: ThemeCGColorPicker? {
        get { base.theme_borderColor }
        set { base.theme_borderColor = newValue }
    }
    var shadowColor: ThemeCGColorPicker? {
        get { base.theme_shadowColor }
        set { base.theme_shadowColor = newValue }
    }
    var strokeColor: ThemeCGColorPicker? {
        get { base.theme_strokeColor }
        set { base.theme_strokeColor = newValue }
    }
    var fillColor: ThemeCGColorPicker?{
        get { base.theme_fillColor }
        set { base.theme_fillColor = newValue }
    }
}

//MARK: - UIApplication 扩展
public extension TDThemeBasis where Base: UIApplication {
    #if os(iOS)
    func setStatusBarStyle(_ picker: ThemeStatusBarStylePicker, animated: Bool) {
        base.theme_setStatusBarStyle(picker, animated: animated)
    }
    #endif
}

//MARK: - UIBarItem 扩展
public extension TDThemeBasis where Base: UIBarItem  {
    var image: ThemeImagePicker? {
        get { base.theme_image }
        set { base.theme_image = newValue }
    }
    func setTitleTextAttributes(_ picker: ThemeStringAttributesPicker?, forState state: UIControl.State) {
        base.theme_setTitleTextAttributes(picker, forState: state)
    }
}

//MARK: - UIBarButtonItem 扩展
public extension TDThemeBasis where Base: UIBarButtonItem {
    var tintColor: ThemeColorPicker? {
        get { base.theme_tintColor }
        set { base.theme_tintColor = newValue }
    }
}

//MARK: - UINavigationBar 扩展
public extension TDThemeBasis where Base: UINavigationBar {
    #if os(iOS)
    var barStyle: ThemeBarStylePicker? {
        get { base.theme_barStyle }
        set { base.theme_barStyle = newValue }
    }
    #endif
    var barTintColor: ThemeColorPicker? {
        get { base.theme_barTintColor }
        set { base.theme_barTintColor = newValue }
    }
    var titleTextAttributes: ThemeStringAttributesPicker? {
        get { base.theme_titleTextAttributes }
        set { base.theme_titleTextAttributes = newValue }
    }
    var largeTitleTextAttributes: ThemeStringAttributesPicker? {
        get { base.theme_largeTitleTextAttributes }
        set { base.theme_largeTitleTextAttributes = newValue }
    }
    @available(iOS 13.0, tvOS 13.0, *)
    var standardAppearance: ThemeNavigationBarAppearancePicker? {
        get { base.theme_standardAppearance }
        set { base.theme_standardAppearance = newValue }
    }
    @available(iOS 13.0, tvOS 13.0, *)
    var compactAppearance: ThemeNavigationBarAppearancePicker? {
        get { base.theme_compactAppearance }
        set { base.theme_compactAppearance = newValue }
    }
    @available(iOS 13.0, tvOS 13.0, *)
    var scrollEdgeAppearance: ThemeNavigationBarAppearancePicker? {
        get { base.theme_scrollEdgeAppearance }
        set { base.theme_scrollEdgeAppearance = newValue }
    }
}

//MARK: - UITabBar 扩展
public extension TDThemeBasis where Base: UITabBar {
    #if os(iOS)
    var barStyle: ThemeBarStylePicker? {
        get { base.theme_barStyle }
        set { base.theme_barStyle = newValue }
    }
    #endif
    var unselectedItemTintColor: ThemeColorPicker? {
        get { base.theme_unselectedItemTintColor }
        set { base.theme_unselectedItemTintColor = newValue }
    }
    var barTintColor: ThemeColorPicker? {
        get { base.theme_barTintColor }
        set { base.theme_barTintColor = newValue }
    }

    @available(iOS 13.0, tvOS 13.0, *)
    var standardAppearance: ThemeTabBarAppearancePicker? {
        get { base.theme_standardAppearance }
        set { base.theme_standardAppearance = newValue }
    }
    @available(iOS 13.0, tvOS 13.0, *)
    var compactAppearance: ThemeTabBarAppearancePicker? {
        get { base.theme_compactAppearance }
        set { base.theme_compactAppearance = newValue }
    }
    @available(iOS 13.0, tvOS 13.0, *)
    var scrollEdgeAppearance: ThemeTabBarAppearancePicker? {
        get { base.theme_scrollEdgeAppearance }
        set { base.theme_scrollEdgeAppearance = newValue }
    }
}

//MARK: - UITabBarItem 扩展
public extension TDThemeBasis where Base: UITabBarItem {
    var selectedImage: ThemeImagePicker? {
        get { base.theme_selectedImage }
        set { base.theme_selectedImage = newValue }
    }
}

//MARK: - UITableView 扩展
public extension TDThemeBasis where Base: UITableView {
    var separatorColor: ThemeColorPicker? {
        get { base.theme_separatorColor }
        set { base.theme_separatorColor = newValue }
    }
    var sectionIndexColor: ThemeColorPicker? {
        get { base.theme_sectionIndexColor }
        set { base.theme_sectionIndexColor = newValue }
    }
    var sectionIndexBackgroundColor: ThemeColorPicker? {
        get { base.theme_sectionIndexBackgroundColor }
        set { base.theme_sectionIndexBackgroundColor = newValue }
    }
}

//MARK: - UITextField 扩展
public extension TDThemeBasis where Base: UITextField {
    var font: ThemeFontPicker? {
        get { base.theme_font }
        set { base.theme_font = newValue }
    }
    var keyboardAppearance: ThemeKeyboardAppearancePicker? {
        get { base.theme_keyboardAppearance }
        set { base.theme_keyboardAppearance = newValue }
    }
    var textColor: ThemeColorPicker? {
        get { base.theme_textColor }
        set { base.theme_textColor = newValue }
    }
    var placeholderAttributes: ThemeStringAttributesPicker? {
        get { base.theme_placeholderAttributes }
        set { base.theme_placeholderAttributes = newValue }
    }
}

//MARK: - UITextView 扩展
public extension TDThemeBasis where Base: UITextView {
    var font: ThemeFontPicker? {
        get { base.theme_font }
        set { base.theme_font = newValue }
    }
    var keyboardAppearance: ThemeKeyboardAppearancePicker? {
        get { base.theme_keyboardAppearance }
        set { base.theme_keyboardAppearance = newValue }
    }
    var textColor: ThemeColorPicker? {
        get { base.theme_textColor }
        set { base.theme_textColor = newValue }
    }
}

//MARK: - UISearchBar 扩展
public extension TDThemeBasis where Base: UISearchBar {
    #if os(iOS)
    var barStyle: ThemeBarStylePicker? {
        get { base.theme_barStyle }
        set { base.theme_barStyle = newValue }
    }
    #endif
    var keyboardAppearance: ThemeKeyboardAppearancePicker? {
        get { base.theme_keyboardAppearance }
        set { base.theme_keyboardAppearance = newValue }
    }
    var barTintColor: ThemeColorPicker? {
        get { base.theme_barTintColor }
        set { base.theme_barTintColor = newValue }
    }
}

//MARK: - UIProgressView 扩展
public extension TDThemeBasis where Base: UIProgressView {
    var progressTintColor: ThemeColorPicker? {
        get { base.theme_progressTintColor }
        set { base.theme_progressTintColor = newValue }
    }
    var trackTintColor: ThemeColorPicker? {
        get { base.theme_trackTintColor }
        set { base.theme_trackTintColor = newValue }
    }
}

//MARK: - UIPageControl 扩展
public extension TDThemeBasis where Base: UIPageControl {
    var pageIndicatorTintColor: ThemeColorPicker? {
        get { base.theme_pageIndicatorTintColor }
        set { base.theme_pageIndicatorTintColor = newValue }
    }
    var currentPageIndicatorTintColor: ThemeColorPicker? {
        get { base.theme_currentPageIndicatorTintColor }
        set { base.theme_currentPageIndicatorTintColor = newValue }
    }
}

//MARK: - UIActivityIndicatorView 扩展
public extension TDThemeBasis where Base: UIActivityIndicatorView {
    var color: ThemeColorPicker? {
        get { base.theme_color }
        set { base.theme_color = newValue }
    }
    var activityIndicatorViewStyle: ThemeActivityIndicatorViewStylePicker? {
        get { base.theme_activityIndicatorViewStyle }
        set { base.theme_activityIndicatorViewStyle = newValue }
    }
}

//MARK: - UIScrollView 扩展
public extension TDThemeBasis where Base: UIScrollView {
    var indicatorStyle: ThemeScrollViewIndicatorStylePicker? {
        get { base.theme_indicatorStyle }
        set { base.theme_indicatorStyle = newValue }
    }
}

//MARK: - CATextLayer 扩展
public extension TDThemeBasis where Base: CATextLayer {
    var foregroundColor: ThemeCGColorPicker? {
        get { base.theme_foregroundColor }
        set { base.theme_foregroundColor = newValue }
    }
}

//MARK: - CAGradientLayer 扩展
public extension TDThemeBasis where Base: CAGradientLayer {
    var colors: ThemeAnyPicker? {
        get { base.theme_colors }
        set { base.theme_colors = newValue }
    }
}

#if os(iOS)
//MARK: - UIToolbar 扩展
public extension TDThemeBasis where Base: UIToolbar {
    var barStyle: ThemeBarStylePicker? {
        get { base.theme_barStyle }
        set { base.theme_barStyle = newValue }
    }
    var barTintColor: ThemeColorPicker? {
        get { base.theme_barTintColor }
        set { base.theme_barTintColor = newValue }
    }
}

//MARK: - UISegmentedControl 扩展
public extension TDThemeBasis where Base: UISegmentedControl {
    var selectedSegmentTintColor: ThemeColorPicker? {
        get { base.theme_selectedSegmentTintColor }
        set { base.theme_selectedSegmentTintColor = newValue }
    }
    func theme_setTitleTextAttributes(_ picker: ThemeStringAttributesPicker?, forState state: UIControl.State) {
        base.theme_setTitleTextAttributes(picker, forState: state)
    }
}

//MARK: - UISwitch 扩展
public extension TDThemeBasis where Base: UISwitch {
    var onTintColor: ThemeColorPicker? {
        get { base.theme_onTintColor }
        set { base.theme_onTintColor = newValue }
    }
    var thumbTintColor: ThemeColorPicker? {
        get { base.theme_thumbTintColor }
        set { base.theme_thumbTintColor = newValue }
    }
}

//MARK: - UISlider 扩展
public extension TDThemeBasis where Base: UISlider {
    var thumbTintColor: ThemeColorPicker? {
        get { base.theme_thumbTintColor }
        set { base.theme_thumbTintColor = newValue }
    }
    var minimumTrackTintColor: ThemeColorPicker? {
        get { base.theme_minimumTrackTintColor }
        set { base.theme_minimumTrackTintColor = newValue }
    }
    var maximumTrackTintColor: ThemeColorPicker? {
        get { base.theme_maximumTrackTintColor }
        set { base.theme_maximumTrackTintColor = newValue }
    }
}

//MARK: - UIPopoverPresentationController 扩展
public extension TDThemeBasis where Base: UIPopoverPresentationController {
    var backgroundColor: ThemeColorPicker? {
        get { base.theme_backgroundColor }
        set { base.theme_backgroundColor = newValue }
    }
}

//MARK: - UIRefreshControl 扩展
public extension TDThemeBasis where Base: UIRefreshControl {
    var titleAttributes: ThemeStringAttributesPicker? {
        get { base.theme_titleAttributes }
        set { base.theme_titleAttributes = newValue }
    }
}

//MARK: - UIVisualEffectView 扩展
public extension TDThemeBasis where Base: UIVisualEffectView {
    var effect: ThemeVisualEffectPicker? {
        get { base.theme_effect }
        set { base.theme_effect = newValue }
    }
}

//MARK: - UINavigationBarAppearance 扩展
@available(iOS 13.0, *)
public extension TDThemeBasis where Base: UINavigationBarAppearance {
    var titleTextAttributes: ThemeStringAttributesPicker? {
        get { base.theme_titleTextAttributes }
        set { base.theme_titleTextAttributes = newValue }
    }
    var largeTitleTextAttributes: ThemeStringAttributesPicker? {
        get { base.theme_largeTitleTextAttributes }
        set { base.theme_largeTitleTextAttributes = newValue }
    }
    var backIndicatorImage: ThemeImagePicker? {
        get { base.theme_backIndicatorImage }
        set { base.theme_backIndicatorImage = newValue }
    }
}

//MARK: - UIBarAppearance 扩展
@available(iOS 13.0, *)
public extension TDThemeBasis where Base: UIBarAppearance {
    var backgroundColor: ThemeColorPicker? {
        get { base.theme_backgroundColor }
        set { base.theme_backgroundColor = newValue }
    }
    var backgroundImage: ThemeImagePicker? {
        get { base.theme_backgroundImage }
        set { base.theme_backgroundImage = newValue }
    }
    var backgroundEffect: ThemeBlurEffectPicker? {
        get { base.theme_backgroundEffect }
        set { base.theme_backgroundEffect = newValue }
    }
    var shadowColor: ThemeColorPicker? {
        get { base.theme_shadowColor }
        set { base.theme_shadowColor = newValue }
    }
    var shadowImage: ThemeImagePicker? {
        get { base.theme_shadowImage }
        set { base.theme_shadowImage = newValue }
    }
}
#endif
