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
    static let serviceUUID: CBUUID = CBUUID(string: "2E70DF6A-7FAB-44A4-9B20-C12F5D1E726C")
    static let solenoidParamsUUID: CBUUID = CBUUID(string: "2E70DF6B-7FAB-44A4-9B20-C12F5D1E726C")
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
            centralManager?.scanForPeripherals(withServices: [BLEProperties.serviceUUID], options:nil)
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
            if service.uuid == BLEProperties.serviceUUID {
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
