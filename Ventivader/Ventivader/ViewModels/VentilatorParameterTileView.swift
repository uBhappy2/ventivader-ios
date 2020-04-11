//
//  VentilatorParameterTileView.swift
//  Ventivader
//
//  Created by Al on 04/04/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import UIKit

final class VentilatorParameterTileView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var leftFooterLabel: UILabel!
    @IBOutlet weak var rightFooterLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    
    class func instanceFromNib() -> VentilatorParameterTileView {
        return UINib(nibName: "VentilatorParameterTileView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! VentilatorParameterTileView
    }

    var ventilatorParameter: VentilatorParameterModel?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUp(ventilatorParameter: VentilatorParameterModel) {
        self.ventilatorParameter = ventilatorParameter
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel.updateFontOnly(name: FontsVentivader.titleFont)
            self?.titleLabel.text = ventilatorParameter.title
            self?.unitLabel.text = ventilatorParameter.units
            self?.valueLabel.text = ventilatorParameter.value
            self?.rightFooterLabel.text = ventilatorParameter.rightFooter
            self?.leftFooterLabel.text = ventilatorParameter.leftFooter
            
            let labels: [UILabel?] = [self?.unitLabel, self?.valueLabel, self?.rightFooterLabel, self?.leftFooterLabel]
            labels.forEach { label in
                label?.isHidden = label?.text == nil
            }
        }
        setupColors()
    }
    
    private func setupColors() {
        DispatchQueue.main.async { [weak self] in
            self?.backgroundColor = ColorPallete.secondaryBackgroundColor
            self?.unitLabel.textColor = ColorPallete.secondaryHighlightColor
            self?.valueLabel.textColor = ColorPallete.highlightColor
            self?.leftFooterLabel.textColor = ColorPallete.secondaryHighlightColor
            self?.rightFooterLabel.textColor = ColorPallete.secondaryHighlightColor
            
            let highlightHeader = self?.ventilatorParameter?.headerHighlight == true
            self?.headerView.backgroundColor =  highlightHeader ? ColorPallete.outstandingBackground : ColorPallete.secondaryBackgroundColor
            self?.titleLabel.textColor =  highlightHeader ? ColorPallete.secondaryBackgroundColor : ColorPallete.highlightColor
        }
    }
}

extension UIView {
    func bindFrameToSuperviewBounds() {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }

        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0).isActive = true
    }
}
