//
//  FollowerViewModel.swift
//  GitHubFollowers
//
//  Created by joaovitor on 17/03/22.
//

import Foundation

protocol FollowerViewModelProtocol: AnyObject {
    var avatarUrl: String { get set }
    var username: String { get set }
    var goToProfile: (() -> Void)? { get set }
}

class FollowerViewModel: FollowerViewModelProtocol {
    var avatarUrl: String
    var username: String
    var goToProfile: (() -> Void)?
    
    init(follower: Follower, goToProfile: (() -> Void)?) {
        self.avatarUrl = follower.avatarURL
        self.username = follower.login
        self.goToProfile = goToProfile
    }
}
