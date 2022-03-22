//
//  ProfileViewModel.swift
//  GitHubFollowers
//
//  Created by joaovitor on 18/03/22.
//

import Foundation

protocol ProfileViewModelProtocol: AnyObject {
    var username: String { get set }
    var coordinator: RepositoriesDelegate { get set }
    var user: Observable<User?> { get set }
    var repositories: Observable<[Repository]> { get set }
    func getRepositories()
}

class ProfileViewModel: ProfileViewModelProtocol {
    var username: String
    var coordinator: RepositoriesDelegate
    private var requester: RequesterProtocol
    
    var user: Observable<User?> = Observable(nil)
    var repositories: Observable<[Repository]> = Observable([])
    
    init(username: String, coordinator: RepositoriesDelegate, requester: RequesterProtocol = Requester()) {
        self.username = username
        self.requester = requester
        self.coordinator = coordinator
        
        fetchUser()
        fetchRepositories()
    }
    
    func fetchUser() {
        requester.request(from: URLProvider(endpoint: .user(username: username))) { [weak self] (result: Result<User, RequesterError>) in
            switch result {
            case .success(let user):
                self?.user.value = user
            case .failure(let error):
                print(error)
                // TODO: handle error
            }
        }
    }
    
    func fetchRepositories() {
        requester.request(from: URLProvider(endpoint: .repositories(username: username))) { [weak self] (result: Result<[Repository], RequesterError>) in
            switch result {
            case .success(let repositories):
                self?.repositories.value = repositories
            case .failure(let error):
                print("[fetchRepositories] \(error)")
            }
        }
    }
    
    func getRepositories() {
        coordinator.goToRepositories(by: username)
    }
}
