//
//  Repository.swift
//  GitHubFollowers
//
//  Created by joaovitor on 21/03/22.
//

import Foundation

// MARK: - Repository
struct Repository: Codable {
    let id: Int
    let name, fullName: String
    let repositoryPrivate: Bool
    let owner: Owner
    let htmlURL: String
    let repositoryDescription: String?
    let createdAt, updatedAt, pushedAt: Date
    let stargazersCount: Int
    let language: String?
    let openIssuesCount: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case fullName = "full_name"
        case repositoryPrivate = "private"
        case owner
        case htmlURL = "html_url"
        case repositoryDescription = "description"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case stargazersCount = "stargazers_count"
        case language
        case openIssuesCount = "open_issues_count"
    }
}

// MARK: - Owner
struct Owner: Codable {
    let login: String
    let id: Int
    let avatarURL: String
    let gravatarID: String

    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
    }
}
