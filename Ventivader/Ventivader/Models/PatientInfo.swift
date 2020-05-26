//
//  PatientInfo.swift
//  Ventivader
//
//  Created by Al on 08/05/20.
//

import Foundation
import HealthKit
import UIKit

struct PatientInfo {
    var photo: UIImage
    var name: String
    
    var birthDate: Date
    var height: Measurement<UnitLength>
    var weight: Measurement<UnitMass>
    var bloodType: HKBloodType
    
    var emergencyContactName: String
    var emergencyContactPhone: String
}
