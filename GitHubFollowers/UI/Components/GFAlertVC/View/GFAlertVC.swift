//
//  GFAlertVC.swift
//  GitHubFollowers
//
//  Created by joaovitor on 17/03/22.
//

import UIKit
import SnapKit

class GFAlertVC: BaseViewController<GFAlertView> {
    var viewModel: GFAlertVMProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        guard let viewModel = viewModel else { return }

        customView.setup(title: viewModel.title,
                         message: viewModel.message,
                         buttonTitle: viewModel.buttonTitle)
        customView.button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    }

    @objc func dismissVC() {
        dismiss(animated: true) {
            self.viewModel?.dismissAction?()
        }
    }
}


