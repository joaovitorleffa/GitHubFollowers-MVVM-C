//
//  Setting.swift
//  GitHubFollowers
//
//  Created by joaovitor on 23/03/22.
//

import Foundation
import UIKit

struct Section {
    let title: String;
    let options: [SettingOptionType]
}

enum SettingOptionType {
    case switchCell(model: SettingsSwitchOption)
    case selectionCell(model: SettingsSelectionOption)
}

struct SettingsSwitchOption {
    let title: String
    var isActive: Bool
    let icon: UIImage?
    let iconBackgroundColor: UIColor?
    let handler: (() -> Void)
}

struct SettingsSelectionOption {
    let identifier: String
    let title: String
    var isActive: Bool
    let handler: (() -> Void)
}
