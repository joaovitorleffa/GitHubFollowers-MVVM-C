//
//  Requester.swift
//  GitHubFollowers
//
//  Created by joaovitor on 17/03/22.
//

import Foundation

typealias Completion<T> = (Result<T, RequesterError>) -> Void

protocol RequesterProtocol {
    func request<T: Decodable>(from urlProvider: URLProvider, completion: @escaping Completion<T>)
}

class Requester: RequesterProtocol {
    func request<T: Decodable>(from urlProvider: URLProvider, completion: @escaping Completion<T>) {
        guard let url = urlProvider.url else {
            completion(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            guard error == nil else {
                completion(.failure(.requestError))
                return
            }
            
            guard let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode, 200..<300 ~= statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            do {
                let values = try decoder.decode(T.self, from: data)
                completion(.success(values))
            } catch {
                print(error)
                completion(.failure(.decodeError))
            }
        }.resume()
    }
}

