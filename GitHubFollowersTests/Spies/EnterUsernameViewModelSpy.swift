//
//  EnterUsernameViewModelSpy.swift
//  GitHubFollowersTests
//
//  Created by joaovitor on 28/03/22.
//

import Foundation
@testable import GitHubFollowers

class EnterUsernameViewModelSpy: EnterUsernameViewModelProtocol {
    var findFollowersCalledWith: String?
    
    lazy var findFollowers: ((String) -> Void)? = { text in
        self.findFollowersCalledWith = text
    }
}
