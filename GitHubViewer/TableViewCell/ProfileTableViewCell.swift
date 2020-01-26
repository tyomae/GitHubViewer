//
//  ProfileTableViewCell.swift
//  GitHubViewer
//
//  Created by Артем  Емельянов  on 17/11/2019.
//  Copyright © 2019 Artem Emelianov. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet var photoImageView: UIImageView! {
        didSet {
            photoImageView.layer.cornerRadius = photoImageView.frame.size.height / 2
            photoImageView.clipsToBounds = true
        }
    }
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var jobTitleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()

            nameLabel.text = nil
            jobTitleLabel.text = nil
            photoImageView.image = nil
    }
}
