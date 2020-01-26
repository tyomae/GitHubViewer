//
//  TableViewCell.swift
//  GitHubViewer
//
//  Created by Артем  Емельянов  on 14/11/2019.
//  Copyright © 2019 Artem Emelianov. All rights reserved.
//

import UIKit

class SearchUserTableViewCell: UITableViewCell {

    @IBOutlet var userImageView: UIImageView! {
        didSet {
            userImageView.layer.cornerRadius = userImageView.frame.size.height / 2
            userImageView.clipsToBounds = true
        }
    }
    @IBOutlet var nameLabel: UILabel!
}
