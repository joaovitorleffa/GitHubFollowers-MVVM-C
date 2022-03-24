//
//  RepositoryCellViewModel.swift
//  GitHubFollowers
//
//  Created by joaovitor on 21/03/22.
//

import Foundation
import UIKit

protocol RepositoryCellViewModelProtocol {
    var name: String { get set }
    var description: String? { get set }
    var stars: Int { get set }
    var language: String? { get set }
    var date: String { get set }
    var langColor: UIColor? { get set }
}

class RepositoryCellViewModel: RepositoryCellViewModelProtocol {
    var name: String
    var description: String?
    var stars: Int
    var language: String?
    var date: String
    var langColor: UIColor?
    
    init(repository: Repository) {
        name = repository.name
        description = repository.repositoryDescription
        stars = repository.stargazersCount
        language = repository.language
        date = repository.createdAt.format
        langColor = Language.colors[repository.language ?? ""] ?? nil
    }
}
