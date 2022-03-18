//
//  ProfileViewModel.swift
//  GitHubFollowers
//
//  Created by joaovitor on 18/03/22.
//

import Foundation

protocol ProfileViewModelProtocol: AnyObject {
    var username: String { get set }
}

class ProfileViewModel: ProfileViewModelProtocol {
    var username: String
    
    init(username: String) {
        self.username = username
    }
}
