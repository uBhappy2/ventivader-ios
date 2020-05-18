//
//  PatientInformationManager.swift
//  Ventivader
//
//  Created by Al on 10/05/20.
//

import UIKit

final class PatientInformationManager {
    
    static let shared:PatientInformationManager = PatientInformationManager()
    
    private let defaultDate: Date = {
        var dateComponents = DateComponents()
        dateComponents.year = 1980
        dateComponents.month = 7
        dateComponents.day = 11
        
        return Calendar.current.date(from: dateComponents)!
        
    }()
    
    lazy var patientInfoModel: PatientInfo = PatientInfo(photo: UIImage(named: "profile_default")!,
                                                         name: "Patient Name",
                                                         birthDate: defaultDate,
                                                         height: Measurement(value: 170, unit: UnitLength.centimeters),
                                                         weight: Measurement(value: 180, unit: UnitMass.pounds),
                                                         bloodType: .aPositive,
                                                         emergencyContactName: "Family Name",
                                                         emergencyContactPhone: "123-456-789")
}
