//
//  VentivaderViewController.swift
//  Ventivader
//
//  Created by Amit Rao on 4/3/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import CoreBluetooth
import UIKit

class VentivaderViewController: UIViewController {

    @IBOutlet weak var inhaleTimeInSecs: UITextField!
    @IBOutlet weak var inhaleHoldInSecs: UITextField!
    @IBOutlet weak var exhaleTimeInSecs: UITextField!
    @IBOutlet weak var exhaleHoldInSecs: UITextField!
    @IBOutlet weak var ventilationCycles: UITextField!
    
    var centralManager: CBCentralManager?
    var connectedPeripheral: CBPeripheral?
    var solenoidCharacteristic: CBCharacteristic?
    
    var currentSolenoidValues: String? {
        didSet {
            print("New value received")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
        // Do any additional setup after loading the view, typically from a nib.
        self.inhaleTimeInSecs.delegate = self
        self.inhaleHoldInSecs.delegate = self
        self.exhaleTimeInSecs.delegate = self
        self.exhaleHoldInSecs.delegate = self
        self.ventilationCycles.delegate = self
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
    }

    @IBAction func inhale(_ sender: UIButton) {
        print("Inhale button tapped")
    }
    
    
    @IBAction func exhale(_ sender: UIButton) {
        print("Exhale button tapped")
    }
    
    
    @IBAction func bpm(_ sender: UIButton) {
        print("BPM button tapped")
    }
    
    @IBAction func handleInhaleTime(_ sender: UITextField) {
        if let inhaleTime = sender.text {
            print("Handle inhale time: \(inhaleTime) secs")
        }
    }
    
    @IBAction func handleInhaleHoldTime(_ sender: UITextField) {
        if let inhaleHoldTime = sender.text {
            print("Handle inhale Hold time: \(inhaleHoldTime) secs ")
        }
    }
    
    
    @IBAction func handleExhaleTime(_ sender: UITextField) {
        if let exhaleTime = sender.text {
            print("Handle exhale time: \(exhaleTime) secs")
        }
    }
    
    
    @IBAction func handleExhaleHoldTime(_ sender: UITextField) {
        if let exhaleHoldTime = sender.text {
            print("Handle exhale hold time \(exhaleHoldTime) secs")
        }
    }
    
    
    @IBAction func handleVentilationCycles(_ sender: UITextField) {
        if let ventilationCyclesString = sender.text {
            print("Handle ventilation cycles: \(ventilationCyclesString) ")
        }
    }
    
    @IBAction func sendVentilationProperties(_ sender: UIButton) {
        guard let p1 = inhaleTimeInSecs.text,
            let p2 = inhaleHoldInSecs.text,
            let p3 = exhaleTimeInSecs.text,
            let p4 = exhaleHoldInSecs.text,
            let p5 = ventilationCycles.text else {
                print("ERROR: Properties incomplete!!!!")
                return
        }
        let stringToWrite = "\(p1)|\(p2)|\(p3)|\(p4)|\(p5)"
        print("Following properties will be written \(p1)|\(p2)|\(p3)|\(p4)|\(p5)")
        
        guard let characteristic = solenoidCharacteristic else {
            print("ERROR: Characteristic not found. Cannot write")
            return
        }
        
        guard let dataValue = stringToWrite.data(using: .utf8) else {
            print("ERROR: Cannot create data from inputs")
            return
        }
        connectedPeripheral?.writeValue(dataValue, for: characteristic, type: .withResponse)
    }
    
    @IBAction func resetProperties(_ sender: UIButton) {
        
    }
}

extension VentivaderViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

