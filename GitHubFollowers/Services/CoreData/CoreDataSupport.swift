//
//  Support.swift
//  GitHubFollowers
//
//  Created by joaovitor on 28/03/22.
//

import Foundation

enum CoreDataError: Error {
    case requestError
    case saveError
    case alreadyExists
}

struct FavoriteToSave {
    let id: Int
    let name: String
    let username: String
    let avatarURL: String
}
