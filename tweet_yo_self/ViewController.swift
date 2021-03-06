//
//  ViewController.swift
//  tweet_yo_self
//
//  Created by Eric Huang on 2/19/15.
//  Copyright (c) 2015 Eric Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                // Perform segueway
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                // Handle login error
            }
        }
    }
}

