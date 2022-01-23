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
    @IBOutlet private var textFieldsStackView: UIStackView!

    //MARK: - Public Properties
    var initialColor: UIColor!
    var delegate: SettingsViewControllerDelegate!

    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupColorView()
        setupTextFields()
        setColor()
    }

    //MARK: - IB Actions
    @IBAction private func sliderAction(_ sender: UISlider) {
        changeValues(from: sender)

        changeColor()
    }

    @IBAction func doneButtonPressed() {
        guard let color = colorView.backgroundColor else { return }

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
        for textField in textFieldsStackView.arrangedSubviews {
            guard let textField = textField as? UITextField else { return }

            textField.delegate = self
            textField.inputAccessoryView = createToolBar()
            textField.keyboardType = .decimalPad
        }
    }

    private func createToolBar() -> UIToolbar {
        let bar = UIToolbar()
        bar.sizeToFit()

        let leftSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )

        let done = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneEditingButtonPressed)
        )

        bar.items = [leftSpace, done]
        
        return bar
    }

    private func setColor() {
        let ciColor = CIColor(color: initialColor)

        redSlider.value = Float(ciColor.red)
        changeValues(from: redSlider)

        greenSlider.value = Float(ciColor.green)
        changeValues(from: greenSlider)

        blueSlider.value = Float(ciColor.blue)
        changeValues(from: blueSlider)

        changeColor()
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
        colorView.layer.backgroundColor = CGColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = nil
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        view.endEditing(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text,
              let newValue = Float(text),
              0...1 ~= newValue
        else {
            if textField.text != "" { showAlert() }

            setPreviousValue(for: textField)

            return
        }

        let newValueText = String(format: "%.2f", newValue)

        switch textField {
        case redTF:
            redSlider.setValue(newValue, animated: true)
            redSliderValue.text = newValueText
        case greenTF:
            greenSlider.setValue(newValue, animated: true)
            greenSliderValue.text = newValueText
        default:
            blueSlider.setValue(newValue, animated: true)
            blueSliderValue.text = newValueText
        }

        textField.text = newValueText

        changeColor()
    }
    
    private func setPreviousValue(for textField: UITextField) {
        switch textField {
        case redTF:
            textField.text = redSliderValue.text
        case greenTF:
            textField.text = greenSliderValue.text
        default:
            textField.text = blueSliderValue.text
        }
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
