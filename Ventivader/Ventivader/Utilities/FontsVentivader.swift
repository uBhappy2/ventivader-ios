//
//  FontsVentivader.swift
//  Ventivader
//
//  Created by Al on 11/04/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import UIKit

class FontsVentivader {
    static let titleFont = "ONEDAY"
}

extension UILabel {
    func updateFontOnly(name: String){
        self.font = UIFont(name: name, size: self.font.pointSize)
    }
}
