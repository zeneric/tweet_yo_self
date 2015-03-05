//
//  TweetsViewController.swift
//  tweet_yo_self
//
//  Created by Eric Huang on 2/19/15.
//  Copyright (c) 2015 Eric Huang. All rights reserved.
//

import UIKit


class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TweetCellDelegate {
    
    var tweets: [Tweet] = []
    var refreshControl: UIRefreshControl?
    var content = "Tweets"
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 117
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.addSubview(refreshControl!)
        tableView.backgroundColor = UIColor.whiteColor()
        
        refresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh() {
        if content == "Tweets" {
            TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
                self.tweets = tweets!
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            })
        } else if content == "Mentions" {
            TwitterClient.sharedInstance.mentions(nil, completion: { (tweets, error) -> () in
                self.tweets = tweets!
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            })
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var tweet = tweets[indexPath.row]
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
        cell.initWithTweet(tweet)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }

    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }

    @IBAction func onTweet(sender: AnyObject) {
    }
    
    func tweetCellonReply(tweetCell: TweetCell, replyId: String) {
        var vc = storyboard?.instantiateViewControllerWithIdentifier("NewTweetViewController") as NewTweetViewController
        vc.replyId = replyId
        navigationController?.pushViewController(vc, animated: true)
    }
}