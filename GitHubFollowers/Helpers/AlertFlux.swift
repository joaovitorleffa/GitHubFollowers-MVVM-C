//
//  AlertFlux.swift
//  GitHubFollowers
//
//  Created by joaovitor on 29/03/22.
//

import Foundation

protocol AlertFlux: AnyObject {
    func showErrorAlert()
    func showAlert(title: String, message: String, buttonTitle: String)
}
