//
//  ViewHelper.swift
//  Ventivader
//
//  Created by Al on 10/05/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import UIKit

final class ViewHelper {
    
    func roundProfile(image: UIImageView) {
        image.layer.borderWidth = 3
        image.layer.masksToBounds = false
        image.layer.borderColor = ColorPallete.highlightColor.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
    }
    
    func adjustAsVentivader(button: UIButton) {
        button.backgroundColor = ColorPallete.secondaryBackgroundColor
        button.setTitleColor(ColorPallete.highlightColor, for: .normal)
        button.layer.cornerRadius = 10
    }
}
