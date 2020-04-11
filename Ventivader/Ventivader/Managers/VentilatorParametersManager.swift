//
//  VentilatorParametersManager.swift
//  Ventivader
//
//  Created by Al on 05/04/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import Foundation

class VentilatorParameterModel {
    let title: String
    let units: String?
    let value: String?
    var leftFooter: String?
    var rightFooter: String?
    var headerHighlight: Bool

    init(title: String,
         units: String? = nil,
         value: String? = nil,
         leftFooter: String? = nil,
         rightFooter: String? =  nil,
         headerHighlight: Bool = false) {
        
        self.title = title
        self.units = units
        self.value = value
        self.leftFooter = leftFooter
        self.rightFooter = rightFooter
        self.headerHighlight = headerHighlight
    }
}

final class VentilatorParametersManager {
    static let shared = VentilatorParametersManager()

    var ventilatorParameters: [VentilatorParameterModel] = [
        VentilatorParameterModel(title: NSLocalizedString("CONTROL MODE", comment: "Control Panel tile title"),
                                 value: NSLocalizedString("AC", comment: "Control Panel tile value"),
                                 headerHighlight: true),
        VentilatorParameterModel(title: NSLocalizedString("PATIENT", comment: "Control Panel tile title"),
                                 value: "Fake Name",
                                 leftFooter: "68 yrs",
                                 rightFooter: "80 kgs",
                                 headerHighlight: true),
        VentilatorParameterModel(title: NSLocalizedString("BATTERY", comment: "Control Panel tile title"),
                                 headerHighlight: true),
        VentilatorParameterModel(title: NSLocalizedString("PIP", comment: "Control Panel tile title"),
                                 units: "cm H2O",
                                 value: "30",
                                 leftFooter: "Set value: 5"),
        VentilatorParameterModel(title: NSLocalizedString("Compensated VT", comment: "Control Panel tile title"),
                                 units: "ml",
                                 value: "520",
                                 leftFooter: "Set value: 520"),
        VentilatorParameterModel(title: NSLocalizedString("Respiratory Rate", comment: "Control Panel tile title"),
                                 units: "BPM",
                                 value: "16",
                                 leftFooter: "Set value: 16"),
        VentilatorParameterModel(title: NSLocalizedString("PEEP", comment: "Control Panel tile title"),
                                 units: "cm H2O",
                                 value: "4",
                                 leftFooter: "Set value: 4"),
        VentilatorParameterModel(title: NSLocalizedString("MV", comment: "Control Panel tile title"),
                                 units: "Litre",
                                 value: "4",
                                 leftFooter: "Set value: 4"),
        VentilatorParameterModel(title: NSLocalizedString("FiO2", comment: "Control Panel tile title"),
                                 units: "%",
                                 value: "21",
                                 leftFooter: "Set value: -")
    ]
}
