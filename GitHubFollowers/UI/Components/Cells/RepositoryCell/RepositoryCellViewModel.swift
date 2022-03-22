//
//  RepositoryCellViewModel.swift
//  GitHubFollowers
//
//  Created by joaovitor on 21/03/22.
//

import Foundation

protocol RepositoryCellViewModelProtocol {
    var name: String { get set }
    var description: String? { get set }
    var stars: Int { get set }
    var showRepository: (() -> Void)? { get set }
}

class RepositoryCellViewModel: RepositoryCellViewModelProtocol {
    var name: String
    var description: String?
    var stars: Int
    var showRepository: (() -> Void)?
    
    init(repository: Repository, showRepository: (() -> Void)?) {
        name = repository.name
        description = repository.repositoryDescription
        stars = repository.stargazersCount
        self.showRepository = showRepository
    }
}
