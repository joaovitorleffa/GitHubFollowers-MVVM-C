//
//  RepositoriesViewModel.swift
//  GitHubFollowers
//
//  Created by joaovitor on 22/03/22.
//

import Foundation

protocol RepositoriesViewModelProtocol: AnyObject {
    var username: String { get }
    var currentPage: Int { get }
    var loadedAll: Observable<Bool> { get }
    var repositories: Observable<[Repository]> { get }
    var isLoading: Observable<Bool> { get }
    var isError: Observable<Bool> { get }
    func fetchRepositories()
}

class RepositoriesViewModel: RepositoriesViewModelProtocol {
    var requester: RequesterProtocol
    
    private(set) var username: String
    private(set) var currentPage = 1
    private(set) var repositories: Observable<[Repository]> = Observable([])
    private(set) var isError: Observable<Bool> = Observable(false)
    private(set) var isLoading: Observable<Bool> = Observable(true)
    private(set) var loadedAll: Observable<Bool> = Observable(false)
    
    init(username: String, requester: RequesterProtocol = Requester()) {
        self.username = username
        self.requester = requester
        
        fetchRepositories()
    }
    
    func fetchRepositories() {
        if loadedAll.value { return }
        isLoading.value = true
        
        requester.request(from: URLProvider(endpoint: .repositories(username: username, page: currentPage))) { [weak self] (result: Result<[Repository], RequesterError>) in
            switch result {
            case .success(let repositories):
                if repositories.isEmpty {
                    self?.loadedAll.value = true
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
