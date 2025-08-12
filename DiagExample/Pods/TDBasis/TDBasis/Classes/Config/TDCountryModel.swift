//
//  TDCountryModel.swift
//  TDBasis
//
//  Created by fench on 2023/8/10.
//

import Foundation

@objc public class TDCountryModel: NSObject {
    @objc dynamic public var id: Int = 0
    @objc dynamic public var countryCode: String = "+86"
    @objc dynamic public var countryName: String = "中国"
    @objc dynamic public var countryAbbreviation: String = "ZHC"
    @objc dynamic public var phoneLength: Int = 11
}
