//
//  AppService.swift
//  GitHubViewer
//
//  Created by Артем  Емельянов  on 23/11/2019.
//  Copyright © 2019 Artem Emelianov. All rights reserved.
//

struct AppUser: Codable {
    
    var login: String
    var avatarUrl: String
    var bio: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case bio
        case avatarUrl = "avatar_url"
    }
}
