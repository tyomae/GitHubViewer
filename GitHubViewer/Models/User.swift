//
//  User.swift
//  GitHubViewer
//
//  Created by Артем  Емельянов  on 15/11/2019.
//  Copyright © 2019 Artem Emelianov. All rights reserved.
//

struct User {
    
    var login: String
    var url: String
    var avatarUrl: String
    
    init?(dict: JSON) {
        guard let login = dict["login"] as? String,
            let url = dict["html_url"] as? String,
           let avatarUrl = dict["avatar_url"] as? String else { return nil }
        
        self.login = login
        self.url = url
        self.avatarUrl = avatarUrl
        
    }
    
    static func getArray(from json: Any) -> [User]? {
  
        guard let jsonObject = json as? JSON,
            let list = jsonObject["items"] as? [JSON] else { return nil }
        var users: [User] = []
        
        for jsonObject in list {
            if let user = User(dict: jsonObject) {
                users.append(user)
            }
        }
        return users
    }
}
