//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Alexander on 05.01.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var ColorView: UIView!
    
    @IBOutlet var redSliderValue: UILabel!
    @IBOutlet var greenSliderValue: UILabel!
    @IBOutlet var blueSliderValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ColorView.layer.cornerRadius = 15
        ColorView.layer.borderWidth = 5
        ColorView.layer.borderColor = UIColor.black.cgColor
        changeColor()
    }

    @IBAction func redSliderAction(_ sender: UISlider) {
        changeValue(of: redSliderValue, from: sender)
        changeColor()
    }
    @IBAction func greenSliderAction(_ sender: UISlider) {
        changeValue(of: greenSliderValue, from: sender)
        changeColor()
    }
    @IBAction func blueSliderAction(_ sender: UISlider) {
        changeValue(of: blueSliderValue, from: sender)
        changeColor()
    }
    
    private func changeValue(of value: UILabel, from sender: UISlider) {
        let sliderValue = round(sender.value * 100) / 100
        value.text = String(sliderValue)
    }
    
    private func changeColor() {
        let red = CGFloat(Double(redSliderValue.text!)!)
        let green = CGFloat(Double(greenSliderValue.text!)!)
        let blue = CGFloat(Double(blueSliderValue.text!)!)
        
        let newColor = CGColor(red: red, green: green, blue: blue, alpha: 1)
        ColorView.layer.backgroundColor = newColor
    }
}

