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
    var actionButtonTapClosure: (() -> Void)?
    
    func showError(inView view: UIView!,
                   title:String,
                   body: String,
                   buttonTitle: String? = nil,
                   imageView: UIImageView,
                   actionButtonTapClosure: (() -> Void)? = nil ) {
        self.actionButtonTapClosure = actionButtonTapClosure
        
        containerView = UIView(frame: UIScreen.main.bounds)
        containerView.backgroundColor = .white
        
        populateErrorView(title: title,
                          body: body,
                          buttonTitle: buttonTitle,
                          imageView: imageView)
        
        view.addSubview(containerView)
    }
    
    func dismissCurrentErorView() {
        DispatchQueue.main.async { [weak self] in
            self?.containerView.removeFromSuperview()
        }
    }
    
    @objc private func actionButtonTap(){
        actionButtonTapClosure?()
    }
    
    private func populateErrorView(title:String,
                                 body: String,
                                 buttonTitle: String?,
                                 imageView: UIImageView) {
        
        let titleLabel  = UILabel()
        titleLabel.updateFont(name: VentivaderFonts.titleFont, size: 25)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.text = title
        titleLabel.textAlignment = .center
        
        let bodyLabel  = UILabel()
        bodyLabel.updateFont(name: VentivaderFonts.bodyFont)
        bodyLabel.text = body
        bodyLabel.textAlignment = .center
        bodyLabel.numberOfLines = 0
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = ColorPallete.errorBackground
        
        let waveImageView = UIImageView()        
        waveImageView.image = UIImage(named: "errorWave")
        
        let actionButton = UIButton()
        actionButton.titleLabel?.updateFont(name: VentivaderFonts.bodyFont)
        actionButton.backgroundColor = ColorPallete.errorBackground
        actionButton.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
        actionButton.layer.cornerRadius = 4.0
        
        if let buttonTitle = buttonTitle {
            actionButton.setTitle(buttonTitle, for: .normal)
        } else {
            actionButton.isHidden = true
        }
        
        actionButton.addTarget(self, action: #selector(actionButtonTap), for: .touchUpInside)
        
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
        
        let safeContainerArea = containerView.safeAreaLayoutGuide
        
        // Background Image
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: safeContainerArea.topAnchor),
            backgroundView.widthAnchor.constraint(equalTo: safeContainerArea.widthAnchor),
            backgroundView.heightAnchor.constraint(equalTo: safeContainerArea.heightAnchor, multiplier: 0.5),
            backgroundView.centerXAnchor.constraint(equalTo: safeContainerArea.centerXAnchor)
        ])
        
        // Wave UIImage
        NSLayoutConstraint.activate([
            waveImageView.topAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            waveImageView.widthAnchor.constraint(equalTo: safeContainerArea.widthAnchor),
            waveImageView.centerXAnchor.constraint(equalTo: safeContainerArea.centerXAnchor),
            waveImageView.heightAnchor.constraint(equalTo: safeContainerArea.heightAnchor, multiplier: 0.1),
        ])
        
        
        // Image Constraints
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: safeContainerArea.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: safeContainerArea.topAnchor, constant: 32),
            imageView.widthAnchor.constraint(equalTo: safeContainerArea.widthAnchor, multiplier: 0.75),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
        ])
        
        // Title Constraints
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: safeContainerArea.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: waveImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: safeContainerArea.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: safeContainerArea.trailingAnchor, constant: -16),
        ])
        
        // Body Constraints
        NSLayoutConstraint.activate([
            bodyLabel.centerXAnchor.constraint(equalTo: safeContainerArea.centerXAnchor),
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            bodyLabel.leadingAnchor.constraint(equalTo: safeContainerArea.leadingAnchor, constant: 8),
            bodyLabel.trailingAnchor.constraint(equalTo: safeContainerArea.trailingAnchor, constant: -8),
        ])
        
        // Action button constrainys
        NSLayoutConstraint.activate([
            actionButton.centerXAnchor.constraint(equalTo: safeContainerArea.centerXAnchor),
            actionButton.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 16),
        ])
    }
}
