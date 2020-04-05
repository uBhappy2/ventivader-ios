//
//  ParameterFieldView.swift
//  Ventivader
//
//  Created by Al on 04/04/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import UIKit

class ParameterFieldView: UIView {

    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var parameterNameLabel: UILabel!
    @IBOutlet weak var parameterValueTextField: UITextField!

    class func instanceFromNib() -> ParameterFieldView {
        return UINib(nibName: "ParameterFieldView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! ParameterFieldView
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUp(ventilatorParameter: VentilatorParameterModel ) {
        DispatchQueue.main.async { [weak self] in
            self?.parameterValueTextField.text = ventilatorParameter.currentValue
            self?.unitsLabel.text = ventilatorParameter.units?.symbol
            self?.parameterNameLabel.text = ventilatorParameter.description
        }
    }
}
