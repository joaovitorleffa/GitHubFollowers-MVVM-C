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
}

class RepositoryCellViewModel: RepositoryCellViewModelProtocol {
    var name: String
    var description: String?
    var stars: Int
    
    init(repository: Repository) {
        name = repository.name
        description = repository.repositoryDescription
        stars = repository.stargazersCount
    }
}
