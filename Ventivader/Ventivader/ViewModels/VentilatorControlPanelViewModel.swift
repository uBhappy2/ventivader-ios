//
//  VentilatorControlPanelViewModel.swift
//  Ventivader
//
//  Created by Al on 04/04/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import Foundation

final class VentilatorControlPanelViewModel {
    
    private let ventilatoParamatersManager: VentilatorParametersManager
    
    var ventilatorParameters: [VentilatorParameterModel] {
        ventilatoParamatersManager.ventilatorParameters
    }
    
    init(ventilatoParamatersManager: VentilatorParametersManager = VentilatorParametersManager.shared) {
        self.ventilatoParamatersManager = ventilatoParamatersManager
    }
}
