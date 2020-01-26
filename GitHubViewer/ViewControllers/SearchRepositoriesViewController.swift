//
//  SearchRepositoriesViewController.swift
//  GitHubViewer
//
//  Created by Артем  Емельянов  on 12/12/2019.
//  Copyright © 2019 Artem Emelianov. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SafariServices

class SearchRepositoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var repositories = [Repository]()
    
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
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        searchBar.placeholder = "Search Repository"
        searchBar.delegate = self
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchRepositoryTableViewCell
        let repository: Repository
        
        repository = repositories[indexPath.row]
        cell.nameLabel.text = repository.name
        cell.descriptionLabel.text = repository.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        showRepositoryPage(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func showRepositoryPage(_ index: Int) {
        let repository = repositories[index]
        
        if let url = URL(string: repository.url) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
}

extension SearchRepositoriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count != 0 else {
            repositories = []
            tableView.reloadData()
            return
        }
        SearchService.getRepositories(searchText: searchText) { (repositories, _) in
            guard let repositories = repositories else { return }
            self.repositories = repositories
            self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.popViewController(animated: true)
    }
}

