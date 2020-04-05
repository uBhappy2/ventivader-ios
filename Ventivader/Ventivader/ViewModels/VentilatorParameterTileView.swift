//
//  VentilatorParameterTileView.swift
//  Ventivader
//
//  Created by Al on 04/04/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import UIKit

final class VentilatorParameterTileView: UIView {
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    class func instanceFromNib() -> VentilatorParameterTileView {
        return UINib(nibName: "VentilatorParameterTileView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! VentilatorParameterTileView
    }

    var ventilatorParameter: VentilatorParameterModel?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUp(ventilatorParameter: VentilatorParameterModel ) {
        DispatchQueue.main.async { [weak self] in
            self?.valueLabel.text = ventilatorParameter.currentValue
            self?.unitsLabel.text = ventilatorParameter.units?.symbol
            self?.descriptionLabel.text = ventilatorParameter.description
        }
    }
}

extension UIView {
    func bindFrameToSuperviewBounds() {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }

        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0).isActive = true
    }
}
