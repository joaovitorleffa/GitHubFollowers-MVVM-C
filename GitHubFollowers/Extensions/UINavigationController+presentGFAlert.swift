//
//  Coordinator+presentGFAlert.swift
//  GitHubFollowers
//
//  Created by joaovitor on 29/03/22.
//

import UIKit

extension UINavigationController {
    func presentGFAlert(title: String, message: String, buttonTitle: String) {
        let vc = GFAlertVC()
        vc.viewModel = GFAlertVM(model: Alert(title: title, message: message, buttonTitle: buttonTitle))
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    
    func presentDefaultError() {
        let vc = GFAlertVC()
        vc.viewModel = GFAlertVM(model: Alert(title: Strings.commonError(),
                                              message: Strings.commonErrorMessage(),
                                              buttonTitle: Strings.commonOk()))
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
}
