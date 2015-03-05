//
//  UserStatsCell.swift
//  tweet_yo_self
//
//  Created by Eric Huang on 3/4/15.
//  Copyright (c) 2015 Eric Huang. All rights reserved.
//

import UIKit

class UserStatsCell: UITableViewCell {

    @IBOutlet weak var numFollowersLabel: UILabel!
    @IBOutlet weak var numFollowingLabel: UILabel!
    @IBOutlet weak var numTweetsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
