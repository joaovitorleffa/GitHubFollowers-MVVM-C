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
        url = endpoint.url
    }
    
//    static func buildURL(with endpoint: Endpoint) -> URL? {
//        URL(string: Constants.baseURL + endpoint.query)
//    }
    
    enum Endpoint {
        case followers(username: String, page: Int)
        case user(username: String)
        case repositories(username: String, page: Int)
        
        var url: URL? {
            URL(string: Constants.baseURL + self.query)
        }
        
        var query: String {
            switch self {
            case .followers(let username, let page):
                return "users/\(username)/followers?per_page=100&page=\(page)"
            case .user(let username):
                return "users/\(username)"
            case .repositories(let username, let page):
                return "users/\(username)/repos?per_page=20&page=\(page)"
            }
        }
    }
}
