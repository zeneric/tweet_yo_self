//
//  HeaderCell.swift
//  tweet_yo_self
//
//  Created by Eric Huang on 3/4/15.
//  Copyright (c) 2015 Eric Huang. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {

    var user: User!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    contentView.backgroundColor = UIColor(patternImage: UIImage(named: "banner.jpg")!)
    }
    
    func initUser() {
        let url = NSURL(string: user.profileImageURL!)
        profileImageView.setImageWithURL(url)
        nameLabel.text = user.name
        usernameLabel.text = user.screenname
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
