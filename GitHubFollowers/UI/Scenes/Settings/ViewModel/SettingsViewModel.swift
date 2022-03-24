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
        let darkModeSwitch = SettingsSwitchOption(title: strings.settingsViewOptionDarkMode(),
                                                  isActive: self.styleManager.currentStyle == .dark,
                                                  icon: UIImage(systemName: "moon.fill"),
                                                  iconBackgroundColor: .systemPink,
                                                  handler: { [weak self] in
                                                        guard let self = self else { return }
                                                        let current = self.styleManager.currentStyle
                                                    
                                                        let darkModeOn = current == .dark ? false : true
                                                        
                                                        UserDefaults.standard.set(darkModeOn, forKey: UserInterfaceStyleManager.userInterfaceStyleDarkModeOn)
                                                        self.styleManager.updateUserInterfaceStyle(darkModeOn)
                                                  })
        
        
        
        let ptBRSelection = SettingsSelectionOption(identifier: "pt-BR",
                                                    title: strings.settingsViewOptionPtBR(),
                                                    isActive: true,
                                                    handler: { print("Português - Brasil") })
        let enSelection = SettingsSelectionOption(identifier: "en",
                                                 title: strings.settingsViewOptionEnglish(),
                                                 isActive: false,
                                                 handler: { print("Inglês") })
        
        let appearanceSection = Section(title: strings.settingsViewSectionAppearance(), options: [.switchCell(model: darkModeSwitch)])
        let languageSection = Section(title: strings.settingsViewSectionLanguage(),
                                      options: [.selectionCell(model: ptBRSelection), .selectionCell(model: enSelection)])
        
        sections = [appearanceSection, languageSection]
    }
}
