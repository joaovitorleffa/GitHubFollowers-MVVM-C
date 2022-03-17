//
//  FollowersListView.swift
//  GitHubFollowers
//
//  Created by joaovitor on 16/03/22.
//

import UIKit
import SnapKit

class FollowersListView: UIView {
    let lbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        backgroundColor = colors.background()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FollowersListView: ViewCode {
    func buildViewHierarchy() {
        addSubview(lbl)
    }
    
    func setupConstraints() {
        lbl.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
