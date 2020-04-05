//
//  UpdateVentilatorParametersViewModel.swift
//  Ventivader
//
//  Created by Al on 05/04/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import Foundation

final class UpdateVentilatorParametersViewModel {
    
    private let ventilatoParamatersManager: VentilatorParametersManager
    
    var ventilatorParameters: [VentilatorParameterModel] {
        return ventilatoParamatersManager.ventilatorParameters
    }
    
    init(ventilatoParamatersManager: VentilatorParametersManager = VentilatorParametersManager.shared) {
        self.ventilatoParamatersManager = ventilatoParamatersManager
    }
    
    func resetParameterValues(){
        ventilatoParamatersManager.resetParameters()
    }
    
    func updateParameter(value:String?, forIndex index: Int) {
        ventilatoParamatersManager.updateParameter(value:value,
                                                   forIndex: index)
    }
}
