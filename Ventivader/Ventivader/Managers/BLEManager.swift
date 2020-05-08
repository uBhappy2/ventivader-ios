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
    private var connectedToDevice: (() -> Void)
    private var valueUpdatedClosure: ((Data) -> Void)
    private var centralManager: CBCentralManager?
    private var connectedPeripherial: CBPeripheral?
    
    init(bleReadyToScan: @escaping (() -> Void),
         bleOffClosure: @escaping (() -> Void),
         bleUnauthorizedClosure: @escaping (() -> Void),
         connected: @escaping (() -> Void),
         valueUpdatedClosure: @escaping ((Data) -> Void) ) {
        self.bleOffClosure = bleOffClosure
        self.bleUnauthorizedClosure = bleUnauthorizedClosure
        self.bleReadyToScan =  bleReadyToScan
        self.connectedToDevice = connected
        self.valueUpdatedClosure = valueUpdatedClosure
        
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
                central.scanForPeripherals(withServices: [BLEProperties.uartServiceUUID], options: nil)
            default:
                break
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        print("Peripheral Found!: \(peripheral)")
        connectedPeripherial = peripheral
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
        
        if let service = services.first(where: { $0.uuid == BLEProperties.uartServiceUUID }) {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral,
                    didDiscoverCharacteristicsFor service: CBService,
                    error: Error?) {
        guard let characteristics = service.characteristics else { return }
        print(characteristics)
       
        characteristics.forEach { characteristic in
            if characteristic.uuid.isEqual(BLEProperties.Characteristics.uartRX) {
                // Register for UART RX characteristic
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
        connectedToDevice()
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard let characteristicValue = characteristic.value else { return }
        valueUpdatedClosure(characteristicValue)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        print(characteristic)
    }
}
