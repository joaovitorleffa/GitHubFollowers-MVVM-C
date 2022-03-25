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
    
    var styleManager: UserInterfaceStyleManagerProtocol
    
    init(styleManager: UserInterfaceStyleManagerProtocol = UserInterfaceStyleManager.shared) {
        self.styleManager = styleManager
        configure()
    }
     
    private func configure() {
        let darkModeSwitch = SettingsSwitchOption(title: Strings.settingsViewOptionDarkMode(),
                                                  isActive: self.styleManager.currentStyle == .dark,
                                                  icon: UIImage(systemName: "moon.fill"),
                                                  iconBackgroundColor: .systemPink,
                                                  handler: { [weak self] isOn in
                                                        guard let self = self else { return }

                                                        UserDefaults.standard.set(isOn, forKey: UserInterfaceStyleManager.userInterfaceStyleDarkModeOn)
                                                        self.styleManager.updateUserInterfaceStyle(isOn)
                                                  })
        
        let appearanceSection = Section(title: Strings.settingsViewSectionAppearance().uppercased(),
                                        options: [.switchCell(model: darkModeSwitch)])
        
        sections = [appearanceSection]
    }
}
