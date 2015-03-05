//
//  ProfileViewController.swift
//  tweet_yo_self
//
//  Created by Eric Huang on 3/4/15.
//  Copyright (c) 2015 Eric Huang. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var userScreename = User.currentUser!.screenname!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        fetchUser()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchUser() {
        let params = ["screen_name": userScreename]
        TwitterClient.sharedInstance.user(params, completion: { (user, error) -> () in
            self.user = user
            self.tableView.reloadData()
        })
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 174.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (user != nil) {
            var cell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as HeaderCell
            cell.user = user
            cell.initUser()
            return cell
        }
        return nil
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserStatsCell") as UserStatsCell
    
        cell.numFollowersLabel.text = user?.followersCount
        cell.numFollowingLabel.text = user?.followingCount
        cell.numTweetsLabel.text = user?.tweetsCount
        
        return cell
    }
}
