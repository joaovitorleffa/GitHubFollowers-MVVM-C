//
//  Profile.swift
//  GitHubFollowers
//
//  Created by joaovitor on 18/03/22.
//

import Foundation

@propertyWrapper
struct Social {
    let wrappedValue: String
}

extension Social: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringDecoded = try container.decode(String.self)
        self.wrappedValue = "@\(stringDecoded)"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.wrappedValue)
    }
}

@propertyWrapper
struct ThousandAbbreviation {
    let wrappedValue: String
}

extension ThousandAbbreviation: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(Int.self)
        self.wrappedValue = value.abbreviation
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.wrappedValue)
    }
}

struct User: Codable {
    @Social var login: String
    let id: Int
    let avatarURL, url, htmlURL, followersURL: String
    let followingURL, gistsURL, starredURL: String
    let subscriptionsURL, organizationsURL, reposURL: String
    let name: String?
    let bio: String?
    let email: String?
    let twitterUsername, company, location, blog: String?
    @ThousandAbbreviation var publicRepos: String
    @ThousandAbbreviation var publicGists: String
    @ThousandAbbreviation var followers: String
    @ThousandAbbreviation var following: String
    let createdAt, updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case url
        case email
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case name, company, blog, location, bio
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

