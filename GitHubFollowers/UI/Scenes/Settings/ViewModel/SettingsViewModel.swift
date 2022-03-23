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
        sections = [.init(title: strings.settingsViewSectionAppearance(),
                          options: [
                            .switchCell(model: .init(title: strings.settingsViewOptionDarkMode(),
                                                     isActive: UserInterfaceStyleManager.shared.currentStyle == .dark,
                                                     icon: UIImage(systemName: "moon.fill"),
                                                     iconBackgroundColor: .systemPink,
                                                     handler: {
                                                         let current = UserInterfaceStyleManager.shared.currentStyle
                                                     
                                                         let darkModeOn = current == .dark ? false : true
                                                         
                                                         UserDefaults.standard.set(darkModeOn, forKey: UserInterfaceStyleManager.userInterfaceStyleDarkModeOn)
                                                         UserInterfaceStyleManager.shared.updateUserInterfaceStyle(darkModeOn)
                                                     }))
                          ]),
                    .init(title: strings.settingsViewSectionLanguage(), options: [
                        .selectionCell(model: .init(identifier: "pt-BR",
                                                    title: strings.settingsViewOptionPtBR(),
                                                    isActive: true,
                                                    handler: {
                                                        print("Português - Brasil")
                                                    })),
                        .selectionCell(model: .init(identifier: "en",
                                                    title: strings.settingsViewOptionEnglish(),
                                                    isActive: false,
                                                    handler: {
                                                        print("Inglês")
                                                    }))
                    ])
        ]
    }
}
