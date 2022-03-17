//
//  FollowersListViewModel.swift
//  GitHubFollowers
//
//  Created by joaovitor on 16/03/22.
//

import Foundation

protocol FollowerListViewModelProtocol: AnyObject {
    var username: String { get set }
}

class FollowersListViewModel: FollowerListViewModelProtocol {
    var username: String
    
    init(username: String) {
        self.username = username
    }
}
