//
//  ErrorScreenProvider.swift
//  Ventivader
//
//  Created by Al on 19/04/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import Foundation
import UIKit

class ErrorScreenProvider {
    var containerView: UIView = UIView()
    
    func showError(inView view: UIView!,
                   title:String,
                   body: String,
                   buttonTitle: String? = nil,
                   imageView: UIImageView) {
        containerView = UIView(frame: UIScreen.main.bounds)
        containerView.backgroundColor = .white
        
        populateErrorView(title: title,
                          body: body,
                          buttonTitle: buttonTitle,
                          imageView: imageView)
        
        view.addSubview(containerView)
    }
    
    private func populateErrorView(title:String,
                                 body: String,
                                 buttonTitle: String?,
                                 imageView: UIImageView) {
        
        let titleLabel  = UILabel()
        titleLabel.updateFontOnly(name: VentivaderFonts.titleFont)
        titleLabel.text = title
        titleLabel.textAlignment = .center
        
        let bodyLabel  = UILabel()
        bodyLabel.text = body
        bodyLabel.textAlignment = .center
        bodyLabel.numberOfLines = 0
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = ColorPallete.errorBackground
        
        let waveImageView = UIImageView()
        waveImageView.image = UIImage(named: "errorWave")
        
        let actionButton = UIButton()
        actionButton.backgroundColor = ColorPallete.errorBackground
        actionButton.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
        
        actionButton.layer.cornerRadius = 4.0
        
        if let buttonTitle = buttonTitle {
            actionButton.setTitle(buttonTitle, for: .normal)
        } else {
            actionButton.isHidden = true
        }
        
        containerView.addSubview(backgroundView)
        containerView.addSubview(waveImageView)
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(bodyLabel)
        containerView.addSubview(actionButton)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        waveImageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Background Image
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: containerView.topAnchor),
            backgroundView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            backgroundView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5),
            backgroundView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        // Wave UIImage
        NSLayoutConstraint.activate([
            waveImageView.topAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            waveImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            waveImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            waveImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.1),
        ])
        
        
        // Image Constraints
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            imageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.75),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
        ])
        
        // Title Constraints
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: waveImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
        
        // BOdy Constraints
        NSLayoutConstraint.activate([
            bodyLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 8),
        ])
        
        // Action button constrainys
        NSLayoutConstraint.activate([
            actionButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            actionButton.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 16),
        ])
    }
}
