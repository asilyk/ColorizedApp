//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Alexander on 05.01.2022.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - IB Outlets
    @IBOutlet private var colorView: UIView!

    @IBOutlet private var redSlider: UISlider!
    @IBOutlet private var greenSlider: UISlider!
    @IBOutlet private var blueSlider: UISlider!

    @IBOutlet private var redSliderValue: UILabel!
    @IBOutlet private var greenSliderValue: UILabel!
    @IBOutlet private var blueSliderValue: UILabel!

    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        colorView.layer.cornerRadius = 15
        colorView.layer.borderWidth = 5
        colorView.layer.borderColor = UIColor.black.cgColor

        changeColor()
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

    //MARK: - Private Methods
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
