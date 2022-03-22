//
//  Repository.swift
//  GitHubFollowers
//
//  Created by joaovitor on 21/03/22.
//

import Foundation

// MARK: - Repository
struct Repository: Codable, Equatable {
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
struct Owner: Codable, Equatable {
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

extension Repository {
    static func dummy() -> Repository {
        return Repository(id: 201650310,
                                    name: "2019-2",
                                    fullName: "joaovitorleffa/2019-2",
                                    repositoryPrivate: false,
                                    owner: Owner(login: "joaovitorleffa",
                                                 id: 44384402,
                                                 avatarURL: "https://avatars.githubusercontent.com/u/44384402?v=4",
                                                 gravatarID: ""),
                                    htmlURL: "https://github.com/joaovitorleffa/2019-2",
                                    repositoryDescription: "Trabalhos e Exercícios da Faculdade",
                                    createdAt: "2019-08-10T15:45:10Z".date,
                                    updatedAt: "2019-09-17T16:31:00Z".date,
                                    pushedAt: "2019-09-17T16:30:59Z".date,
                                    stargazersCount: 0,
                                    language: "Java",
                                    openIssuesCount: 0)
    }
}
