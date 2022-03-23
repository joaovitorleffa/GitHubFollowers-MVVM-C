//
//  SelectionCellViewModel.swift
//  GitHubFollowers
//
//  Created by joaovitor on 23/03/22.
//

import Foundation
import UIKit

protocol SelectionCellViewModelProtocol: AnyObject {
    var title: String { get set }
    var icon: UIImage? { get set }
    var iconBackgroundColor: UIColor? { get set }
    var isActive: Bool { get set }
    var handler: (() -> Void) { get set }
}

class SelectionCellViewModel: SelectionCellViewModelProtocol {
    var title: String
    var icon: UIImage?
    var iconBackgroundColor: UIColor?
    var isActive: Bool
    var handler: (() -> Void)
    
    init(model: SettingsSwitchOption) {
        title = model.title
        icon = model.icon
        iconBackgroundColor = model.iconBackgroundColor
        isActive = model.isActive
        handler = model.handler
    }
}
