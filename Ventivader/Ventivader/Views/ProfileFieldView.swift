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

extension UITextField {
    func setInputViewDatePicker(target: Any, selector: Selector) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .date //2
        self.inputView = datePicker //3

        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9

    }

    @objc func tapCancel() {
        self.resignFirstResponder()
    }

}
