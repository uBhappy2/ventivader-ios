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
    var errorScreenView: ErrorScreenView?
    
    func showError(inView view: UIView!,
                   title: String,
                   body: String,
                   buttonTitle: String? = nil,
                   gifName: String? = nil,
                   actionButtonTapClosure: (() -> Void)? = nil) {
        let errorView = ErrorScreenView.instanceFromNib()
        errorScreenView = errorView
        
        errorScreenView?.populateErrorView(title: title,
                                           body: body,
                                           buttonTitle: buttonTitle,
                                           topButtonClosure: actionButtonTapClosure,
                                           gifName: gifName)
        view.addSubview(errorView)
        setupErrorViewConstraints(containerView: view)
    }
    
    func dismissCurrentErorView() {
        DispatchQueue.main.async { [weak self] in
            self?.errorScreenView?.removeFromSuperview()
        }
    }
    
    private func setupErrorViewConstraints(containerView: UIView) {
        guard let errorScreenView = errorScreenView else { return }
        errorScreenView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            errorScreenView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            errorScreenView.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor),
            errorScreenView.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor),
            errorScreenView.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}
