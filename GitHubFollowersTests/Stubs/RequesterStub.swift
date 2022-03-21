//
//  RequesterStub.swift
//  GitHubFollowersTests
//
//  Created by joaovitor on 18/03/22.
//

import Foundation
@testable import GitHubFollowers

class RequesterStub: RequesterProtocol {
    var data: Decodable?
    var error: RequesterError?

    init(success data: Decodable) {
        self.data = data
    }
    
    init(error: RequesterError) {
        self.error = error
    }
    
    func request<T: Decodable>(from urlProvider: URLProvider, completion: @escaping Completion<T>) {
        if let error = self.error {
            completion(.failure(error))
            return
        }
        
        if let data = self.data as? T {
            completion(.success(data))
        }
    }
}
