//
//  EdgeInsets+TDExtension.swift
//  TDBasis
//
//  Created by fench on 2023/7/29.
//

import UIKit


public extension UIEdgeInsets {
    init(insets: CGFloat) {
        self.init(top: insets, left: insets, bottom: insets, right: insets)
    }
    
    /// Creates an `EdgeInsets` with the horizontal value equally divided and applied to right and left.
    ///               And the vertical value equally divided and applied to top and bottom.
    ///
    ///
    /// - Parameter horizontal: Inset to be applied to right and left.
    /// - Parameter vertical: Inset to be applied to top and bottom.
    init(horizontals: CGFloat, verticals: CGFloat) {
        self.init(top: verticals / 2, left: horizontals / 2, bottom: verticals / 2, right: horizontals / 2)
    }
}


extension UIEdgeInsets: TDCompatibleValue { }
public extension TDBasisWrap where Base == UIEdgeInsets {
    /// Creates an `EdgeInsets` based on current value and top offset.
    ///
    /// - Parameters:
    ///   - top: Offset to be applied in to the top edge.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(top: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: base.top + top, left: base.left, bottom: base.bottom, right: base.right)
    }

    /// Creates an `EdgeInsets` based on current value and left offset.
    ///
    /// - Parameters:
    ///   - left: Offset to be applied in to the left edge.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(left: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: base.top, left: base.left + left, bottom: base.bottom, right: base.right)
    }

    /// Creates an `EdgeInsets` based on current value and bottom offset.
    ///
    /// - Parameters:
    ///   - bottom: Offset to be applied in to the bottom edge.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(bottom: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: base.top, left: base.left, bottom: base.bottom + bottom, right: base.right)
    }

    /// Creates an `EdgeInsets` based on current value and right offset.
    ///
    /// - Parameters:
    ///   - right: Offset to be applied in to the right edge.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(right: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: base.top, left: base.left, bottom: base.bottom, right: base.right + right)
    }

    /// Creates an `EdgeInsets` based on current value and horizontal value equally divided and applied to right offset and left offset.
    ///
    /// - Parameters:
    ///   - horizontal: Offset to be applied to right and left.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(horizontal: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: base.top, left: base.left + horizontal / 2, bottom: base.bottom, right: base.right + horizontal / 2)
    }

    /// Creates an `EdgeInsets` based on current value and vertical value equally divided and applied to top and bottom.
    ///
    /// - Parameters:
    ///   - vertical: Offset to be applied to top and bottom.
    /// - Returns: EdgeInsets offset with given offset.
    func insetBy(vertical: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: base.top + vertical / 2, left: base.left, bottom: base.bottom + vertical / 2, right: base.right)
    }
}
