//
//  PatientProfileViewController.swift
//  Ventivader
//
//  Created by Al on 08/05/20.
//

import UIKit

class PatientProfileViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var heightTileView: PatientInfoView!
    @IBOutlet weak var weightTileView: PatientInfoView!
    @IBOutlet weak var bloodTypeTileView: PatientInfoView!
    @IBOutlet weak var ageTileView: PatientInfoView!
    
    @IBOutlet weak var emergencyContactTitleLabel: UILabel!
    @IBOutlet weak var emergencyContactNameLabel: UILabel!
    @IBOutlet weak var emergencyContactPhoneLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    private let viewModel = PatientProfileViewModel()
    private let viewHelper = ViewHelper()
    
    // MARK: VC Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        reloadPatientInfo()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? EditPatientProfileViewController {
            vc.viewModel.dataUpdatedClosure = { [weak self] in
                DispatchQueue.main.async { [weak self] in
                    self?.reloadPatientInfo()
                }
            }
        }
    }
    // MARK: UI setup
    
    private func setupUI() {
        view.backgroundColor = ColorPallete.backgroundColor
        
        // Edit Button
        editButton.setTitleColor(ColorPallete.highlightColor, for: .normal)
        editButton.titleLabel?.updateFont(name: VentivaderFonts.titleFont)
        
        // Labels
        nameLabel.textColor = ColorPallete.highlightColor
        nameLabel.updateFont(name: VentivaderFonts.titleFont)
        
        
        // Information Tiles
        setupInfoTileViews()
        
        // Emergency Contact
        emergencyContactTitleLabel.textColor = ColorPallete.highlightColor
        emergencyContactTitleLabel.updateFont(name: VentivaderFonts.titleFont)
        
        emergencyContactNameLabel.textColor = ColorPallete.secondaryHighlightColor
        emergencyContactPhoneLabel.textColor = ColorPallete.secondaryHighlightColor
    }
    
    func reloadPatientInfo() {
        // Image
        setupProfileImage()
        
        // Tiles
        setupInfoTileViews()
        
        nameLabel.text = viewModel.patientName
        emergencyContactNameLabel.text = viewModel.emergencyContactName
        emergencyContactPhoneLabel.text = viewModel.emergencyContactPhone
    }
    
    @IBAction func editButtonTap(_ sender: Any) {
        performSegue(withIdentifier: "editPatientProfileFromPatientProfile", sender: self)
    }
    
    private func setupInfoTileViews() {
        heightTileView.setUpWithData(value: viewModel.patientHeight,
                                     description: NSLocalizedString("Height", comment: ""))
        weightTileView.setUpWithData(value: viewModel.patientWeight,
                                     description: NSLocalizedString("Weight", comment: ""))
        bloodTypeTileView.setUpWithData(value: viewModel.patientBloodType,
                                        description: NSLocalizedString("Blood Type", comment: ""))
        ageTileView.setUpWithData(value: viewModel.patientAge,
                                  description: NSLocalizedString("Age", comment: ""))
    }
    
    private func setupProfileImage() {
        profileImage.image = viewModel.patientProfileImage
        
        viewHelper.roundProfile(image: profileImage)
    }
}
