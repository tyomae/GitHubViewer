//
//  MainViewController.swift
//  GitHubViewer
//
//  Created by Артем  Емельянов  on 17/11/2019.
//  Copyright © 2019 Artem Emelianov. All rights reserved.
//

import UIKit
import OAuthSwift
import SDWebImage

class MainViewController: UIViewController {
    
    var customView = UIView()



    enum MenuType {
        case searchUsers, searshRepositories, statistic
    }
    
    let menuTypes: [MenuType] = [.searchUsers, .searshRepositories, .statistic]
    
    var isAuthViewControllerShowed = false
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView(frame: CGRect(x: 0,
                                                             y: 0,
                                                             width: tableView.frame.size.width,
                                                             height: 1))
            tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier:"ProfileTableViewCell")
            tableView.register(UINib(nibName: "TextDetailTableViewCell", bundle: nil), forCellReuseIdentifier:"TextDetailTableViewCell")
            tableView.register(UINib(nibName: "StatisticTableViewCell", bundle: nil), forCellReuseIdentifier:"StatisticTableViewCell")
        }
    }
    
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showViewContollerIfNeeded()
        updateBarButtomItems()
    }
    
    func showViewContollerIfNeeded() {
        if !AuthService.isUserAuthorized && !isAuthViewControllerShowed {
            
            isAuthViewControllerShowed.toggle()
            showAuthViewController()

        }
    }
    
    func updateBarButtomItems() {
        if AuthService.isUserAuthorized  {
            let exitButton = UIBarButtonItem(title: "Exit", style: .plain, target: self, action: #selector(exit(_:)))
            navigationItem.setLeftBarButton(exitButton, animated: true)
            navigationController?.navigationBar.tintColor = UIColor.black
        }
        else if !AuthService.isUserAuthorized {
            let loginButton = UIBarButtonItem(title: "Login", style: .plain, target: self, action: #selector(login(_:)))
            navigationItem.setLeftBarButton(loginButton, animated: true)
            navigationController?.navigationBar.tintColor = UIColor.black
        }
    }
    
    
    @objc func exit(_ sender: Any) {
        AuthService.logout()
        tableView.reloadData()
        showAuthViewController()
        updateBarButtomItems()
    }
    
    @objc func login(_ sender: Any) {
        showAuthViewController()
    }
    
    func showAuthViewController() {
        let authViewController = AuthViewController()
        authViewController.authInfoChanged = { [weak self] in
            self?.updateBarButtomItems()
            self?.tableView.reloadData()
        }
        present(authViewController, animated: true)
    }
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AuthService.isUserAuthorized ? menuTypes.count + 1 : menuTypes.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if AuthService.isUserAuthorized {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
                if let data = UserDefaults.standard.data(forKey: "AppUser"), let appUser = try? JSONDecoder().decode(AppUser.self, from: data) {
                    cell.nameLabel.text = appUser.login
                    cell.photoImageView?.sd_setImage(with: URL(string: appUser.avatarUrl), completed: nil)
                    cell.jobTitleLabel.text = appUser.bio
                }
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextDetailTableViewCell", for: indexPath) as! TextDetailTableViewCell
                cell.searchUserLabel?.text = "Search User"
                return cell
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextDetailTableViewCell", for: indexPath) as! TextDetailTableViewCell
                cell.searchUserLabel?.text = "Search Repositories"
                return cell
            } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StatisticTableViewCell", for: indexPath) as! StatisticTableViewCell
                cell.selectionStyle = .none
            return cell
            }
            
        } else {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextDetailTableViewCell", for: indexPath) as! TextDetailTableViewCell
                cell.searchUserLabel?.text = "Search User"
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextDetailTableViewCell", for: indexPath) as! TextDetailTableViewCell
                cell.searchUserLabel?.text = "Search Repositories"
                return cell
            } 
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if AuthService.isUserAuthorized {
            if indexPath.row == 1  {
                performSegue(withIdentifier: "showSearchUsers", sender: nil)
            }
            if indexPath.row == 2 {
                performSegue(withIdentifier: "showSearchRepositories", sender: nil)
            }
        } else {
            if indexPath.row == 0  {
                performSegue(withIdentifier: "showSearchUsers", sender: nil)
            }
            if indexPath.row == 1  {
                performSegue(withIdentifier: "showSearchRepositories", sender: nil)
            }
        }
        
    }
    
    
}

