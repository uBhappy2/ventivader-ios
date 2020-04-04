//
//  VentivaderViewController.swift
//  Ventivader
//
//  Created by Amit Rao on 4/3/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import UIKit

class VentivaderViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var inhaleTimeInSecs: UITextField!
    @IBOutlet weak var inhaleHoldInSecs: UITextField!
    @IBOutlet weak var exhaleTimeInSecs: UITextField!
    @IBOutlet weak var exhaleHoldInSecs: UITextField!
    @IBOutlet weak var ventilationCycles: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.inhaleTimeInSecs.delegate = self
        self.inhaleHoldInSecs.delegate = self
        self.exhaleTimeInSecs.delegate = self
        self.exhaleHoldInSecs.delegate = self
        self.ventilationCycles.delegate = self
        
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
}

