//
//  InterfaceController.swift
//  PoopCheck WatchKit Extension
//
//  Created by Matheus Frozzi Alberton on 14/05/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import WatchKit
import Foundation
import Parse

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var poopButton: WKInterfaceButton!
    @IBOutlet weak var textLabel: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        Parse.enableLocalDatastore()

        Parse.enableDataSharingWithApplicationGroupIdentifier("group.com.matheus.Parse.PoopCheck",
            containingApplication: "com.matheus.PoopCheck");
        
        Parse.setApplicationId("2AUvDjhYywJ3gdwpxUn1F1G9JLJsJcEd73GaXeh1",
            clientKey: "vLg9CIGiCIwXjXkEX9MppE7FDKTD6NBXduXNrwXh")

        loadData()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func makePoop() {
//        var request = ["request": "newPoop"]
//        
//        WKInterfaceController.openParentApplication(request, reply: { (replyFromParent, error) -> Void in
//            if(error != nil) {
//                println("there was an error receiving a reply")
//            } else {
//                self.textLabel.setText("You pooped today")
//            }
//        })
        let poopClass = PoopManager()
        
        poopClass.newPoop { (error) -> () in
            if(error == nil) {
                self.loadData()
            }
        }
    }

    func loadData() {
        let poopClass = PoopManager()
        
        poopClass.getPoopsForDay(NSDate(), callback: { (countsPoop, error) -> () in
            if(error == nil) {
                self.textLabel.setText("You pooped \(countsPoop!) times today")
            } else {
                self.textLabel.setText("Something is wrong, try again")
            }
        })
    }
}
