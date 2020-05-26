//
//  MainTabBarController.swift
//  Ventivader
//
//  Created by Al on 08/05/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var patientInfo: PatientInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabColors()
    }
    
    private func setupTabColors() {
        tabBar.barTintColor = ColorPallete.backgroundColor
        tabBar.tintColor = ColorPallete.highlightColor
        tabBar.unselectedItemTintColor = ColorPallete.secondaryHighlightColor
    }
}
