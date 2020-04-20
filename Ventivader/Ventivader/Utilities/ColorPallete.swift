//
//  ColorPallete.swift
//  Ventivader
//
//  Created by Al on 10/04/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import UIKit

class ColorPallete {
    // Colors obtained from: https://colorhunt.co/palettes/dark
    static let backgroundColor = UIColor(hex: "#1b262c")!
    static let secondaryBackgroundColor = UIColor(hex: "#0f4c75")!
    static let secondaryHighlightColor = UIColor(hex: "#3282b8")!
    static let highlightColor = UIColor(hex: "#bbe1fa")!
    static let outstandingBackground = UIColor(hex: "#e6c62f")!
    
    // Errors
    static let errorBackground = UIColor(red: 8/255.0, green: 24/255.0, blue: 51/255.0, alpha: 1.0 )
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            // "+ `ff`" adds the alpha channel
            let hexColor = String(hex[start...]) + "ff"

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
