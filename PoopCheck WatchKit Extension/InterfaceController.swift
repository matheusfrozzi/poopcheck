//
//  InterfaceController.swift
//  PoopCheck WatchKit Extension
//
//  Created by Matheus Frozzi Alberton on 14/05/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var poopButton: WKInterfaceButton!
    @IBOutlet weak var textLabel: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
//        poopButton.
//        poopButton.layer.cornerRadius = poopButton.frame.size.width / 2;
//        poopButton.clipsToBounds = true;
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
        var request = ["request": "newPoop"]
        
        WKInterfaceController.openParentApplication(request, reply: { (replyFromParent, error) -> Void in
            if(error != nil) {
                println("there was an error receiving a reply")
            } else {
                self.textLabel.setText("You pooped today")
            }
        })
    }
}
