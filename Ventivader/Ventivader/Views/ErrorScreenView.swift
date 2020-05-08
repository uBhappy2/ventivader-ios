//
//  ErrorScreen.swift
//  Ventivader
//
//  Created by Al on 26/04/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import UIKit

class ErrorScreenView: UIView {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    @IBOutlet var topButton: UIButton!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var imageView: UIImageView!
    
    private var topButtonClosure: (() -> Void)?
    
    class func instanceFromNib() -> ErrorScreenView {
        return UINib(nibName: "ErrorScreenView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! ErrorScreenView
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpView() {
        backgroundView.backgroundColor = ColorPallete.errorBackground
        
        // Fonts
        titleLabel.updateFont(name: VentivaderFonts.titleFont)
        bodyLabel.updateFont(name: VentivaderFonts.bodyFont)
        topButton.titleLabel?.updateFont(name: VentivaderFonts.bodyFont)
        
        // Button
        topButton.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
        topButton.layer.cornerRadius = 4.0
        topButton.backgroundColor = ColorPallete.errorBackground
        topButton.setTitleColor(.white, for: .normal)
    }
    
    func populateErrorView(title: String,
                           body: String,
                           buttonTitle: String?,
                           topButtonClosure: (() -> Void)? = nil,
                           gifName: String?) {
        setUpView()
        titleLabel.text = title
        bodyLabel.text = body
        
        if let gifName = gifName {
            imageView.loadGif(name: gifName)
        }
        
        if let buttonTitle = buttonTitle {
            topButton.setTitle(buttonTitle, for: .normal)
            self.topButtonClosure = topButtonClosure
        } else {
            topButton.isHidden = true
            self.topButtonClosure = nil
        }
    }
    
    @IBAction func topButtonTap(_ sender: Any) {
        topButtonClosure?()
    }
}
