//
//  VentilatorControlPanelViewController.swift
//  Ventivader
//
//  Created by Al on 04/04/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import UIKit

class VentilatorControlPanelViewController: UIViewController {
    
    @IBOutlet weak var plotsStackView: UIStackView!
    @IBOutlet weak var controlPanelStackView: UIStackView!
    @IBOutlet weak var ventilatorStatusView: VentilatorStatusView!
    @IBOutlet weak var bleConnectionStatusView: VentilatorStatusView!
    
    private let viewModel = VentilatorControlPanelViewModel()
    private var ventialorParametersCollectionView: UICollectionView?
    
    private var parameterCellSize: CGSize {
        let columns = traitCollection.horizontalSizeClass == .regular ? 4 : 3
        let cellWidth = (UIScreen.main.bounds.width - 20) / CGFloat(columns)
        return CGSize(width: cellWidth, height: cellWidth/2)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlots()
        setupControlPanel()
        setupStatusViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ventialorParametersCollectionView?.reloadData()
    }
    
    private func setupPlots() {
    }
    
    private func setupStatusViews() {
        let ventulatorWorking = StatusViewModel(color: .green,
                                                description: "Ventilator Operating",
                                                buttonText: "Stop")
        let ventulatorStopped = StatusViewModel(color: .red,
                                                       description: "Ventilator Stopped",
                                                       buttonText: "Start")
        
        ventilatorStatusView.buttonClosure = { [weak self] in
            let statusModel = self?.ventilatorStatusView.statusLabel.text  == ventulatorWorking.description ? ventulatorStopped : ventulatorWorking
            
            self?.ventilatorStatusView.setupStatus(statusModel: statusModel)
        }
        
        ventilatorStatusView.setupStatus(statusModel: ventulatorWorking)
        bleConnectionStatusView.setupStatus(statusModel: StatusViewModel(color: .orange, description: "Low Bluetooth Signal", buttonText: nil))
        
        
    }
    
    private func setupControlPanel() {
        setUpConnectionStatus()
        setUpParametersControler()
        //setUpActionButtons()
    }
    
    private func setUpConnectionStatus() {
    }
    
    private func setUpParametersControler(){
        
        let flowLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
            layout.itemSize = parameterCellSize
            return layout
        }()
        
        ventialorParametersCollectionView = UICollectionView(frame: self.view.frame,
                                                                 collectionViewLayout: flowLayout)
        ventialorParametersCollectionView?.dataSource = self
        ventialorParametersCollectionView?.register(UICollectionViewCell.self,
                                                   forCellWithReuseIdentifier: "MyCell")
        ventialorParametersCollectionView?.backgroundColor = UIColor.white
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
