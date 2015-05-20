//
//  AverageInterfaceController.swift
//  PoopCheck
//
//  Created by Matheus Frozzi Alberton on 19/05/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import WatchKit
import Foundation


class AverageInterfaceController: WKInterfaceController {

    @IBOutlet weak var averageLabel: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        var request = ["request": "getAverage"]
        
        WKInterfaceController.openParentApplication(request, reply: { (replyFromParent, error) -> Void in
            if(error != nil) {
                println("there was an error receiving a reply")
            } else {
                let average : String = (replyFromParent["reply"] as? String)!
                self.averageLabel.setText(average)
                self.averageLabel.setHidden(false)
            }
        })
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
