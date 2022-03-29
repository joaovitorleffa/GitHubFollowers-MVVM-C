//
//  FavoriteCell.swift
//  GitHubFollowers
//
//  Created by joaovitor on 28/03/22.
//

import UIKit
import SnapKit

class FavoriteCell: UITableViewCell, Identifier {
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = Colors.title()
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = Colors.background()
        accessoryType = .disclosureIndicator
        
        addSubview(avatarImageView)
        addSubview(nameLabel)
        
        avatarImageView.snp.makeConstraints { make in
            make.size.equalTo(70)
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(24)
            make.trailing.equalToSuperview().inset(16)
            make.top.centerY.equalToSuperview()
        }
    }
    
    func setup(viewModel: FavoriteViewModelProtocol) {
        avatarImageView.loadImage(from: viewModel.avatarURL)
        nameLabel.text = viewModel.name
    }
}
