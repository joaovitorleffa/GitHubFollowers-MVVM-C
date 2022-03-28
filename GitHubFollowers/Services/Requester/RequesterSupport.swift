//
//  APISupport.swift
//  GitHubFollowers
//
//  Created by joaovitor on 17/03/22.
//

import Foundation

enum RequesterError: Error {
    case invalidUrl
    case invalidData
    case invalidResponse
    case requestError
    case decodeError
}
