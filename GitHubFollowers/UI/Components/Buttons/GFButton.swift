//
//  GFButton.swift
//  GitHubFollowers
//
//  Created by joaovitor on 17/03/22.
//

import UIKit

class GFButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, color: UIColor? = nil) {
        self.init(frame: .zero)
        setup(title: title, color: color)
    }
    
    private func configure() {
        layer.cornerRadius = 10
        backgroundColor = .systemPink
        titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    
    func setup(title: String, color: UIColor? = nil) {
        setTitle(title, for: .normal)
        backgroundColor = color ?? .systemPink
    }
}
