//
//  RepositoriesViewModel.swift
//  GitHubFollowers
//
//  Created by joaovitor on 22/03/22.
//

import Foundation

protocol RepositoriesViewModelProtocol: AnyObject {
    var username: String { get set }
    var coordinator: ProfileCoordinatorDelegate { get set }
    var repositories: Observable<[Repository]> { get set }
    var isLoading: Observable<Bool> { get set }
    var isError: Observable<Bool> { get set }
    func showRepository(_ repository: Repository)
}

class RepositoriesViewModel: RepositoriesViewModelProtocol {
    var username: String
    var coordinator: ProfileCoordinatorDelegate
    var requester: RequesterProtocol
    
    var repositories: Observable<[Repository]> = Observable([])
    var isError: Observable<Bool> = Observable(false)
    var isLoading: Observable<Bool> = Observable(true)
    
    init(username: String, coordinator: ProfileCoordinatorDelegate, requester: RequesterProtocol = Requester()) {
        self.username = username
        self.requester = requester
        self.coordinator = coordinator
        
        fetchRepositories()
    }
    
    func fetchRepositories() {
        requester.request(from: URLProvider(endpoint: .repositories(username: username))) { [weak self] (result: Result<[Repository], RequesterError>) in
            switch result {
            case .success(let repositories):
                self?.repositories.value = repositories
                self?.isLoading.value = false
            case .failure(let error):
                print("[fetchRepositories] \(error.localizedDescription)")
                self?.isLoading.value = false
                self?.isError.value = true
            }
        }
    }
    
    func showRepository(_ repository: Repository) {
        coordinator.goToRepository(url: repository.htmlURL)
    }
}
