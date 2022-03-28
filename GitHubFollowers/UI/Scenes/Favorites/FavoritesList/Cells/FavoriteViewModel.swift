//
//  FavoriteViewModel.swift
//  GitHubFollowers
//
//  Created by joaovitor on 28/03/22.
//

import Foundation

protocol FavoriteViewModelProtocol: AnyObject {
    var avatarURL: String { get }
    var name: String { get }
}

class FavoriteViewModel: FavoriteViewModelProtocol {
    private(set) var avatarURL: String
    private(set) var name: String
    
    init(avatarURL: String, name: String) {
        self.avatarURL = avatarURL
        self.name = name
    }
}
