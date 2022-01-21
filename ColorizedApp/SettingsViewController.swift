//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Alexander on 05.01.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    //MARK: - IB Outlets
    @IBOutlet private var colorView: UIView!

    @IBOutlet private var redSlider: UISlider!
    @IBOutlet private var greenSlider: UISlider!
    @IBOutlet private var blueSlider: UISlider!

    @IBOutlet private var redSliderValue: UILabel!
    @IBOutlet private var greenSliderValue: UILabel!
    @IBOutlet private var blueSliderValue: UILabel!
    
    //MARK: - Public Properties
    var initialColor: UIColor!
    var delegate: SettingsViewControllerDelegate!

    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        colorView.layer.cornerRadius = 15
        colorView.layer.borderWidth = 5
        colorView.layer.borderColor = UIColor.black.cgColor

        setColor()
    }

    //MARK: - IB Actions
    @IBAction private func redSliderAction(_ sender: UISlider) {
        changeValue(of: redSliderValue, from: sender)
        changeColor()
    }

    @IBAction private func greenSliderAction(_ sender: UISlider) {
        changeValue(of: greenSliderValue, from: sender)
        changeColor()
    }

    @IBAction private func blueSliderAction(_ sender: UISlider) {
        changeValue(of: blueSliderValue, from: sender)
        changeColor()
    }

    @IBAction func doneButtonPressed() {
        guard let color = colorView.layer.backgroundColor else { return }
        delegate.setNewViewColor(to: color)
        dismiss(animated: true)
    }

    //MARK: - Private Methods
    private func setColor() {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        initialColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)

        changeColor()
        changeValue(of: redSliderValue, from: redSlider)
        changeValue(of: greenSliderValue, from: greenSlider)
        changeValue(of: blueSliderValue, from: blueSlider)
    }

    private func changeValue(of value: UILabel, from sender: UISlider) {
        value.text = String(format: "%.2f", sender.value)
    }

    private func changeColor() {
        let red = CGFloat(redSlider.value)
        let green = CGFloat(greenSlider.value)
        let blue = CGFloat(blueSlider.value)

        colorView.layer.backgroundColor = CGColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
