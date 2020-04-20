//
//  BLEManager.swift
//  Ventivader
//
//  Created by Al on 18/04/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import CoreBluetooth

class BLEManager: NSObject {
    private var bleOffClosure: (() -> Void)
    private var bleUnauthorizedClosure: (() -> Void)
    private var bleReadyToScan: (() -> Void)
    private var centralManager: CBCentralManager?
    
    init(bleReadyToScan: @escaping (() -> Void),
         bleOffClosure: @escaping (() -> Void),
         bleUnauthorizedClosure: @escaping (() -> Void),
         connected: @escaping (() -> Void)) {
        self.bleOffClosure = bleOffClosure
        self.bleUnauthorizedClosure = bleUnauthorizedClosure
        self.bleReadyToScan =  bleReadyToScan
        
        super.init()
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func stopScanning() {
    }
}

extension BLEManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
            case .unauthorized:
                print("central.state is .unauthorized")
                bleUnauthorizedClosure()
            case .poweredOff:
                bleOffClosure()
            case .poweredOn:
                print("central.state is .poweredOn")
                bleReadyToScan()
                central.scanForPeripherals(withServices: [BLEProperties.serviceUUID], options: nil)
            default:
                break
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        print("Peripheral Found!: \(peripheral)")
        central.stopScan()
        central.connect(peripheral, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }
}

extension BLEManager: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        
        if let service = services.first(where: { $0.uuid == BLEProperties.serviceUUID }) {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral,
                    didDiscoverCharacteristicsFor service: CBService,
                    error: Error?) {
        guard let characteristics = service.characteristics else { return }
        print(characteristics)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
    }
}
