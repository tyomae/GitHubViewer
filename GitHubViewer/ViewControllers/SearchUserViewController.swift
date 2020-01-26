//
//  ViewController.swift
//  GitHubViewer
//
//  Created by Артем  Емельянов  on 14/11/2019.
//  Copyright © 2019 Artem Emelianov. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SafariServices

class SearchUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var users = [User]()
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView(frame: CGRect(x: 0,
            y: 0,
            width: tableView.frame.size.width,
            height: 1))
        }
    }
    @IBOutlet var searchBar: UISearchBar! {
        didSet {
            searchBar.showsCancelButton = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        searchBar.becomeFirstResponder()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        searchBar.placeholder = "Search User"
        searchBar.delegate = self
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchUserTableViewCell
        let user: User
        
        user = users[indexPath.row]
        cell.nameLabel.text = user.login
        cell.userImageView?.sd_setImage(with: URL(string: user.avatarUrl), completed: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        showUserPage(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func showUserPage(_ index: Int) {
        let user = users[index]
        
        if let url = URL(string: user.url) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
}

extension SearchUserViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count != 0 else {
            users = []
            tableView.reloadData()
            return
        }
        SearchService.getUsers(searchText: searchText) { (users, _) in
            guard let users = users else { return }
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.popViewController(animated: true)
    }
}
