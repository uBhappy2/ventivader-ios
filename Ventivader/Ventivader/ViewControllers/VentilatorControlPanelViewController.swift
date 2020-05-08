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
    private let errorProvider = ErrorScreenProvider()
    
    private var liveDataChartVCs: [LiveDataChartViewController] {
        return children.compactMap { $0 as? LiveDataChartViewController }
    }

    // MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleView()
        setupPlots()
        setupStatusViews()
        setupParametersControlPanel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        let overlay = LoadingOverlay()
        overlay.showOverlay(inView: view)
        
        viewModel.connectBLE(bleOff: { [weak self] in
            self?.showBLEDisabledErrorScreen()
        },bleUnauthorizedClosure: { [weak self] in
            self?.showBLEUnauthorizedScreen()
        }, deviceFound: {
            overlay.removeLoadingOverlayView()
        }, deviceNotFound: {  [weak self] in
            self?.showBLENotFound()
        }, valueUpdatedClosure: { [weak self] receivedData  in
            if let json = try? JSONSerialization.jsonObject(with: receivedData, options: []),
               let jsonDictionaty = json as? [String: Double] {
                self?.updateCharts(withJson: jsonDictionaty)
            }
        })
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
        liveDataChartVCs.forEach { $0.stopDataFlow() }
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
            label?.updateFont(name: VentivaderFonts.titleFont)
        }
    }
    
    private func setupParametersControlPanel() {
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
    
    private func showBLEDisabledErrorScreen() {
        errorProvider.showError(inView: view,
                               title: NSLocalizedString("Turn On Bluetooth", comment: "Error screen title"),
                               body: NSLocalizedString("You need to turn on Bluetooth to pair with VentiVader", comment: "Error screen body"),
                               gifName: "turnBleOn")
    }
    
    private func showBLEUnauthorizedScreen() {
        errorProvider.showError(inView: view,
                                title: NSLocalizedString("Bluetooth Permissions Required", comment: "Error screen title"),
                                body: NSLocalizedString("You need to give us permission to use your Bluetooth to pair with Ventivader", comment: "Error screen body"),
                                buttonTitle: NSLocalizedString("Go to Settings", comment: "Buttton in ventilator BLE permission was not granted"),
                                gifName: "blePermissions",
                                actionButtonTapClosure: {
                                    if let appSettingsURL = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettingsURL) {
                                        UIApplication.shared.open(appSettingsURL)
                                    }
        })
    }
    
    private func showBLENotFound() {
        errorProvider.showError(inView: view,
                               title: NSLocalizedString("Ventivader not found", comment: "Error screen title"),
                               body: NSLocalizedString("Make sure the ventilator is on.\n Make sure the ventialor is about 3 fts close.", comment: "Error screen body"),
                               buttonTitle: NSLocalizedString("Try Again", comment: "Buttton in ventilator not found error screen"),
                               gifName: "ventivaderAnimated",
                               actionButtonTapClosure: { [weak self] in
                                self?.errorProvider.dismissCurrentErorView()
        })
    }
    
    private func updateCharts(withJson json: [String:Double]) {
        liveDataChartVCs.forEach { vc in
            if  let key = vc.viewModel.chartType?.rawValue,
                let newValue = json[key] {
                vc.addToChart(newValue: newValue)
            }
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
