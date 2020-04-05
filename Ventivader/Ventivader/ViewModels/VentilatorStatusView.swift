//
//  VentilatorStatusView.swift
//  Ventivader
//
//  Created by Al on 04/04/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import UIKit

struct StatusViewModel {
    let color: UIColor
    let description: String
    let buttonText: String?
}

final class VentilatorStatusView: UIView {
    
    @IBOutlet weak var statusSignalView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet var contentView: VentilatorStatusView!
    var buttonClosure: (() -> Void)?
    
    @IBAction func actionButtonTapped(_ sender: Any) {
        buttonClosure?()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setupStatus(statusModel: StatusViewModel){
        DispatchQueue.main.async { [weak self] in
            self?.statusSignalView.backgroundColor = statusModel.color
            self?.statusLabel.text  = statusModel.description
            self?.actionButton.setTitle(statusModel.buttonText, for: .normal)
            self?.actionButton.isHidden = statusModel.buttonText == nil
        }
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("VentilatorStatusView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        statusSignalView.layer.cornerRadius = statusSignalView.frame.width/2
    }
}
