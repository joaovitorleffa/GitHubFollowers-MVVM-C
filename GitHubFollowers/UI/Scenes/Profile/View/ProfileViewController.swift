//
//  ProfileViewController.swift
//  GitHubFollowers
//
//  Created by joaovitor on 18/03/22.
//

import UIKit

class ProfileViewController: BaseViewController<ProfileView> {
    var viewModel: ProfileViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinds()
    }
    
    func setupBinds() {
        viewModel?.user.bind(closure: { [weak self] user in
            guard let user = user, let self = self else { return }
            
            DispatchQueue.main.async {
                self.customView.setup(descriptor: ProfileViewDescriptor(username: user.login,
                                                                        name: user.name,
                                                                        avatarURL: user.avatarURL,
                                                                        bio: user.bio,
                                                                        company: user.company,
                                                                        location: user.location,
                                                                        email: user.email,
                                                                        blog: user.blog,
                                                                        twitter: user.twitterUsername,
                                                                        repositories: user.publicRepos,
                                                                        followers: user.followers,
                                                                        following: user.following))
            }
        })
    }
}
