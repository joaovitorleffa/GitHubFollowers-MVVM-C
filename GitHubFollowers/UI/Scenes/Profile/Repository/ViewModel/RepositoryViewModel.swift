//
//  RepositoryViewModel.swift
//  GitHubFollowers
//
//  Created by joaovitor on 22/03/22.
//

import Foundation

protocol RepositoryViewModelProtocol: AnyObject {
    var repositoryUrl: URL? { get set }
}

class RepositoryViewModel: RepositoryViewModelProtocol {
    var repositoryUrl: URL?
    
    init(repositoryUrl: URL?) {
        self.repositoryUrl = repositoryUrl
    }
}
