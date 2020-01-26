//
//  AppUserService.swift
//  GitHubViewer
//
//  Created by Артем  Емельянов  on 23/11/2019.
//  Copyright © 2019 Artem Emelianov. All rights reserved.
//

import Alamofire

class AppUserService: APIService {
    
    static func getUser(token: String, completion: @escaping (AppUser?, Error?) -> Void) {
        request("https://api.github.com/user",
                method: .get,
                headers: ["Authorization": "token \(token)"]).responseData { response in
                    switch response.result {
                    case .success(let data):
                        if let appUser = try? JSONDecoder().decode(AppUser.self, from: data) {
                            completion(appUser, nil)
                        } else {
                        completion(nil, nil)
                        }
                    case .failure(let error):
                        completion(nil, error)
                    }
        }
    }
}
