//
//  VentilatorControlPanelViewModel.swift
//  Ventivader
//
//  Created by Al on 04/04/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import Foundation


class VentilatorParameterModel {
    var currentValue: String? = "0"
    var units: Unit? = nil
    let description: String
    let defaultValue: String
    
    init(value: String, units: Unit, description: String, defaultValue: String) {
        self.currentValue = value
        self.units = units
        self.description = description
        self.defaultValue = defaultValue
    }
}

final class VentilatorControlPanelViewModel {
    
    private let ventilatoParamatersManager: VentilatorParametersManager
    
    var ventilatorParameters: [VentilatorParameterModel] {
        ventilatoParamatersManager.ventilatorParameters
    }
    
    init(ventilatoParamatersManager: VentilatorParametersManager = VentilatorParametersManager.shared) {
        self.ventilatoParamatersManager = ventilatoParamatersManager
    }
}
