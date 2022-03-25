//
//  GFTextField.swift
//  GitHubFollowers
//
//  Created by joaovitor on 17/03/22.
//

import UIKit

class GFTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeholder: String, returnKeyType: UIReturnKeyType? = .default) {
        self.init(frame: .zero)
        setup(placeholder: placeholder, returnKeyType: returnKeyType!)
    }
    
    private func configure() {
        font = .systemFont(ofSize: 14)
        backgroundColor = Colors.textField()
        layer.borderColor = Colors.stroke()?.cgColor
        borderStyle = .roundedRect
        autocorrectionType = .no
        autocapitalizationType = .none
    }
    
    func setup(placeholder: String, returnKeyType: UIReturnKeyType) {
        self.placeholder = Strings.enterUsernameViewPlaceholder()
        self.returnKeyType = .send
    }
}
