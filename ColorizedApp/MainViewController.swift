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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }

        guard let mainViewColor = view.layer.backgroundColor else { return }

        settingsVC.initialColor = UIColor(cgColor: mainViewColor)
        settingsVC.delegate = self
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func setNewViewColor(to color: CGColor) {
        view.layer.backgroundColor = color
    }
}
