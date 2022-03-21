//
//  GFStats.swift
//  GitHubFollowers
//
//  Created by joaovitor on 21/03/22.
//

import UIKit
import SnapKit

class GFStats: UIView {
    let quantity: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 28, weight: .bold)
        lbl.textAlignment = .center
        lbl.numberOfLines = 1
        lbl.textColor = colors.title()
        return lbl
    }()
    
    let label: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        lbl.textAlignment = .center
        lbl.numberOfLines = 1
        lbl.textColor = colors.placholder()
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(quantity: String, label: String) {
        self.init(frame: .zero)
        setup(quantity: quantity, label: label)
    }
    
    private func configure() {
        addSubview(quantity)
        addSubview(label)
        quantity.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.top.equalTo(quantity.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
    }

    func setup(quantity: String, label: String) {
        self.quantity.text = quantity
        self.label.text = label
    }
}
