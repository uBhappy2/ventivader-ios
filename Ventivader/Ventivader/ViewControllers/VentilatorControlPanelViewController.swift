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
    @IBOutlet weak var controlPanelParameterHeightContraint: NSLayoutConstraint!

    private let viewModel = VentilatorControlPanelViewModel()
    private var ventialorParametersCollectionView: UICollectionView?

    private var parameterCellSize: CGSize {
        let columns = traitCollection.horizontalSizeClass == .regular ? 3 : 3
        let rows = traitCollection.horizontalSizeClass == .regular ? 3 : 3
        let cellWidth = (UIScreen.main.bounds.width - 20) / CGFloat(columns)
        let viewHeight = UIScreen.main.bounds.height * controlPanelParameterHeightContraint.multiplier
        let cellHeight = (viewHeight - 20) / CGFloat(rows)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    // MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleView()
        setupPlots()
        setupStatusViews()
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
        
        setupParameters()
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
        titleView.subviews.forEach { ($0 as? UILabel)?.textColor = ColorPallete.highlightColor }
    }
    
    private func setupParameters() {
        let flowLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
            layout.itemSize = parameterCellSize
            return layout
        }()
        
        ventialorParametersCollectionView = UICollectionView(frame: view.frame,
                                                             collectionViewLayout: flowLayout)
        ventialorParametersCollectionView?.dataSource = self
        ventialorParametersCollectionView?.register(UICollectionViewCell.self,
                                                    forCellWithReuseIdentifier: "MyCell")
        ventialorParametersCollectionView?.backgroundColor = ColorPallete.backgroundColor
        if let collectionView = ventialorParametersCollectionView {
            controlPanelStackView.addArrangedSubview(collectionView)
        }
    }
}

extension VentilatorControlPanelViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.ventilatorParameters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        
        let ventilatorParameter = viewModel.ventilatorParameters[indexPath.row]
        let ventilatorParameterView = VentilatorParameterTileView.instanceFromNib()
        ventilatorParameterView.setUp(ventilatorParameter: ventilatorParameter)
        myCell.subviews.forEach { $0.removeFromSuperview() }
        myCell.addSubview(ventilatorParameterView)
        ventilatorParameterView.bindFrameToSuperviewBounds()
        
        return myCell
    }
}
