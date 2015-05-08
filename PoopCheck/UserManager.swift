//
//  UserManager.swift
//  PoopCheck
//
//  Created by Matheus Frozzi Alberton on 22/04/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit
import Parse

var objectId: String!
var username: String!
var password: String!
var createdAt: NSDate!

class UserManager: NSObject {
    func register() {
        var user = PFUser()
        user.username = "myUsername"
        user.password = "myPassword"
        user.email = "email@example.com"
        // other fields can be set just like with PFObject

        user.signUpInBackgroundWithBlock { (succeded, error) -> Void in
            if error == nil {
                // Hooray! Let them use the app now.
            } else {
                println("errooooo")
                // Show the errorString somewhere and let the user try again.
            }
        }
    }
    
    func login(username: String, password: String) {
        PFUser.logInWithUsernameInBackground(username, password: password) {
            (user, error) -> Void in
            if user != nil {
                println(user?.username)
            } else {
                // The login failed. Check error to see why.
            }

        }
    }
    
    func getDateRegister() {
        var currentUser = PFUser.currentUser()
        
        var query = PFUser.query()
        query!.getObjectInBackgroundWithId(currentUser!.objectId!) {
            (gameScore, error) -> Void in
            if error == nil {
                if UserDefaultsManager.getDateRegister == nil {
                    println("welcome to the first time")
                    UserDefaultsManager.getDateRegister = gameScore!.createdAt!
                }
            } else {
                NSLog("%@", error!)
            }
        }
    }
}
