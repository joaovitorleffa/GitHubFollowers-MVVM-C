//
//  User.swift
//  GitHubFollowers
//
//  Created by joaovitor on 17/03/22.
//

import Foundation

struct Follower: Codable, Hashable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String
    let url, htmlURL, followersURL: String
    let followingURL, gistsURL, starredURL: String
    let subscriptionsURL, organizationsURL, reposURL: String
    let eventsURL: String
    let receivedEventsURL: String
    let type: String
    let siteAdmin: Bool
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
}

extension Follower {
    static func dummy() -> Follower {
        Follower(login: "joaovitorleffa",
                 id: 1,
                 nodeID: "onmnju312",
                 avatarURL: "https://avatars.githubusercontent.com/u/44384402?v=4",
                 gravatarID: "",
                 url: "https://api.github.com/users/joaovitorleffa",
                 htmlURL: "https://github.com/joaovitorleffa",
                 followersURL: "https://api.github.com/users/joaovitorleffa/followers",
                 followingURL: "https://api.github.com/users/joaovitorleffa/following{/other_user}",
                 gistsURL: "https://api.github.com/users/joaovitorleffa/gists{/gist_id}",
                 starredURL: "https://api.github.com/users/joaovitorleffa/starred{/owner}{/repo}",
                 subscriptionsURL: "https://api.github.com/users/joaovitorleffa/subscriptions",
                 organizationsURL: "https://api.github.com/users/joaovitorleffa/orgs",
                 reposURL: "https://api.github.com/users/joaovitorleffa/repos",
                 eventsURL: "https://api.github.com/users/joaovitorleffa/events{/privacy}",
                 receivedEventsURL: "https://api.github.com/users/joaovitorleffa/received_events",
                 type: "User",
                 siteAdmin: false)
    }
}
