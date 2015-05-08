//
//  UserDefaultsManager.swift
//  PoopCheck
//
//  Created by Matheus Frozzi Alberton on 06/05/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit

private let dateRegister = "Date"

class UserDefaultsManager: NSObject {
    class var getDateRegister: NSDate? {
        get {
            return NSUserDefaults.standardUserDefaults().valueForKey(dateRegister) as? NSDate
        }
        set(newProperty) {
            NSUserDefaults.standardUserDefaults().setValue(newProperty, forKey: dateRegister)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}