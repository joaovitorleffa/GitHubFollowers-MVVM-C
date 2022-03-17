//
//  GFAlertVM.swift
//  GitHubFollowers
//
//  Created by joaovitor on 17/03/22.
//

import Foundation

protocol GFAlertVMProtocol: AnyObject {
    var title: String { get set }
    var message: String { get set }
    var buttonTitle: String { get set }
    var dismissAction: (() -> Void)? { get set }
}

class GFAlertVM: GFAlertVMProtocol {
    var title: String
    var message: String
    var buttonTitle: String
    var dismissAction: (() -> Void)?
    
    init(model: Alert) {
        title = model.title
        message = model.message
        buttonTitle = model.buttonTitle
        dismissAction = model.dismissAction
    }
}
