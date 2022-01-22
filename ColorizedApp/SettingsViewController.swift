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
    @IBOutlet private var slidersStackView: UIStackView!

    @IBOutlet private var redSliderValue: UILabel!
    @IBOutlet private var greenSliderValue: UILabel!
    @IBOutlet private var blueSliderValue: UILabel!

    @IBOutlet private var redTF: UITextField!
    @IBOutlet private var greenTF: UITextField!
    @IBOutlet private var blueTF: UITextField!
    @IBOutlet private var textFieldsStackView: UIStackView!

    //MARK: - Public Properties
    var initialColor: CGColor!
    var delegate: SettingsViewControllerDelegate!

    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupColorView()
        setColor()
        setupTextFields()
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
}

//MARK: - Private Methods
extension SettingsViewController {
    private func setupColorView() {
        colorView.layer.cornerRadius = 15
        colorView.layer.borderWidth = 5
        colorView.layer.borderColor = UIColor.black.cgColor
    }

    private func setupTextFields() {
        let bar = UIToolbar()
        let leftSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: .none
        )
        let done = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(doneEditingButtonPressed)
        )
        bar.items = [leftSpace, done]
        bar.sizeToFit()

        for textField in textFieldsStackView.arrangedSubviews {
            guard let textField = textField as? UITextField else { return }
            textField.inputAccessoryView = bar
            textField.delegate = self
            textField.keyboardType = .decimalPad
        }
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

        colorView.layer.backgroundColor = CGColor(
            red: red,
            green: green,
            blue: blue,
            alpha: 1
        )
    }

    private func setColor() {
        guard let sliders = slidersStackView.arrangedSubviews as? [UISlider]
        else { return }
        guard let rgbComponents = initialColor.components else { return }

        for (slider, rgbComponent) in zip(sliders, rgbComponents) {
            slider.value = Float(rgbComponent)
            changeValues(from: slider)
        }

        changeColor()
    }
}

extension SettingsViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        view.endEditing(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text,
              let newValue = Float(text),
              0...1 ~= newValue
        else {
            showAlert()
            textField.text = redSliderValue.text
            return
        }

        let newValueText = String(format: "%.2f", newValue)

        switch textField {
        case redTF:
            redSlider.value = newValue
            redSliderValue.text = newValueText
        case greenTF:
            greenSlider.value = newValue
            greenSliderValue.text = newValueText
        default:
            blueSlider.value = newValue
            blueSliderValue.text = newValueText
        }

        textField.text = newValueText

        changeColor()
    }

    @objc private func doneEditingButtonPressed() {
        view.endEditing(true)
    }

    private func showAlert() {
        let alert = UIAlertController(
            title: "Invalid value",
            message: """
            Please, enter the valid value.
            It should be fractional number between 0 and 1.
            """,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
