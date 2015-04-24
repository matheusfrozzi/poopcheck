//
//  PoopManager.swift
//  PoopCheck
//
//  Created by Matheus Frozzi Alberton on 22/04/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit
import Parse

class PoopManager: NSObject {
    var objectId: String!
    var user: PFUser!
    var location: PFGeoPoint!
    var createdAt: NSDate!
    var date: String!
    var hour: String!
    
    override init() {
        super.init()
    }

    init(dictionary : PFObject) {
        super.init()

        self.date = formatDate(dictionary.createdAt!, format: "dd/MM/yyyy")
        self.hour = formatDate(dictionary.createdAt!, format: "HH:mm")
    }

    func newPoop(callback: (error: NSError?) -> ()) {
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
            if error == nil {
                var nPoop = PFObject(className:"Poop")
                nPoop["user"] = PFUser.objectWithoutDataWithObjectId("Gpkl45omXx")
                nPoop["location"] = geoPoint

                nPoop.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if (success) {
                        callback(error: nil)
                    } else {
                        callback(error: error)
                    }
                }
            }
        }
    }

    func getPoops(callback: (poopResult: NSArray?, error: NSError?) -> ()) {
        var query = PFQuery(className:"Poop")
        //        query.whereKey("playerName", equalTo:"Sean Plott")
        var poopResultar: NSArray!
        query.findObjectsInBackgroundWithBlock {
            (objects, error) -> Void in
            if error == nil {
                poopResultar = objects!
                callback(poopResult: poopResultar, error: nil)
            } else {
                // Log details of the failure
                println("Error: \(error) \(error!.userInfo!)")
                callback(poopResult: nil, error: error!)
            }
        }
    }
    
    func formatDate(date: NSDate, format: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        
        let myString = dateFormatter.stringFromDate(date)
        
        return myString;
    }
}