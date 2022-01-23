//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Alexander on 21.01.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewViewColor(to color: UIColor)
}

class MainViewController: UIViewController {
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController
        else { return }

        settingsVC.initialColor = view.backgroundColor
        settingsVC.delegate = self
    }
}

//MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setNewViewColor(to color: UIColor) {
        view.backgroundColor = color
    }
}
