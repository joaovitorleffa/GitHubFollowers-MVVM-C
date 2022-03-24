//
//  RepositoriesViewModel.swift
//  GitHubFollowers
//
//  Created by joaovitor on 22/03/22.
//

import Foundation

protocol RepositoriesViewModelProtocol: AnyObject {
    var username: String { get set }
    var repositories: Observable<[Repository]> { get set }
    var isLoading: Observable<Bool> { get set }
    var isError: Observable<Bool> { get set }
    func fetchRepositories()
}

class RepositoriesViewModel: RepositoriesViewModelProtocol {
    private var currentPage = 1
    private var loadedAll = false
    
    var username: String
    var requester: RequesterProtocol
    
    var repositories: Observable<[Repository]> = Observable([])
    var isError: Observable<Bool> = Observable(false)
    var isLoading: Observable<Bool> = Observable(true)
    
    init(username: String, requester: RequesterProtocol = Requester()) {
        self.username = username
        self.requester = requester
        
        fetchRepositories()
    }
    
    func fetchRepositories() {
        if loadedAll { return }
        isLoading.value = true
        
        requester.request(from: URLProvider(endpoint: .repositories(username: username, page: currentPage))) { [weak self] (result: Result<[Repository], RequesterError>) in
            switch result {
            case .success(let repositories):
                if repositories.isEmpty {
                    self?.loadedAll = true
                } else {
                    self?.currentPage += 1
                    self?.repositories.value.append(contentsOf: repositories)
                }
                self?.isLoading.value = false
            case .failure(let error):
                print("[fetchRepositories] \(error.localizedDescription)")
                self?.isLoading.value = false
                self?.isError.value = true
            }
        }
    }
}
