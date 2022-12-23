//
//  ColorExtension.swift
//  testApp
//
//  Created by Artem on 23/12/2022.
//

import SwiftUI

extension UIColor {
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
        var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
            let coreImageColor = self.coreImageColor
            return (coreImageColor.red, coreImageColor.green, coreImageColor.blue, coreImageColor.alpha)
        }
    }
