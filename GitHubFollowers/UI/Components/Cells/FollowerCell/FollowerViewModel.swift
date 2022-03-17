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
}

class FollowerViewModel: FollowerViewModelProtocol {
    var avatarUrl: String
    var username: String
    
    init(follower: Follower) {
        self.avatarUrl = follower.avatarURL
        self.username = follower.login
    }
}
