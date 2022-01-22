//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Alexander on 21.01.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewViewColor(to color: CGColor)
}

class MainViewController: UIViewController {
    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        view.layer.backgroundColor = CGColor(srgbRed: 1, green: 1, blue: 1, alpha: 1)
    }

    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }

        settingsVC.initialColor = view.layer.backgroundColor
        settingsVC.delegate = self
    }
}

//MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setNewViewColor(to color: CGColor) {
        view.layer.backgroundColor = color
    }
}
