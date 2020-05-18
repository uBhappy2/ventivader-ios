//
//  HKBloodType+Readable.swift
//  Ventivader
//
//  Created by Al on 10/05/20.
//  Copyright © 2020. All rights reserved.
//
import HealthKit

extension HKBloodType {
    static var allValues: [HKBloodType] {
        return [.abNegative, .abPositive, .aNegative, .aPositive, .bNegative, .bPositive , .oNegative, .oPositive]
    }
    
    static func createFrom(string: String) ->  HKBloodType? {
        return allValues.first { $0.readable == string }
    }
    
    var readable: String {
        switch self {
        case .abNegative:
            return "AB-"
        case .abPositive:
            return "AB+"
        case .aNegative:
            return "A-"
        case .aPositive:
            return "A+"
        case .bNegative:
            return "B-"
        case .bPositive:
            return "B+"
        case .oNegative:
            return "O-"
        case .oPositive:
            return "O+"
        default:
            return "Not Set"
        }
    }
    
    
}
