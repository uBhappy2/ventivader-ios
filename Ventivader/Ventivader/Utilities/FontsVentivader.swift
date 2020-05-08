//
//  VentivaderFonts.swift
//  Ventivader
//
//  Created by Al on 11/04/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import UIKit

class VentivaderFonts {
    static let titleFont = "ONEDAY"
    static let bodyFont = "OpenSans-Regular"
}

extension UILabel {
    func updateFont(name: String, size: CGFloat? = nil){
        let fontSize = size ?? font.pointSize
        self.font = UIFont(name: name, size: fontSize)
    }
}
