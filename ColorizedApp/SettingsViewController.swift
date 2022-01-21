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

    @IBOutlet private var redTF: UITextField!
    @IBOutlet private var greenTF: UITextField!
    @IBOutlet private var blueTF: UITextField!

    //MARK: - Public Properties
    var initialColor: UIColor!
    var delegate: SettingsViewControllerDelegate!

    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupColorView()

        setColor()
    }

    //MARK: - IB Actions
    @IBAction private func sliderAction(_ sender: UISlider) {
        changeValues(from: sender)

        changeColor()
    }

    @IBAction func doneButtonPressed() {
        guard let color = colorView.layer.backgroundColor else { return }

        delegate.setNewViewColor(to: color)

        dismiss(animated: true)
    }

    //MARK: - Private Methods
    private func setupColorView() {
        colorView.layer.cornerRadius = 15
        colorView.layer.borderWidth = 5
        colorView.layer.borderColor = UIColor.black.cgColor
    }

    private func changeValues(from sender: UISlider) {
        let label: UILabel
        let textField: UITextField

        switch sender {
        case redSlider:
            label = redSliderValue
            textField = redTF
        case greenSlider:
            label = greenSliderValue
            textField = greenTF
        default:
            label = blueSliderValue
            textField = blueTF
        }

        label.text = String(format: "%.2f", sender.value)
        textField.text = String(format: "%.2f", sender.value)
    }

    private func changeColor() {
        let red = CGFloat(redSlider.value)
        let green = CGFloat(greenSlider.value)
        let blue = CGFloat(blueSlider.value)

        colorView.layer.backgroundColor = CGColor(red: red, green: green, blue: blue, alpha: 1)
    }

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

        changeValues(from: redSlider)
        changeValues(from: greenSlider)
        changeValues(from: blueSlider)
    }
}
