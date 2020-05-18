//
//  PatientProfileViewModel.swift
//  Ventivader
//
//  Created by Al on 08/05/20.
//

import HealthKit
import UIKit

final class PatientProfileViewModel {
    private var patientInfoManager: PatientInformationManager
    
    init(patientInfoManager: PatientInformationManager = PatientInformationManager.shared) {
        self.patientInfoManager = patientInfoManager
    }
    
    var patientName: String {
        return patientInfoManager.patientInfoModel.name
    }
    
    var patientProfileImage: UIImage {
        return patientInfoManager.patientInfoModel.photo
    }
    
    var patientAge: String {
        let ageComponents = Calendar.current.dateComponents([Calendar.Component.year],
                                                            from: patientInfoManager.patientInfoModel.birthDate,
                                                            to: Date())
        return "\(ageComponents.year ?? 0)"
    }
    
    var patientHeight: String {
        return "\(patientInfoManager.patientInfoModel.height)"
    }
    
    var patientWeight: String {
        return "\(patientInfoManager.patientInfoModel.weight)"
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
}
