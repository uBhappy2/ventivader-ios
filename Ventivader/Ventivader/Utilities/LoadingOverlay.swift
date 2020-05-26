//
//  LoadingOverlay.swift
//  Ventivader
//
//  Created by Al on 19/04/20.
//  Copyright © 2020 calculator. All rights reserved.
//
import UIKit
import Foundation
import SwiftGifOrigin


public class LoadingOverlay {
    
    var overlayView = UIView()
    //var activityIndicator = UIActivityIndicatorView()
    
    private lazy var bleLoaderView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        let animationView = UIImageView()
        animationView.loadGif(name: "bleConnectingAnimation")
        
        let titleLabel = createTitleLabel()
        
        containerView.addSubview(animationView)
        containerView.addSubview(titleLabel)
        
        applyContraints(containerView: containerView,
                        animationView: animationView,
                        titleLabel: titleLabel)
        
        return containerView
    }()
    
    
    func showOverlay(inView view: UIView!) {
        overlayView = UIView(frame: UIScreen.main.bounds)
        overlayView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        
        overlayView.addSubview(bleLoaderView)

        //activityIndicator.startAnimating()
        view.addSubview(overlayView)
        
        bleLoaderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bleLoaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bleLoaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            bleLoaderView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            bleLoaderView.widthAnchor.constraint(equalTo: bleLoaderView.heightAnchor),
        ])
    }
    
    func removeLoadingOverlayView() {
        overlayView.removeFromSuperview()
    }
    
    private func applyContraints(containerView: UIView,
                                 animationView: UIView,
                                 titleLabel: UIView) {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Animation View constraints
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            animationView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            animationView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
            animationView.widthAnchor.constraint(equalTo: animationView.heightAnchor),
        ])
        
        // Title View constraints
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
        
        containerView.layer.cornerRadius = 16
    }
    
    private func createTitleLabel() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = NSLocalizedString("Connecting BLE...", comment: "title for connecting BLE")
        titleLabel.updateFont(name: VentivaderFonts.titleFont)
        titleLabel.textAlignment =  .center
        return titleLabel
    }
}


