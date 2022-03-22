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
    var isLoading: Observable<Bool> { get set }
    var isError: Observable<Bool> { get set }
    
    func getRepositories()
}

class ProfileViewModel: ProfileViewModelProtocol {
    var username: String
    var coordinator: RepositoriesDelegate
    private var requester: RequesterProtocol
    
    var user: Observable<User?> = Observable(nil)
    var isLoading: Observable<Bool> = Observable(true)
    var isError: Observable<Bool> = Observable(false)
    
    init(username: String, coordinator: RepositoriesDelegate, requester: RequesterProtocol = Requester()) {
        self.username = username
        self.requester = requester
        self.coordinator = coordinator
        
        fetchUser()
    }
    
    func fetchUser() {
        requester.request(from: URLProvider(endpoint: .user(username: username))) { [weak self] (result: Result<User, RequesterError>) in
            switch result {
            case .success(let user):
                self?.user.value = user
                self?.isLoading.value = false
            case .failure(let error):
                print("[fetchUser] \(error.localizedDescription)")
                self?.isLoading.value = false
                self?.isError.value = true
            }
        }
    }
    
    func getRepositories() {
        coordinator.goToRepositories(by: username)
    }
}
