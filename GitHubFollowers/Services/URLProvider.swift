//
//  URLProvider.swift
//  GitHubFollowers
//
//  Created by joaovitor on 17/03/22.
//

import Foundation

struct Constants {
    static let baseURL = "https://api.github.com/"
}

struct URLProvider {
    var url: URL?
    
    init(endpoint: Endpoint) {
        url = Self.buildURL(with: endpoint)
    }
    
    static func buildURL(with endpoint: Endpoint) -> URL? {
        URL(string: Constants.baseURL + endpoint.query)
    }
    
    enum Endpoint {
        case followers(username: String, page: Int)
        case user(username: String)
        case repositories(username: String)
        
        var query: String {
            switch self {
            case .followers(let username, let page):
                return "users/\(username)/followers?per_page=100&page=\(page)"
            case .user(let username):
                return "users/\(username)"
            case .repositories(let username):
                return "users/\(username)/repos"
            }
        }
    }
}
