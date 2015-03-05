//
//  TweetCell.swift
//  tweet_yo_self
//
//  Created by Eric Huang on 2/21/15.
//  Copyright (c) 2015 Eric Huang. All rights reserved.
//

import UIKit

protocol TweetCellDelegate: class {
    func tweetCellonReply(tweetCell: TweetCell, replyId: String)
}

class TweetCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var tweet: Tweet?
    var delegate: TweetCellDelegate?
    
    func initWithTweet(tweet: Tweet) {
        self.tweet = tweet
        let user = tweet.user
        nameLabel.text = user?.name
        usernameLabel.text = user?.screenname
        profileImage.setImageWithURL(NSURL(string: user!.profileImageURL!))
        contentLabel.text = tweet.text

        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd hh:mm" // superset of OP's format
        timeAgoLabel.text = dateFormatter.stringFromDate(NSDate())
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onRetweet(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(tweet!.idStr!, completion: { (error) -> () in
            if (error == nil) {
                self.retweetButton.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Normal)
            } else {
                println("Failed to retweet")
            }
        })
    }

    @IBAction func onReply(sender: AnyObject) {
        if let delegate = delegate {
            delegate.tweetCellonReply(self, replyId: tweet!.idStr!)
//            var vc = NewTweetViewController()
//            vc.replyId = tweet?.idStr
        }
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        TwitterClient.sharedInstance.favorite(tweet!.idStr!, completion: { (error) -> () in
            if (error == nil) {
                self.favoriteButton.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Normal)
            } else {
                println("Failed to favorite")
            }
        })
    }
}