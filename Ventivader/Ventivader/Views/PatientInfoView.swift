//
//  PatientInfoView.swift
//  Ventivader
//
//  Created by Al on 08/05/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import UIKit

class PatientInfoView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var innerContainerView: UIView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func setUpWithData(value: String,
                       description: String) {
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel.text = value
            self?.bodyLabel.text = description
        }
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("PatientInfoView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        titleLabel.textColor = ColorPallete.secondaryHighlightColor
        bodyLabel.textColor = ColorPallete.highlightColor
        
        contentView.backgroundColor = ColorPallete.backgroundColor
        innerContainerView.backgroundColor = ColorPallete.secondaryBackgroundColor
    }
}
