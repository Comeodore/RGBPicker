//
//  MainViewController.swift
//  RGBPicker
//
//  Created by Vladimir Maksymchuk on 14.02.2025.
//

import UIKit

protocol ColorPickerDelegate: AnyObject {
    func setColor(pickedColor: UIColor)
}

class MainViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let pickerVC = segue.destination as! ColorPickerViewController
        pickerVC.delegate = self
        pickerVC.pickedColors = getBackgroundColor()
    }
}

extension MainViewController {
    func getBackgroundColor() -> RGBAColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        view.backgroundColor!.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return RGBAColor(red: Float(red), green: Float(green), blue: Float(blue), alpha: Float(alpha))
    }
}

// MARK: ColorPickerDelegate
extension MainViewController: ColorPickerDelegate {
    func setColor(pickedColor: UIColor) {
        view.backgroundColor = pickedColor
    }
}
