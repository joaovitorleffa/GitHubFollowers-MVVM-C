//
//  FollowersListViewModel.swift
//  GitHubFollowers
//
//  Created by joaovitor on 16/03/22.
//

import Foundation

protocol FollowerListViewModelProtocol: AnyObject {
    var username: String { get set }
    var followers: Observable<[Follower]> { get set }
}

class FollowersListViewModel: FollowerListViewModelProtocol {
    var username: String
    var followers: Observable<[Follower]> = Observable([])
    var requester: RequesterProtocol
    
    init(username: String, requester: RequesterProtocol = Requester()) {
        self.username = username
        self.requester = requester
        
        fetchFollowers()
    }
    
    func fetchFollowers() {
        requester.request(from: URLProvider(endpoint: .followers(username: username, page: 1))) { [weak self] (result: Result<[Follower], APIError>) in
            switch result {
            case .success(let data):
                self?.followers.value = data
            case .failure(let error):
                print(error)
            }
        }
    }
}
