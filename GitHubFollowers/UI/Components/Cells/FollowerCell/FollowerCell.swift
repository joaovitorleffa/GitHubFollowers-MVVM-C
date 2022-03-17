//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by joaovitor on 17/03/22.
//

import UIKit
import SnapKit

class FollowerCell: UICollectionViewCell, Identifier {
    
    let avatar: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.layer.cornerRadius = 10
        img.layer.masksToBounds = true
        return img
    }()
    
    let username: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14, weight: .semibold)
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        lbl.textColor = .white
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: FollowerViewModelProtocol) {
        username.text = viewModel.username
        avatar.loadImage(from: viewModel.avatarUrl)
    }
}

extension FollowerCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(avatar)
        addSubview(username)
    }
    
    func setupConstraints() {
        avatar.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(avatar.snp.width)
        }
        username.snp.makeConstraints { make in
            make.top.equalTo(avatar.snp.bottom).offset(4)
            make.leading.trailing.equalTo(avatar)
        }
    }
}
