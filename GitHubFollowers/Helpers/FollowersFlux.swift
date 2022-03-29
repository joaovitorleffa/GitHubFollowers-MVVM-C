//
//  FollowersFlux.swift
//  GitHubFollowers
//
//  Created by joaovitor on 29/03/22.
//

import Foundation

protocol FollowersFlux: AnyObject {
    func goToProfile(by username: String)
    func goToFollowers(by username: String)
}
