//
//  EnterUserNameViewController.swift
//  GitHubFollowers
//
//  Created by joaovitor on 16/03/22.
//

import UIKit

class EnterUsernameViewController: BaseViewController<EnterUsernameView> {
    var viewModel: EnterUsernameViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.textField.delegate = self
        customView.button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        findFollowers()
    }
    
    func findFollowers() {
        if let text = customView.textField.text {
            viewModel?.findFollowers?(text)
        }
    }
}

extension EnterUsernameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        customView.textField.resignFirstResponder()
        findFollowers()
        return true
    }
}
