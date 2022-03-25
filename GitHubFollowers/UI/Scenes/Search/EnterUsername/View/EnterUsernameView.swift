//
//  EnterUsernameView.swift
//  GitHubFollowers
//
//  Created by joaovitor on 16/03/22.
//

import UIKit
import SnapKit

class EnterUsernameView: UIView {
    let button = GFButton(title: Strings.enterUsernameViewBtnTitle(), color: Colors.green())
    let textField = GFTextField(placeholder: Strings.enterUsernameViewPlaceholder(),
                               returnKeyType: .send)
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.githubLogo()
        return imageView
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.textColor = Colors.title()
        label.text = Strings.enterUsernameViewTitle()
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = Colors.background()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        endEditing(true)
    }
}

extension EnterUsernameView: ViewCode {
    func buildViewHierarchy() {
        addSubview(title)
        addSubview(imageView)
        addSubview(textField)
        addSubview(button)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(100)
            make.centerX.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(16)
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
    }
}
