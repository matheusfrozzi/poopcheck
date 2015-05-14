//
//  LoginViewController.swift
//  PoopCheck
//
//  Created by Matheus Frozzi Alberton on 24/04/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginWIthFacebook(sender: AnyObject) {
        let permissions = ["email", "public_profile", "user_friends"]

        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions, block: { (user, error) -> Void in
            if let user = user {
                if user.isNew {
                    println("User signed up and logged in through Facebook!")
                    UserDefaultsManager.getDateRegister = NSDate()
                    self.dismissViewControllerAnimated(true, completion: {});
                } else {
                    println("User logged in through Facebook!")
                    self.dismissViewControllerAnimated(true, completion: {});
                }
            } else {
                let alert = UIAlertView()
                alert.title = "Sorry!"
                alert.message = "You cancelled the Facebook login."
                alert.addButtonWithTitle("Dismiss")
                alert.show()
            }
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
