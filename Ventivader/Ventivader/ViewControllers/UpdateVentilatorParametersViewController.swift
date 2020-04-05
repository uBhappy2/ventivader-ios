//
//  UpdateVentilatorParametersViewController.swift
//  Ventivader
//
//  Created by Al on 04/04/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import UIKit

class UpdateVentilatorParametersViewController: UIViewController, BaseVC {

    @IBOutlet weak var formStackView: UIStackView!
    
    private let viewModel = UpdateVentilatorParametersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for parameter  in viewModel.ventilatorParameters {
            let fieldView = ParameterFieldView.instanceFromNib()
            fieldView.setUp(ventilatorParameter: parameter)
            formStackView.addArrangedSubview(fieldView)
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        viewModel.resetParameterValues()
        reloadParamsToViews()
    }
    
    func reloadParamsToViews() {
        for (index, subview) in formStackView.subviews.enumerated() {
            guard let fieldParamView = subview as? ParameterFieldView else { continue }
            
            let ventilatoParameterModel = viewModel.ventilatorParameters[index]
            fieldParamView.setUp(ventilatorParameter: ventilatoParameterModel)
        }
    }
    
    @IBAction func loadVentilatorParameters(_ sender: Any) {
        showSpinner(onView: view)
        
        for (index, subview) in formStackView.subviews.enumerated() {
            guard let fieldParamView = subview as? ParameterFieldView else { continue }
            viewModel.updateParameter(value: fieldParamView.parameterValueTextField?.text,
                                      forIndex: index)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let view = self?.view else { return }
            self?.removeSpinner(fromView: view)
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
