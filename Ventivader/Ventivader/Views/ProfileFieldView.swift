//
//  ProfileFieldView.swift
//  Ventivader
//
//  Created by Al on 09/05/20.
//  Copyright © 2020 calculator. All rights reserved.
//

import UIKit

enum ProfileFieldViewType {
    case string, numeric, pastDate
}

final class ProfileFieldView: UIView {
    
    @IBOutlet weak var fieldTitleLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var unitsLabel: UILabel!
    
    var pickerViewOptions:[String]?
    
    class func instanceFromNib() -> ProfileFieldView {
        return UINib(nibName: "ProfileFieldView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! ProfileFieldView
    }
    
    var stringValue: String {
        return valueTextField.text ?? ""
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func populateProfileFieldView(title: String,
                                  initialValue: String,
                                  units: String? = nil,
                                  type: ProfileFieldViewType = .string,
                                  options: [String]? = nil) {
        DispatchQueue.main.async { [weak self] in
            self?.commonInit()
            
            guard let strongSelf = self else { return }
            strongSelf.unitsLabel.text = units
            strongSelf.unitsLabel.isHidden = units == nil
            strongSelf.fieldTitleLabel.text = title
            strongSelf.valueTextField.text = initialValue
            
            if type == .pastDate {
                strongSelf.valueTextField.setInputViewDatePicker(target: strongSelf,
                                                                 selector: #selector(strongSelf.dateSelected(sender:datePicker:)))
            } else if type == .numeric {
                strongSelf.valueTextField.keyboardType = .numberPad
            } else if let options = options, options.count > 0 {
                self?.pickerViewOptions = options
                let pickerView = UIPickerView()
                pickerView.delegate = self
                strongSelf.valueTextField.inputView = pickerView
            }
        }
    }
    
    private func commonInit() {
        backgroundColor = ColorPallete.secondaryBackgroundColor
        
        fieldTitleLabel.textColor = ColorPallete.highlightColor
        fieldTitleLabel.updateFont(name: VentivaderFonts.titleFont)
        
        unitsLabel.textColor = ColorPallete.highlightColor
        unitsLabel.updateFont(name: VentivaderFonts.bodyFont)
        setupTextField()
    }
    
    func setupTextField() {
        valueTextField.delegate = self
    }
    
    @objc func dateSelected(sender: Any, datePicker: UIDatePicker) {
        print(datePicker)
        if let datePicker = valueTextField.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            self.valueTextField.text = dateformatter.string(from: datePicker.date)
        }
        self.valueTextField.resignFirstResponder()
    }
}

extension ProfileFieldView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewOptions?[row] ?? ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.valueTextField.text = self?.pickerViewOptions?[row]
        }
    }
}

extension ProfileFieldView: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewOptions?.count ?? 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}


extension ProfileFieldView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
