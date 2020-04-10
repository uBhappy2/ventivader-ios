//
//  LiveDataChartViewController.swift
//  Ventivader
//
//  Created by Al on 10/04/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import Charts
import UIKit

class LiveDataChartViewController: UIViewController {
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleContainerView: UIView!
    
    let viewModel = LiveDataChartViewModel()
    
    var dataSet: [Double] = []
    var timer: Timer?
    var maxPointsInChart = 50
    
    // MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorPallete.backgroundColor
        lineChartView.backgroundColor = ColorPallete.secondaryHighlightColor
        titleContainerView.backgroundColor = ColorPallete.backgroundColor

        setupLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
            self?.dataSet.append(Double.random(in: 0.0 ..< 20.0))
            self?.updateChart()
        }
        customizeChart()
        setupLabel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
        timer = nil
    }
    
    private func setupLabel() {
        titleLabel.textColor = ColorPallete.highlightColor
        titleLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -2)
        titleLabel.text = viewModel.chartType?.title
    }

    // MARK: - Chart functionality
    private func updateChart() {
        var chartEntry = [ChartDataEntry]()
        let startingIndex = max(dataSet.count - maxPointsInChart, 0)
        for i in 0..<maxPointsInChart {
            let index = startingIndex + i
            guard index < dataSet.count else { break }
            let value = ChartDataEntry(x: Double(i), y: dataSet[index])
            chartEntry.append(value)
        }

        let line = LineChartDataSet(entries: chartEntry, label: "Chart Name")
        line.colors = [ColorPallete.highlightColor]
        line.drawCirclesEnabled = false
        line.drawValuesEnabled = false

        let data = LineChartData()
        data.addDataSet(line)

        lineChartView.data = data
        lineChartView.chartDescription?.enabled = false
    }
    
    private func customizeChart() {
        lineChartView.drawGridBackgroundEnabled = false
        
        lineChartView.legend.enabled = false
        // Axis
        lineChartView.rightAxis.enabled = false
        lineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        
        // Labels Color
        lineChartView.leftAxis.labelTextColor = ColorPallete.highlightColor
        lineChartView.xAxis.labelTextColor = ColorPallete.highlightColor
    }
}
