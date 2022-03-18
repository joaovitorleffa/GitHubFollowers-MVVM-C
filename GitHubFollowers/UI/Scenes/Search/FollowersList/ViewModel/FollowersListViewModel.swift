//
//  FollowersListViewModel.swift
//  GitHubFollowers
//
//  Created by joaovitor on 16/03/22.
//

import Foundation

protocol FollowerListViewModelProtocol: AnyObject {
    var username: String { get set }
    var isLoading: Observable<Bool> { get }
    var followers: Observable<[Follower]> { get set }
    func fetchFollowers()
}

class FollowersListViewModel: FollowerListViewModelProtocol {
    var username: String
    var isLoading: Observable<Bool> = Observable(true)
    var followers: Observable<[Follower]> = Observable([])
    var requester: RequesterProtocol
    
    private var currentPage = 1
    private var loadedAll: Bool = false
    
    init(username: String, requester: RequesterProtocol = Requester()) {
        self.username = username
        self.requester = requester
        
        fetchFollowers()
    }
    
    func fetchFollowers() {
        if loadedAll { return }
        isLoading.value = true
        
        requester.request(from: URLProvider(endpoint: .followers(username: username, page: currentPage))) { [weak self] (result: Result<[Follower], APIError>) in
            switch result {
            case .success(let data):
                guard let self = self else { return }
                
                if data.isEmpty {
                    self.loadedAll = true
                } else {
                    self.followers.value.append(contentsOf: data)
                    self.currentPage += 1
                }
    
                self.isLoading.value = false
            case .failure(let _):
                self?.isLoading.value = false
                // TODO: handle error
            }
        }
    }
}
