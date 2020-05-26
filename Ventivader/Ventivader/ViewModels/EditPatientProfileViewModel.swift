//
//  EditPatientProfileViewModel.swift
//  Ventivader
//
//  Created by Al on 10/05/20.
//

import HealthKit
import UIKit

final class EditPatientProfileViewModel {
    private var patientInfoManager: PatientInformationManager
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var dataUpdatedClosure: (() -> Void)?
    
    init(patientInfoManager: PatientInformationManager = PatientInformationManager.shared) {
        self.patientInfoManager = patientInfoManager
    }
    
    var patientProfileImage: UIImage {
        return patientInfoManager.patientInfoModel.photo
    }
    
    var patientName: String {
        return patientInfoManager.patientInfoModel.name
    }
    
    var patientBirthdate: String {
        return formatter.string(from: patientInfoManager.patientInfoModel.birthDate)
    }
    
    var patientHeight: String {
        return "\(patientInfoManager.patientInfoModel.height.value)"
    }
    
    var patientWeight: String {
        return "\(patientInfoManager.patientInfoModel.weight.value)"
    }
    
    var patientBloodType: String {
        return "\(patientInfoManager.patientInfoModel.bloodType.readable)"
    }
    
    var emergencyContactName: String {
        return patientInfoManager.patientInfoModel.emergencyContactName
    }
    
    var emergencyContactPhone: String {
        return patientInfoManager.patientInfoModel.emergencyContactPhone
    }
    
    func savePatientInfo(photo: UIImage,
                         name: String,
                         birthDate: String,
                         height: String,
                         weight: String,
                         bloodType: HKBloodType,
                         emergencyContactName: String,
                         emergencyContactPhone: String) {
        let heightDouble = Double(height) ?? patientInfoManager.patientInfoModel.height.value
        let weightDouble = Double(weight) ?? patientInfoManager.patientInfoModel.weight.value
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let birthDateAsDate = formatter.date(from: birthDate) ?? patientInfoManager.patientInfoModel.birthDate
        
        patientInfoManager.patientInfoModel = PatientInfo(photo: photo,
                                                          name: name,
                                                          birthDate: birthDateAsDate,
                                                          height: Measurement(value: heightDouble, unit: UnitLength.centimeters),
                                                          weight: Measurement(value: weightDouble, unit: UnitMass.pounds),
                                                          bloodType: bloodType,
                                                          emergencyContactName: emergencyContactName,
                                                          emergencyContactPhone: emergencyContactPhone)
        
        dataUpdatedClosure?()
    }
}
