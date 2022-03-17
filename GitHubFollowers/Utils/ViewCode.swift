//
//  ViewCode.swift
//  GitHubFollowers
//
//  Created by joaovitor on 16/03/22.
//

import UIKit

protocol ViewCode: UIView {
    func buildViewHierarchy()
    func setupConstraints()
}

extension ViewCode {
    func setupLayout() {
        buildViewHierarchy()
        setupConstraints()
    }
}
