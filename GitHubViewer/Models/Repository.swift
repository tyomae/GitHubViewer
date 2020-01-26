//
//  Repository.swift
//  GitHubViewer
//
//  Created by Артем  Емельянов  on 16/12/2019.
//  Copyright © 2019 Artem Emelianov. All rights reserved.
//

struct Repository {
    
      var name: String
      var url: String
      var description: String
      
      
      init?(dict: JSON) {
          guard let name = dict["full_name"] as? String,
              let url = dict["html_url"] as? String,
              let description = dict["description"] as? String else { return nil }
          
          self.name = name
          self.url = url
          self.description = description
      }
      
      static func getArray(from json: Any) -> [Repository]? {
    
          guard let jsonObject = json as? JSON,
              let list = jsonObject["items"] as? [JSON] else { return nil }
          var repositories: [Repository] = []
          
          for jsonObject in list {
              if let repository = Repository(dict: jsonObject) {
                  repositories.append(repository)
              }
          }
          return repositories
      }
}

