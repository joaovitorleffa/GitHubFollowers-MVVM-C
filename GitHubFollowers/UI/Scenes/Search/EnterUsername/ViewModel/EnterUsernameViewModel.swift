//
//  EnterUsernameViewModel.swift
//  GitHubFollowers
//
//  Created by joaovitor on 16/03/22.
//

import Foundation

protocol EnterUsernameViewModelProtocol: AnyObject {
    var findFollowers: ((String) -> Void)? { get set }
}

class EnterUsernameViewModel: EnterUsernameViewModelProtocol {
    var findFollowers: ((String) -> Void)?
}
