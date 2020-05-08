//
//  BaseVC.swift
//  Ventivader
//
//  Created by Al on 05/04/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import UIKit

protocol BaseVC {
    func showSpinner(onView: UIView)
    func removeSpinner(fromView: UIView)
}

extension BaseVC {
    
    func showSpinner(onView: UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        ai.startAnimating()
        ai.center = spinnerView.center
        spinnerView.accessibilityIdentifier = "spinnerView"
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
    }
    
    func removeSpinner(fromView view: UIView) {
        guard let vSpinner = view.subviews.first(where: { $0.accessibilityIdentifier == "spinnerView" }) else { return }
        DispatchQueue.main.async {
            vSpinner.removeFromSuperview()
        }
    }
}
