//
//  File.swift
//  GitHubViewer
//
//  Created by Артем  Емельянов  on 17/11/2019.
//  Copyright © 2019 Artem Emelianov. All rights reserved.
//

import Alamofire

class SearchService: APIService {

    static func getUsers(searchText: String, completion: @escaping ([User]?, Error?) -> Void) {
        var headers = [String: String]()
        if let token = UserDefaults.standard.string(forKey: "Token") {
            headers = ["Authorization": "token \(token)"]
        }
        request("https://api.github.com/search/users?q=\(searchText)",
        method: .get,
        headers: headers).responseJSON { responseJSON in
            switch responseJSON.result {
            case .success(let value):
                guard let users = User.getArray(from: value) else { return }
                completion(users, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    static func getRepositories(searchText: String, completion: @escaping ([Repository]?, Error?) -> Void) {
         var headers = [String: String]()
        if let token = UserDefaults.standard.string(forKey: "Token") {
            headers = ["Authorization": "token \(token)"]
        }
        request("https://api.github.com/search/repositories?q=\(searchText)",
        method: .get,
        headers: headers).responseJSON { responseJSON in
            switch responseJSON.result {
            case .success(let value):
                guard let repositories = Repository.getArray(from: value) else { return }
                completion(repositories, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}



class APIService {
     
    var authHeader: HTTPHeaders? {
        return [:]
    }
}

typealias JSON = [String: Any]
