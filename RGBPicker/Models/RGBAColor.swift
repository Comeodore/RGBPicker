//
//  RGBAColor.swift
//  RGBPicker
//
//  Created by Vladimir Maksymchuk on 14.02.2025.
//

import UIKit

struct RGBAColor {
    var red: Float
    var green: Float
    var blue: Float
    let alpha: Float
    
    var uiColor: UIColor {
        UIColor(
            red:   CGFloat(red),
            green: CGFloat(green),
            blue:  CGFloat(blue),
            alpha: CGFloat(alpha)
        )
    }
}
