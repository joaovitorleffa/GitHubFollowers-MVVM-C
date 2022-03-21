//
//  FollowersListViewModel.swift
//  GitHubFollowers
//
//  Created by joaovitor on 16/03/22.
//

import Foundation

protocol FollowersListViewModelProtocol: AnyObject {
    var username: String { get set }
    var coordinator: SearchCoordinatorDelegate? { get set }
    
    var isError: Observable<Bool> { get }
    var isLoading: Observable<Bool> { get }
    var followers: Observable<[Follower]> { get set }
    
    func reloadData()
    func fetchFollowers()
    func filter(by text: String)
}

class FollowersListViewModel: FollowersListViewModelProtocol {
    var username: String
    var requester: RequesterProtocol
    weak var coordinator: SearchCoordinatorDelegate?
    
    var isError: Observable<Bool> = Observable(false)
    var isLoading: Observable<Bool> = Observable(true)
    var followers: Observable<[Follower]> = Observable([])
    
    private var currentPage = 1
    private var loadedAll: Bool = false
    private var allFollowers: [Follower] = []
    private var filteredFollowers: [Follower] = []
    
    init(username: String, coordinator: SearchCoordinatorDelegate, requester: RequesterProtocol = Requester()) {
        self.username = username
        self.requester = requester
        self.coordinator = coordinator
        
        fetchFollowers()
    }
    
    func fetchFollowers() {
        if loadedAll { return }
        isLoading.value = true
        
        requester.request(from: URLProvider(endpoint: .followers(username: username, page: currentPage))) { [weak self] (result: Result<[Follower], RequesterError>) in
            switch result {
            case .success(let data):
                guard let self = self else { return }
                
                if data.isEmpty {
                    self.loadedAll = true
                } else {
                    self.allFollowers.append(contentsOf: data)
                    self.followers.value = self.allFollowers
                    self.currentPage += 1
                }
    
                self.isLoading.value = false
            case .failure(let error):
                self?.isLoading.value = false
                self?.isError.value = true
                print(error)
            }
        }
    }
    
    func filter(by text: String) {
        followers.value = allFollowers.filter { $0.login.lowercased().contains(text.lowercased()) }
    }
    
    func reloadData() {
        followers.value = allFollowers
    }
}
