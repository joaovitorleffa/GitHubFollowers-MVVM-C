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
        configure()
        startObserving(&UserInterfaceStyleManager.shared)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = viewModel?.username
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func configure() {
        customView.button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        viewModel?.getRepositories()
    }
    
    func setupBinds() {
        viewModel?.user.bind { user in
            DispatchQueue.main.async { [weak self] in
                guard let user = user else { return }
                self?.customView.setup(ProfileViewDescriptor(username: user.login,
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
        }
        
        viewModel?.isLoading.bind { isLoading in
            DispatchQueue.main.async { [weak self] in
                self?.customView.showLoadingView(when: isLoading)
            }
        }
        
        viewModel?.isError.bind { isError in
            DispatchQueue.main.async { [weak self] in
                self?.customView.showErrorView(when: isError)
            }
        }
    }
}
