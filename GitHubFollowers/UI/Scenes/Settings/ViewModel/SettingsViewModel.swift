//
//  SettingsViewModel.swift
//  GitHubFollowers
//
//  Created by joaovitor on 23/03/22.
//

import Foundation
import UIKit

protocol SettingsViewModelProtocol {
    var sections: [Section] { get }
}

class SettingsViewModel: SettingsViewModelProtocol {
    private(set) var sections: [Section] = []
    
    init() {
        configure()
    }
     
    private func configure() {
        let darkModeSwitch = SettingsSwitchOption(title: Strings.settingsViewOptionDarkMode(),
                                                  isActive: UserInterfaceStyleManager.shared.currentStyle == .dark,
                                                  icon: UIImage(systemName: "moon.fill"),
                                                  iconBackgroundColor: .systemPink,
                                                  handler: { isOn in
            UserDefaults.standard.set(isOn, forKey: UserInterfaceStyleManager.userInterfaceStyleDarkModeOn)
            UserInterfaceStyleManager.shared.updateUserInterfaceStyle(isOn)
        })
        
        let appearanceSection = Section(title: Strings.settingsViewSectionAppearance().uppercased(),
                                        options: [.switchCell(model: darkModeSwitch)])
        
        sections = [appearanceSection]
    }
}
