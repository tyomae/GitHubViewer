//
//  AuthService.swift
//  GitHubViewer
//
//  Created by Артем  Емельянов  on 23/11/2019.
//  Copyright © 2019 Artem Emelianov. All rights reserved.
//
import OAuthSwift
import UIKit
import SVProgressHUD
import Alamofire

struct AuthService {
    
    private static let oauthswift = OAuth2Swift(
        consumerKey: "7826751cb82f220c72b3",
        consumerSecret: "8b950f7ae99b9fdac78008d1e17477ac723048a9",
        authorizeUrl: "https://github.com/login/oauth/authorize",
        accessTokenUrl: "https://github.com/login/oauth/access_token",
        responseType: "token"
    )

    static var isUserAuthorized: Bool {
        return UserDefaults.standard.string(forKey: "Token") != nil && UserDefaults.standard.data(forKey: "AppUser") != nil
    }
    
    static func auth(viewController: UIViewController, completion: @escaping ((Bool) -> Void)) {
        let state = generateState(withLength: 20)
        
        oauthswift.allowMissingStateCheck = true
        oauthswift.authorizeURLHandler = SafariURLHandler(viewController: viewController, oauthSwift: oauthswift)
        
        _ = oauthswift.authorize(
        withCallbackURL: URL(string: "github7826751cb82f220c72b3://oauth-callback")!, scope: "user,repo", state: state) { result in
            switch result {
            case .success(let (credential, _, _)):
                UserDefaults.standard.set(credential.oauthToken, forKey: "Token")
//                SVProgressHUD.show()
                AppUserService.getUser(token: credential.oauthToken) { (user, error) in
     //               SVProgressHUD.dismiss()
                    guard let user = user,
                        let data = try? JSONEncoder().encode(user) else {
                            completion(false)
                            return
                    }
                    UserDefaults.standard.set(data, forKey: "AppUser")
                    completion(true)
                }
            case .failure(_):
                completion(false)
            }
        }
    }
    
    static func logout() {
        UserDefaults.standard.set(nil, forKey: "Token")
        UserDefaults.standard.set(nil, forKey: "AppUser")
         
    }
}

