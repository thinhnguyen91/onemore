//
//  Font.swift
//  thegirlshop
//
//  Created by Thinh Nguyen on 5/19/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import Foundation
import SwiftUtils

let fontScale = loadFontScale()

func loadFontScale() -> CGFloat {
    if UIDevice.current.userInterfaceIdiom == .pad {
        return 1.3
    }
    return Ratio.widthIPhone6
}

protocol Fontable {
    static var name: String { get }
}

// MARK: - Fontable
extension Fontable {
    static func font(type: String, _ size: CGFloat) -> UIFont {
        let fontName = name + type
        if let font = UIFont(name: fontName, size: size) {
            return font
        }
        return UIFont.systemFont(ofSize: size)
    }
}

protocol JapaneseFontTypeable {
    static func w3(size: CGFloat, scale: CGFloat) -> UIFont
    static func w6(size: CGFloat, scale: CGFloat) -> UIFont
}

struct Font {
    struct Hiragino: Fontable, JapaneseFontTypeable {
        static var name: String { return "HiraginoSans" }
    }
    
    struct American: Fontable, JapaneseFontTypeable {
        static var name: String { return "AmericanTypewriter" }
    }
}

// MARK: - JapaneseFontTypeable
extension JapaneseFontTypeable where Self: Fontable {
    static func w3(size: CGFloat, scale: CGFloat = fontScale) -> UIFont {
        return font(type: "-W3", size * scale)
    }
    
    static func w6(size: CGFloat, scale: CGFloat = fontScale) -> UIFont {
        return font(type: "-W6", size * scale)
    }
}
