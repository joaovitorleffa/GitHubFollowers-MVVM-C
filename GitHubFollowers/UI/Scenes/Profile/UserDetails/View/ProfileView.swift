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
    let button = GFButton(title: Strings.profileViewBtnTitle(), color: Colors.green())
    let loadingView = GFLoadingView()
    let errorView = GFErrorView()
   
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 4
        
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Colors.title()
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Colors.placholder()
        return label
    }()
    
    let bioLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = Colors.title()
        label.numberOfLines = 0
        return label
    }()
    
    let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.borderColor = Colors.title()?.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = Colors.background()
    }
    
    func setup(_ descriptor: ProfileViewDescriptor) {
        nameLabel.text = descriptor.name
        bioLabel.text = descriptor.bio
        
        usernameLabel.text = descriptor.username
        avatarImageView.loadImage(from: descriptor.avatarURL)
        
        repositories.setup(quantity: descriptor.repositories, label: Strings.profileViewRepositories())
        followers.setup(quantity: descriptor.followers, label: Strings.profileViewFollowers())
        following.setup(quantity: descriptor.following, label: Strings.profileViewFollowing())
        
        details.setup(company: descriptor.company,
                           location: descriptor.location,
                           email: descriptor.email,
                           blog: descriptor.blog,
                           twitter: descriptor.twitter)
    }
    
    func showLoadingView(when show: Bool) {
        loadingView.isHidden = !show
    }
    
    func showErrorView(when show: Bool) {
        errorView.isHidden = !show
    }
}

extension ProfileView: ViewCode {
    func buildViewHierarchy() {
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(usernameLabel)
        addSubview(bioLabel)
        
        addSubview(hStack)
        hStack.addArrangedSubview(repositories)
        hStack.addArrangedSubview(followers)
        hStack.addArrangedSubview(following)
        
        addSubview(details)
        addSubview(button)
        
        addSubview(loadingView)
        addSubview(errorView)
    }
    
    func setupConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.top.equalTo(safeAreaLayoutGuide).offset(32)
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
        
        hStack.snp.makeConstraints { make in
            make.top.equalTo(bioLabel.snp.bottom).offset(24)
            make.leading.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        details.snp.makeConstraints { make in
            make.top.equalTo(hStack.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(110)
            
        }
    
        button.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(24)
            make.leading.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        loadingView.snp.makeConstraints { make in
            make.top.leading.centerX.centerY.equalToSuperview()
        }
        
        errorView.snp.makeConstraints { make in
            make.top.leading.centerX.centerY.equalToSuperview()
        }
    }
}
