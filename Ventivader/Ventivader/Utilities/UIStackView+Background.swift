//
//  UIStackView+Background.swift
//  Ventivader
//
//  Created by Al on 25/05/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import UIKit

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
