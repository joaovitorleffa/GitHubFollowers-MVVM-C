//
//  Alert.swift
//  GitHubFollowers
//
//  Created by joaovitor on 17/03/22.
//

import Foundation

struct Alert {
    let title: String
    let message: String
    let buttonTitle: String
    var dismissAction: (() -> Void)?
}
