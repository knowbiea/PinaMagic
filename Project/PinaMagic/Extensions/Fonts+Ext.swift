//
//  Fonts+Ext.swift
//  PinaMagic
//
//  Created by Arvind on 22/02/25.
//

import SwiftUI

enum OpenSans: String {
    case bold = "Bold"
    case semiBold = "SemiBold"
    case extraBold = "ExtraBold"
    case light = "Light"
    case medium = "Medium"
    case regular = "Regular"
    
    func of(size: CGFloat) -> Font {
        return Font.custom("OpenSans-\(self.rawValue)", size: size)
     }
}

extension Font {
    static let bold10 = OpenSans.bold.of(size: 10)
    static let bold16 = OpenSans.bold.of(size: 16)

    static let semiBold10 = OpenSans.semiBold.of(size: 10)
    static let semiBold25 = OpenSans.semiBold.of(size: 25)
    static let semiBold30 = OpenSans.semiBold.of(size: 30)
    
    static let extraBold10 = OpenSans.extraBold.of(size: 10)
    static let extraBold11 = OpenSans.extraBold.of(size: 11)
    
    static let light10 = OpenSans.light.of(size: 10)
    static let light11 = OpenSans.light.of(size: 11)
    
    static let medium10 = OpenSans.medium.of(size: 10)
    static let medium11 = OpenSans.medium.of(size: 11)
    
    static let regular10 = OpenSans.regular.of(size: 10)
    static let regular14 = OpenSans.regular.of(size: 14)
    static let regular16 = OpenSans.regular.of(size: 16)
    
    static let regular35 = OpenSans.regular.of(size: 35)
    static let regular40 = OpenSans.regular.of(size: 40)
    static let regular50 = OpenSans.regular.of(size: 50)
    static let regular55 = OpenSans.regular.of(size: 55)
}
