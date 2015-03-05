//
//  MenuViewController.swift
//  tweet_yo_self
//
//  Created by Eric Huang on 3/3/15.
//  Copyright (c) 2015 Eric Huang. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var vcInContainer: UIViewController!
    
    var mainViewLeftPos: CGFloat!
    var mainViewRightPos: CGFloat!
    var mainViewCurrentPos: CGFloat!
    var mainViewXTranslation: CGFloat!
    
    var containerVC: UINavigationController!
    var profileVC: ProfileViewController!
    var tweetsVC: TweetsViewController!
    
    let menuItems = ["User Profile", "Timeline", "Mentions"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        mainViewLeftPos = mainView.center.x
        mainViewRightPos = mainView.center.x + view.bounds.width - 50.0;
        
        profileVC = storyboard?.instantiateViewControllerWithIdentifier("ProfileViewController") as ProfileViewController
        tweetsVC = storyboard?.instantiateViewControllerWithIdentifier("TweetsViewController") as TweetsViewController

        initContainer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initContainer() {
        var newTweetButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "presentNewTweetVC")
        var hamburgerImage = UIImage(named: "hamburger.png")
        var menuButton = UIBarButtonItem(image: hamburgerImage, landscapeImagePhone: hamburgerImage, style: UIBarButtonItemStyle.Plain, target: self, action: "toggleMenu")
        tweetsVC.navigationItem.rightBarButtonItem = newTweetButton
        tweetsVC.navigationItem.leftBarButtonItem = menuButton
        profileVC.navigationItem.leftBarButtonItem = menuButton
        
        
        containerVC = UINavigationController(rootViewController: tweetsVC)
        containerVC.navigationBar.topItem?.title = "Timeline"

        self.addChildViewController(containerVC)
        self.mainView.addSubview(containerVC.view)
        containerVC.didMoveToParentViewController(self)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MenuItemCell") as MenuItemCell
        cell.menuItemLabel.text = menuItems[indexPath.row]
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            containerVC.viewControllers = [profileVC]
        } else {
            containerVC.viewControllers = [tweetsVC]
            tweetsVC.content = (indexPath.row == 1 ? "Tweets" : "Mentions")
            tweetsVC.refresh()
        }
        
        containerVC.navigationBar.topItem?.title = menuItems[indexPath.row]
        hideMenu()
    }
    
    func presentNewTweetVC() {
        var newTweetVC = storyboard?.instantiateViewControllerWithIdentifier("NewTweetViewController") as NewTweetViewController
        var navVC = UINavigationController(rootViewController: newTweetVC)
        navVC.navigationBar.topItem?.title = "New Tweet"
        self.presentViewController(navVC, animated: true, completion: nil)
    }
    
    @IBAction func onMainViewPan(sender: UIPanGestureRecognizer) {
        var point = sender.locationInView(view)
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        if sender.state == .Began {
            mainViewCurrentPos = mainView.center.x
        } else if sender.state == .Changed {
            var x = mainViewCurrentPos + translation.x
            if x < mainViewLeftPos {
                x = mainViewLeftPos
            } else if x > mainViewRightPos {
                x = mainViewRightPos
            }
            mainView.center.x = x
        } else if sender.state == .Ended {
            
            if velocity.x > 0 {
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.mainView.center.x = self.mainViewRightPos
                })
            }
            else if velocity.x < 0 {
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.mainView.center.x = self.mainViewLeftPos
                })
            }
        }
    }
    
    func hideMenu() {
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.mainView.center.x = self.mainViewLeftPos
        })
    }
    
    func showMenu() {
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.mainView.center.x = self.mainViewRightPos
        })
    }
    
    func toggleMenu() {
        if self.mainView.center.x > view.bounds.width / 2 {
            hideMenu()
        } else {
            showMenu()
        }
    }
}
