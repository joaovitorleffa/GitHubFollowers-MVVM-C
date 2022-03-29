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
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let username: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = Colors.title()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        username.text = nil
        avatar.image = nil
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
