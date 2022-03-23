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
                                                     isActive: false,
                                                     icon: UIImage(systemName: "moon.fill"),
                                                     iconBackgroundColor: .systemPink,
                                                     handler: { print("dark mode cell tapped") }))
                          ]),
                    .init(title: strings.settingsViewSectionLanguage(), options: [
                        .selectionCell(model: .init(title: strings.settingsViewOptionPtBR(),
                                                    isActive: true,
                                                    handler: {
                                                        print("Português - Brasil")
                                                    })),
                        .selectionCell(model: .init(title: strings.settingsViewOptionEnglish(),
                                                    isActive: false,
                                                    handler: {
                                                        print("Inglês")
                                                    }))
                    ])
        ]
    }
}
