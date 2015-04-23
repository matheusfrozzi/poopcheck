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
    var createdAt: String!
    
    
    func newPoop() {
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
            if error == nil {
                println(geoPoint?.latitude)
            }
        }
    }
}