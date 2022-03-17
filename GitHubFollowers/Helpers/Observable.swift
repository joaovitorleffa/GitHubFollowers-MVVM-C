//
//  Observable.swift
//  GitHubFollowers
//
//  Created by joaovitor on 17/03/22.
//

import Foundation

class Observable<T> {
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    var listener: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
