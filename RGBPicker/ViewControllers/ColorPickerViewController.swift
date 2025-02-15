//
//  ViewController.swift
//  RGBPicker
//
//  Created by Vladimir Maksymchuk on 30.01.2025.
//

import UIKit

enum ColorsIndexes: Int {
    case red = 0
    case green = 1
    case blue = 2
    
    var index: Int {
        self.rawValue
    }
    
    var toString: String {
        switch self {
        case .red: "red"
        case .green: "green"
        case .blue: "blue"
        }
    }
    
    var toColor: UIColor {
        switch self {
        case .red: .red
        case .green: .green
        case .blue: .blue
        }
    }
}

final class ColorPickerViewController: UIViewController {
    
    var pickedColors: RGBAColor!
    
    // MARK: IB Outlets
    @IBOutlet weak var pickedColorView: UIView!
    
    @IBOutlet var colorNameLabels: [UILabel]!
    @IBOutlet var colorValueLabels: [UILabel]!
    @IBOutlet var colorSliders: [UISlider]!
    @IBOutlet var colorValueTextFields: [UITextField]!
    
    weak var delegate: ColorPickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlidersStacks()
        pickedColorView.layer.cornerRadius = 10
        setPickedColorView()
        
        colorValueTextFields.forEach { customKeyboard(to: $0) }
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    // MARK: IBActions
    @IBAction func sliderValueChangedAction(_ sender: UISlider) {
        guard let colorIndex = ColorsIndexes(rawValue: sender.tag) else { return }
        
        colorValueLabels[colorIndex.index].text = sender.value.formattedValue
        colorValueTextFields[colorIndex.index].text = sender.value.formattedValue
        setPickedColorView()
    }
    
    @IBAction func startEditingFieldsAction(_ sender: UITextField) {
        sender.text = ""
    }
    
    @IBAction func changedTextFieldAction(_ sender: UITextField) {
        guard let colorIndex = ColorsIndexes(rawValue: sender.tag) else { return }
        
        if let value = Float(sender.text!.replacingOccurrences(of: ",", with: ".")), (0...1).contains(value) {
            sender.text = value.formattedValue // For cases when keyboard decimal splitter is ',' and value > 4
            colorSliders[colorIndex.index].setValue(Float(value.formattedValue)!, animated: true)
            colorValueLabels[colorIndex.index].text = value.formattedValue
            setPickedColorView()
        } else {
            showErrorAlert()
            sender.text = colorValueLabels[colorIndex.index].text
        }
    }
    
    @IBAction func doneButtonAction() {
        delegate?.setColor(pickedColor: pickedColorView.backgroundColor!)
        dismiss(animated: true)
    }
}


// MARK: - Setup slider stacks on UI
extension ColorPickerViewController {
    private func setupSlidersStacks() {
        let sliders: [UISlider: (colorName: String, colorLabel: UILabel, pickedValueLabel: UILabel, sliderColor: UIColor, defaultValue: Float, textField: UITextField)] = [
            colorSliders[ColorsIndexes.red.index]: (ColorsIndexes.red.toString, colorNameLabels[ColorsIndexes.red.index], colorValueLabels[ColorsIndexes.red.index], ColorsIndexes.red.toColor, pickedColors.red, colorValueTextFields[ColorsIndexes.red.index]),
            colorSliders[ColorsIndexes.green.index]: (ColorsIndexes.green.toString, colorNameLabels[ColorsIndexes.green.index], colorValueLabels[ColorsIndexes.green.index], ColorsIndexes.green.toColor, pickedColors.green, colorValueTextFields[ColorsIndexes.green.index]),
            colorSliders[ColorsIndexes.blue.index]: (ColorsIndexes.blue.toString, colorNameLabels[ColorsIndexes.blue.index], colorValueLabels[ColorsIndexes.blue.index], ColorsIndexes.blue.toColor, pickedColors.blue, colorValueTextFields[ColorsIndexes.blue.index])
        ]
        
        sliders.forEach { (slider, sliderData) in
            setupStack(
                slider: slider,
                colorLabel: sliderData.colorLabel,
                pickedValueLabel: sliderData.pickedValueLabel,
                colorName: sliderData.colorName,
                sliderColor: sliderData.sliderColor,
                defaultValue: sliderData.defaultValue,
                textField: sliderData.textField
            )
        }
    }
    
    private func setupStack(slider: UISlider, colorLabel: UILabel, pickedValueLabel: UILabel, colorName: String, sliderColor: UIColor, defaultValue: Float, textField: UITextField) {
        colorLabel.text = "\(colorName.capitalized):"
        
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.minimumTrackTintColor = sliderColor
        slider.setValue(defaultValue, animated: false)
        
        textField.text = defaultValue.formattedValue
        pickedValueLabel.text = defaultValue.formattedValue
    }
}

// MARK: Keyboard custom
extension ColorPickerViewController {
    func customKeyboard(to textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        textField.inputAccessoryView = toolbar
        textField.keyboardType = .decimalPad
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: Other helpers funcs
extension ColorPickerViewController {
    private func setPickedColorView() {
        pickedColorView.backgroundColor = RGBAColor(
            red:   colorSliders[ColorsIndexes.red.index].value,
            green: colorSliders[ColorsIndexes.green.index].value,
            blue:  colorSliders[ColorsIndexes.blue.index].value,
            alpha: 1
        ).uiColor
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Wrong format", message: "Value can be between 0.00 and 1.00, try again", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}


// MARK: Formatted property for round value to 2 symbols after dot
extension Float {
    var formattedValue: String {
        String(format: "%.2f", self)
    }
}

extension String {
    var formattedValue: String {
        String(format: "%.2f", self)
    }
}
