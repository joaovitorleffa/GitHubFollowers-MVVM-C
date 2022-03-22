//
//  Profile.swift
//  GitHubFollowers
//
//  Created by joaovitor on 18/03/22.
//

import Foundation

@propertyWrapper
struct Social: Equatable {
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
struct ThousandAbbreviation: Equatable {
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

struct User: Codable, Equatable {
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

extension User {
    static func dummy() -> User {
        User(login: "joaovitorleffa",
             id: 44384402,
             avatarURL: "https://avatars.githubusercontent.com/u/44384402?v=4",
             url: "https://api.github.com/users/joaovitorleffa",
             htmlURL: "https://github.com/joaovitorleffa",
             followersURL: "https://api.github.com/users/joaovitorleffa/followers",
             followingURL: "https://api.github.com/users/joaovitorleffa/following{/other_user}",
             gistsURL: "https://api.github.com/users/joaovitorleffa/gists{/gist_id}",
             starredURL: "https://api.github.com/users/joaovitorleffa/starred{/owner}{/repo}",
             subscriptionsURL: "https://api.github.com/users/joaovitorleffa/subscriptions",
             organizationsURL: "https://api.github.com/users/joaovitorleffa/orgs",
             reposURL: "https://api.github.com/users/joaovitorleffa/repos",
             name: "João Vitor",
             bio: "iOS Developer at CWI",
             email: nil,
             twitterUsername: nil,
             company: "CWI",
             location: "Torres, RS",
             blog: nil,
             publicRepos: "53",
             publicGists: "0",
             followers: "32",
             following: "50",
             createdAt: "2018-10-23T00:26:15Z".date,
             updatedAt: "2022-03-01T16:11:55Z".date)
    }
}

