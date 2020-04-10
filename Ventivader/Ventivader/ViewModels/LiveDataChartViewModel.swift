//
//  LiveDataChartViewModel.swift
//  Ventivader
//
//  Created by Al on 10/04/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import Foundation

enum VentilatorChartLiveDataType {
    case pressure, volume, flow
    
    var title: String {
        switch self {
        case .pressure:
            return NSLocalizedString("Pressure", comment: "Chart Label")
        case .volume:
            return NSLocalizedString("Volume", comment: "Chart Label")
        case .flow:
            return NSLocalizedString("Flow", comment: "Chart Label")
        default:
            return ""
        }
    }
}

class LiveDataChartViewModel {
    var chartType: VentilatorChartLiveDataType?
}
