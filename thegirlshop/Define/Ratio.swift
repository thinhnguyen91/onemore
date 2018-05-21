//
//  Ratio.swift
//  thegirlshop
//
//  Created by Thinh Nguyen on 5/13/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import UIKit

public enum DeviceType {
    case iPhone4
    case iPhone5
    case iPhone6
    case iPhone6p
    case iPhoneX
    case iPad
    
    public var size: CGSize {
        switch self {
        case .iPhone4: return CGSize(width: 320, height: 480)
        case .iPhone5: return CGSize(width: 320, height: 568)
        case .iPhone6: return CGSize(width: 375, height: 667)
        case .iPhone6p: return CGSize(width: 414, height: 736)
        case .iPhoneX: return CGSize(width: 375, height: 812)
        case .iPad: return CGSize(width: 768, height: 1024)
        }
    }
}

struct Ratio {
    
    static let horizontal = UIScreen.main.bounds.size.width / DeviceType.iPhone6.size.width
    static let vertical = UIScreen.main.bounds.size.height / DeviceType.iPhone6.size.height
    public static let widthIPhone6 = UIScreen.main.bounds.width / UIScreen.widthIphone6
}


extension UIScreen {
    
    public static var widthIphone6: CGFloat {
        return 375
    }
}
