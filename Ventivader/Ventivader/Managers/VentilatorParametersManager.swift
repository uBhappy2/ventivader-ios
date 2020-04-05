//
//  VentilatorParametersManager.swift
//  Ventivader
//
//  Created by Al on 05/04/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import Foundation

final class VentilatorParametersManager {
    
    static let shared = VentilatorParametersManager()
    
    var ventilatorParameters: [VentilatorParameterModel] = [
        VentilatorParameterModel(value: "1", units: UnitDuration.seconds, description: NSLocalizedString("Inhale time", comment: ""), defaultValue: "0"),
        VentilatorParameterModel(value: "2", units: UnitDuration.seconds, description: NSLocalizedString("Inhale hold", comment: ""), defaultValue: "100"),
        VentilatorParameterModel(value: "3", units: UnitDuration.seconds, description: NSLocalizedString("Exhale time", comment: ""), defaultValue: "0"),
        VentilatorParameterModel(value: "4", units: UnitDuration.seconds, description: NSLocalizedString("Exhale hold", comment: ""), defaultValue: "100"),
        VentilatorParameterModel(value: "5", units: Unit.init(symbol: "#"), description: NSLocalizedString("Ventilation cycle", comment: ""), defaultValue: "0")
    ]
    
    func resetParameters() {
        ventilatorParameters.forEach({ param in param.currentValue = param.defaultValue })
    }
    
    func updateParameter(value:String?,forIndex index: Int) {
        ventilatorParameters[index].currentValue = value
    }
}
