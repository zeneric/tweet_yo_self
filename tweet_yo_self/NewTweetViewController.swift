//
//  NewTweetViewController.swift
//  tweet_yo_self
//
//  Created by Eric Huang on 2/21/15.
//  Copyright (c) 2015 Eric Huang. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var inputField: UITextView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var replyId: String?
    
    @IBOutlet weak var navBar: UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = NSURL(string: User.currentUser!.profileImageURL!)
        profileImage.setImageWithURL(url)
        nameLabel.text = User.currentUser?.name
        usernameLabel.text = User.currentUser?.screenname
        
        inputField.delegate = self
        inputField.becomeFirstResponder()
        
        var removeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "dismissSelf")
        navigationItem.rightBarButtonItem = removeButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textView(textView: UITextView!, shouldChangeTextInRange: NSRange, replacementText: NSString!) -> Bool {
        if(replacementText == "\n") {
            textView.resignFirstResponder()
            spinner.startAnimating()
            var params = ["status": textView.text]
            if (replyId != nil) {
                params["replyId"] = replyId!
            }
            TwitterClient.sharedInstance.updateStatus(params, completion: {
                (error: NSError?) -> Void in
                if error == nil {
                    self.navigationController?.popViewControllerAnimated(true)
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    println("ERROR POSTING")
                }
            })
            return false
        }
        return true
    }
    
    func dismissSelf() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
