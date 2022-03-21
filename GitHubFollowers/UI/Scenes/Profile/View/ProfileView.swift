//
//  ProfileView.swift
//  GitHubFollowers
//
//  Created by joaovitor on 18/03/22.
//

import UIKit
import SnapKit

protocol ProfileViewDescriptorProtocol {
    var username: String { get set }
    var name: String? { get set }
    var avatarURL: String { get set }
    var bio: String? { get set }
    var company: String? { get set }
    var location: String? { get set }
    var email: String? { get set }
    var blog: String? { get set }
    var twitter: String? { get set }
    var repositories: String { get set }
    var followers: String { get set }
    var following: String { get set }
}

struct ProfileViewDescriptor: ProfileViewDescriptorProtocol {
    var username: String
    var name: String?
    var avatarURL: String
    var bio: String?
    var company: String?
    var location: String?
    var email: String?
    var blog: String?
    var twitter: String?
    var repositories: String
    var followers: String
    var following: String
}

class ProfileView: UIView {
    let repositories = GFStats()
    let followers = GFStats()
    let following = GFStats()
    let details = GFDetails()
   
    
    let avatarImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.layer.cornerRadius = 50
        img.layer.masksToBounds = true
        img.layer.borderWidth = 4
        img.layer.borderColor = colors.title()?.cgColor
        return img
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 18, weight: .semibold)
        lbl.textAlignment = .center
        lbl.numberOfLines = 1
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = colors.title()
        return lbl
    }()
    
    let usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        lbl.textAlignment = .center
        lbl.numberOfLines = 1
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = colors.placholder()
        return lbl
    }()
    
    let bioLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        lbl.textColor = colors.title()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = colors.background()
    }
    
    func setup(descriptor: ProfileViewDescriptor) {
        nameLabel.text = descriptor.name
        bioLabel.text = descriptor.bio
        
        usernameLabel.text = descriptor.username
        avatarImageView.loadImage(from: descriptor.avatarURL)
        
        repositories.setup(quantity: descriptor.repositories, label: "repositories")
        followers.setup(quantity: descriptor.followers, label: "followers")
        following.setup(quantity: descriptor.following, label: "following")
        
        details.setup(company: descriptor.company,
                           location: descriptor.location,
                           email: descriptor.email,
                           blog: descriptor.blog,
                           twitter: descriptor.twitter)
    }
}

extension ProfileView: ViewCode {
    func buildViewHierarchy() {
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(usernameLabel)
        addSubview(bioLabel)
        addSubview(details)
        addSubview(hStack)
        hStack.addArrangedSubview(repositories)
        hStack.addArrangedSubview(followers)
        hStack.addArrangedSubview(following)
    }
    
    func setupConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
        bioLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
        details.snp.makeConstraints { make in
            make.top.equalTo(bioLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(120)
        }
        hStack.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(52)
            make.leading.equalTo(safeAreaLayoutGuide).offset(52)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
    }
}
