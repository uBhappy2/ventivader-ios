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
    private var bleManager: BLEManager?
    private var timer: Timer?
    
    var ventilatorParameters: [VentilatorParameterModel] {
        ventilatoParamatersManager.ventilatorParameters
    }
    
    init(ventilatoParamatersManager: VentilatorParametersManager = VentilatorParametersManager.shared) {
        self.ventilatoParamatersManager = ventilatoParamatersManager
    }
    
    func connectBLE(bleOff: @escaping () -> Void,
                    bleUnauthorizedClosure: @escaping () -> Void,
                    deviceFound: @escaping () -> Void,
                    deviceNotFound: @escaping () -> Void,
                    valueUpdatedClosure: @escaping (Data) -> Void) {
        bleManager = BLEManager(bleReadyToScan: { [weak self] in
            self?.timer = Timer.scheduledTimer(withTimeInterval: 35.0, repeats: false) { [weak self] _ in
                self?.invalidateTimer()
                self?.bleManager?.stopScanning()
                deviceNotFound()
            }
        }, bleOffClosure: { [weak self] in
            bleOff()
            self?.invalidateTimer()
        }, bleUnauthorizedClosure: { [weak self] in
            bleUnauthorizedClosure()
            self?.invalidateTimer()
        }, connected: { [weak self] in
            deviceFound()
            self?.invalidateTimer()
        }, valueUpdatedClosure: valueUpdatedClosure )
    }
    
    deinit {
        invalidateTimer()
    }
    
    private func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
}
