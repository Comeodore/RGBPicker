//
//  ViewController.swift
//  RGBPicker
//
//  Created by Vladimir Maksymchuk on 30.01.2025.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pickedColorView: UIView!
    
    @IBOutlet weak var redColorLabel: UILabel!
    @IBOutlet weak var redPickedValueLabel: UILabel!
    @IBOutlet weak var redSlider: UISlider!
    
    @IBOutlet weak var greenColorLabel: UILabel!
    @IBOutlet weak var greenPickedValueLabel: UILabel!
    @IBOutlet weak var greenSlider: UISlider!
    
    @IBOutlet weak var blueColorLabel: UILabel!
    @IBOutlet weak var bluePickedValueLabel: UILabel!
    @IBOutlet weak var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRedStack()
        setupGreenStack()
        setupBlueStack()
        pickedColorView.layer.cornerRadius = 10
        setPickedColorView()
    }
    
    @IBAction func redSliderAction() {
        redPickedValueLabel.text = String(format: "%.2f", redSlider.value)
        setPickedColorView()
    }
    
    @IBAction func greenSliderAction() {
        greenPickedValueLabel.text = String(format: "%.2f", greenSlider.value)
        setPickedColorView()
    }
    
    @IBAction func blueSliderAction() {
        bluePickedValueLabel.text = String(format: "%.2f", blueSlider.value)
        setPickedColorView()
    }
    
    private func setPickedColorView() {
        pickedColorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1.0
        )
    }
}


// MARK: - Setup slider stacks on UI

extension ViewController {
    private func setupRedStack() {
        redColorLabel.text = "Red:"
        
        redSlider.minimumValue = 0
        redSlider.maximumValue = 1
        redSlider.minimumTrackTintColor = .red
        redSlider.setValue(0.36, animated: false)
        
        redPickedValueLabel.text = String(format: "%.2f", redSlider.value)
    }
    
    private func setupGreenStack() {
        greenColorLabel.text = "Green:"
        
        greenSlider.minimumValue = 0
        greenSlider.maximumValue = 1
        greenSlider.minimumTrackTintColor = .green
        greenSlider.setValue(0.3, animated: false)
        
        greenPickedValueLabel.text = String(format: "%.2f", greenSlider.value)
    }
    
    private func setupBlueStack() {
        blueColorLabel.text = "Blue:"
        
        blueSlider.minimumValue = 0
        blueSlider.maximumValue = 1
        blueSlider.minimumTrackTintColor = .blue
        blueSlider.setValue(0.6, animated: false)
        
        bluePickedValueLabel.text = String(format: "%.2f", blueSlider.value)
    }
}
