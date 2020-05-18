//
//  EditPatientProfileViewController.swift
//  Ventivader
//
//  Created by Al on 09/05/20.
//  Copyright © 2020 . All rights reserved.
//

import UIKit
import HealthKit

final class EditPatientProfileViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fieldsStackView: UIStackView!
    @IBOutlet weak var editProfileImageButton: UIButton!
    @IBOutlet weak var saveProfileButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    
    let viewModel = EditPatientProfileViewModel()
    private let viewHelper = ViewHelper()
    private lazy var imagePicker = ImagePicker(presentationController: self, delegate: self)
    
    private var nameFieldView: ProfileFieldView!
    private var birthdateFieldView: ProfileFieldView!
    private var bloodTypeFieldView: ProfileFieldView!
    private var heightFieldView: ProfileFieldView!
    private var weightFieldView: ProfileFieldView!
    private var emergencyNameFieldView: ProfileFieldView!
    private var emergencyPhoneFieldView: ProfileFieldView!
    private var newProfileImage:UIImage?
    
    // MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        setupKeyboardDismiss()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver( self, selector: #selector(keyboardWillShow(notification:)), name:  UIResponder.keyboardWillChangeFrameNotification, object: nil )
        setupKeyboardDismiss()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    // MARK: IBActions

    @IBAction func editProfileImageButtonTapped(_ sender: UIButton) {
        imagePicker.present(from: sender)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let bloodType =  HKBloodType.createFrom(string: bloodTypeFieldView.stringValue) else { return }
        
        viewModel.savePatientInfo(photo: newProfileImage ?? viewModel.patientProfileImage,
                                  name: nameFieldView.stringValue,
                                  birthDate: birthdateFieldView.stringValue,
                                  height: heightFieldView.stringValue,
                                  weight: weightFieldView.stringValue,
                                  bloodType: bloodType,
                                  emergencyContactName: emergencyNameFieldView.stringValue,
                                  emergencyContactPhone: emergencyPhoneFieldView.stringValue)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Private functions

    private func setupUI() {
        view.backgroundColor = ColorPallete.backgroundColor
        
        setupFields()
        setupProfileImage()
        setupButtons()
    }
    
    private func setupFields() {
        nameFieldView = ProfileFieldView.instanceFromNib()
        birthdateFieldView = ProfileFieldView.instanceFromNib()
        bloodTypeFieldView = ProfileFieldView.instanceFromNib()
        heightFieldView = ProfileFieldView.instanceFromNib()
        weightFieldView = ProfileFieldView.instanceFromNib()
        emergencyNameFieldView = ProfileFieldView.instanceFromNib()
        emergencyPhoneFieldView = ProfileFieldView.instanceFromNib()
        
        nameFieldView?.populateProfileFieldView(title: NSLocalizedString("Name", comment: ""),
                                                initialValue: viewModel.patientName)
        birthdateFieldView?.populateProfileFieldView(title: NSLocalizedString("BirthDate", comment: ""),
                                                     initialValue: viewModel.patientBirthdate,
                                                     type: .pastDate)
        bloodTypeFieldView?.populateProfileFieldView(title: NSLocalizedString("Blood Type", comment: ""),
                                                     initialValue: viewModel.patientBloodType,
                                                     options: HKBloodType.allValues.map { $0.readable })
        
        heightFieldView?.populateProfileFieldView(title: NSLocalizedString("Height", comment: ""),
                                                  initialValue: viewModel.patientHeight,
                                                  units: NSLocalizedString("cm", comment: ""),
                                                  type: .numeric)
        weightFieldView?.populateProfileFieldView(title: NSLocalizedString("Weight", comment: ""),
                                                  initialValue: viewModel.patientWeight,
                                                  units: NSLocalizedString("pounds", comment: ""),
                                                  type: .numeric)
        
        emergencyNameFieldView?.populateProfileFieldView(title: NSLocalizedString("Emergency Contact Name", comment: ""),
                                                         initialValue: viewModel.emergencyContactName)
        emergencyPhoneFieldView?.populateProfileFieldView(title: NSLocalizedString("Emergency Contact Phone", comment: ""),
                                                          initialValue: viewModel.emergencyContactPhone,
                                                          type: .numeric)
        
        fieldsStackView.addArrangedSubview(nameFieldView)
        fieldsStackView.addArrangedSubview(birthdateFieldView)
        fieldsStackView.addArrangedSubview(bloodTypeFieldView)
        fieldsStackView.addArrangedSubview(heightFieldView)
        fieldsStackView.addArrangedSubview(weightFieldView)
        fieldsStackView.addArrangedSubview(emergencyNameFieldView)
        fieldsStackView.addArrangedSubview(emergencyPhoneFieldView)
    }
    
    private func setupProfileImage() {
        profileImage.image = viewModel.patientProfileImage
        
        viewHelper.roundProfile(image: profileImage)
    }
    
    private func setupButtons() {
        viewHelper.adjustAsVentivader(button: saveProfileButton)
        viewHelper.adjustAsVentivader(button: cancelButton)
        viewHelper.adjustAsVentivader(button: editProfileImageButton)
    }
    
    private func setupKeyboardDismiss() {
        let tap = UITapGestureRecognizer(target: self,
                                      action: #selector(self.happen))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func happen() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow( notification: Notification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.headerViewHeightConstraint?.constant = 0.0
            } else {
                if let expectedHeightMultiplier = self.headerViewHeightConstraint?.multiplier {
                    self.headerViewHeightConstraint?.constant = -(view.bounds.height * expectedHeightMultiplier) + 2
                }
            }
            
            UIView.animate(withDuration: duration,
                                       delay: TimeInterval(0),
                                       options: animationCurve,
                                       animations: { self.view.layoutIfNeeded() },
                                       completion: nil)
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension EditPatientProfileViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        newProfileImage = image
        DispatchQueue.main.async { [weak self] in
            self?.profileImage.image = image
        }
    }
}
