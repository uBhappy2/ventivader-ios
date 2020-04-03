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
    @IBOutlet weak var ventilationCycle: UITextField!
    
    @IBOutlet weak var delegate: UITextFieldDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        print("Handle inhale time ")
    }
    
    @IBAction func handleInhaleHoldTime(_ sender: UITextField) {
        print("Handle inhale Hold time ")
    }
    
    
    @IBAction func handleExhaleTime(_ sender: UITextField) {
        print("Handle exhale time ")
    }
    
    
    @IBAction func handleExhaleHoldTime(_ sender: UITextField) {
        print("Handle exhale hold time")
    }
    
    
    @IBAction func handleVentilationCycles(_ sender: UITextField) {
        print("Handle ventilation cycles")
    }
}

