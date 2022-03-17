//
//  GFAlertView.swift
//  GitHubFollowers
//
//  Created by joaovitor on 17/03/22.
//

import UIKit
import SnapKit

class GFAlertView: UIView {
    let button = GFButton(title: "OK")
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = colors.background()
        view.layer.cornerRadius = 10
        view.layer.borderColor = colors.white()?.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    let contentStack: UIStackView = {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.distribution = .equalSpacing
        return vStack
    }()
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 18, weight: .semibold)
        lbl.textAlignment = .center
        lbl.numberOfLines = 1
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    let messageLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16)
        lbl.textColor = colors.placholder()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
        backgroundColor = .black.withAlphaComponent(0.75)
    }
    
    func setup(title: String,
                   message: String,
                   buttonTitle: String) {
        titleLbl.text = title
        messageLbl.text = message
        button.setup(title: buttonTitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GFAlertView: ViewCode {
    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(contentStack)
        contentStack.addArrangedSubview(titleLbl)
        contentStack.addArrangedSubview(messageLbl)
        contentStack.addArrangedSubview(button)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.width.equalTo(280)
            make.height.equalTo(200)
            make.centerX.centerY.equalToSuperview()
        }
        contentStack.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(18)
            make.centerY.centerX.equalToSuperview()
        }
        button.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
    }
}
