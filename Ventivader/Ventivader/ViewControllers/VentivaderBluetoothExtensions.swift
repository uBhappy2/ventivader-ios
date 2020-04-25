//
//  VentivaderBluetoothExtensions.swift
//  Ventivader
//
//  Created by Chandra Kashyap on 4/4/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import Foundation
import CoreBluetooth

struct BLEProperties {
    static let uartServiceUUID: CBUUID = CBUUID(string: "6e400001-b5a3-f393-e0a9-e50e24dcca9e")
    static let solenoidParamsUUID: CBUUID = CBUUID(string: "6e400002-b5a3-f393-e0a9-e50e24dcca9e")
    struct Characteristics {
        static let uartTX = CBUUID(string: "6e400002-b5a3-f393-e0a9-e50e24dcca9e")//(Property = Write without response)
        static let uartRX = CBUUID(string: "6e400003-b5a3-f393-e0a9-e50e24dcca9e")// (Property = Read/Notify)
    }
}

extension VentivaderViewController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
          case .unknown:
            print("central.state is .unknown")
          case .resetting:
            print("central.state is .resetting")
          case .unsupported:
            print("central.state is .unsupported")
          case .unauthorized:
            print("central.state is .unauthorized")
          case .poweredOff:
            print("central.state is .poweredOff")
          case .poweredOn:
            print("central.state is .poweredOn")
            centralManager?.scanForPeripherals(withServices: [BLEProperties.uartServiceUUID], options:nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("Peripheral Found!: \(peripheral)")
        centralManager?.stopScan()
        connectedPeripheral = peripheral
        centralManager?.connect(peripheral, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Peripheral Connected!")
        connectedPeripheral = peripheral
        connectedPeripheral?.delegate = self
        connectedPeripheral?.discoverServices(nil)
    }
}

extension VentivaderViewController: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            if service.uuid == BLEProperties.uartServiceUUID {
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }

        for characteristic in characteristics {
            if characteristic.uuid == BLEProperties.solenoidParamsUUID {
                solenoidCharacteristic = characteristic
                peripheral.readValue(for: characteristic)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if characteristic.uuid == BLEProperties.solenoidParamsUUID, let value = characteristic.value {
            currentSolenoidValues = String(data: value, encoding: .utf8)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if error == nil {
            print("Write succeeded")
        } else {
            print("Write failed")
        }
    }
}
