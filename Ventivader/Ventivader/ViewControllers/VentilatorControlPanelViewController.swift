//
//  VentilatorControlPanelViewController.swift
//  Ventivader
//
//  Created by Al on 04/04/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import UIKit

class VentilatorControlPanelViewController: UIViewController {
    @IBOutlet var plotsStackView: UIStackView!
    @IBOutlet var controlPanelStackView: UIStackView!
    @IBOutlet var ventilatorStatusView: VentilatorStatusView!
    @IBOutlet var bleConnectionStatusView: VentilatorStatusView!
    @IBOutlet var titleView: UIView!

    private let viewModel = VentilatorControlPanelViewModel()
    private var ventialorParametersCollectionView: UICollectionView?

    // MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleView()
        setupPlots()
        setupStatusViews()
        setupParameters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ventialorParametersCollectionView?.reloadData()
        let alertController = UIAlertController(title: "Ventilator",
                                                message:
                                                "BLE connected?",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: .default))
        alertController.addAction(UIAlertAction(title: "No", style: .default, handler: { [weak self] _ in
            DispatchQueue.main.async { [weak self] in
                self?.performSegue(withIdentifier: "connectBLEFromControlPanel", sender: self)
            }
        }))
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  let chartVC = segue.destination as? LiveDataChartViewController {
            switch segue.identifier {
            case "pressureChartSegue":
                chartVC.viewModel.chartType = .pressure
            case "volumeChartSegue":
                chartVC.viewModel.chartType = .volume
            case "flowChartSegue":
                chartVC.viewModel.chartType = .flow
            default:
                break
            }
        }
    }
    
    // MARK: - Setup Views
    
    private func setupPlots() {
        plotsStackView.backgroundColor = ColorPallete.backgroundColor
    }
    
    private func setupStatusViews() {
        let ventulatorWorking = StatusViewModel(color: .green,
                                                description: "Ventilator Operating",
                                                buttonText: "Stop")
        let ventulatorStopped = StatusViewModel(color: .red,
                                                description: "Ventilator Stopped",
                                                buttonText: "Start")
        
        ventilatorStatusView.buttonClosure = { [weak self] in
            let statusModel = self?.ventilatorStatusView.statusLabel.text == ventulatorWorking.description ? ventulatorStopped : ventulatorWorking
            
            self?.ventilatorStatusView.setupStatus(statusModel: statusModel)
        }
        
        ventilatorStatusView.setupStatus(statusModel: ventulatorWorking)
        bleConnectionStatusView.setupStatus(statusModel: StatusViewModel(color: .orange,
                                                                         description: "Low Bluetooth Signal",
                                                                         buttonText: nil))
    }
    
    private func setupTitleView() {
        titleView.backgroundColor = ColorPallete.backgroundColor
        titleView.subviews.forEach {
            let label = $0 as? UILabel
            label?.textColor = ColorPallete.highlightColor
            label?.updateFontOnly(name: FontsVentivader.titleFont)
        }
    }
    
    private func setupParameters() {
        controlPanelStackView.addBackground(color: ColorPallete.backgroundColor)
        let parametersViews: [VentilatorParameterTileView] = viewModel.ventilatorParameters.map { parameter in
            let ventilatorParameterView = VentilatorParameterTileView.instanceFromNib()
            ventilatorParameterView.setUp(ventilatorParameter: parameter)
            return ventilatorParameterView
        }
        
        let topStackView = UIStackView(arrangedSubviews: Array(parametersViews[..<3]))
        let middleStackView = UIStackView(arrangedSubviews: Array(parametersViews[3..<6]))
        let bottomStackView = UIStackView(arrangedSubviews: Array(parametersViews[parametersViews.count-3..<parametersViews.count]))
        
        [topStackView, middleStackView, bottomStackView].forEach { stackView in
            controlPanelStackView.addArrangedSubview(stackView)
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 8.0
            stackView.addBackground(color: ColorPallete.backgroundColor)
        }
    }
}

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
