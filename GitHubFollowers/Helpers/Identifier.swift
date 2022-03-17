//
//  UIView+identifier.swift
//  GitHubFollowers
//
//  Created by joaovitor on 17/03/22.
//

import UIKit

protocol Identifier {
    static var identifier: String { get }
}

extension Identifier where Self: UIView {
    static var identifier: String {
        String(describing: Self.self)
    }
}
