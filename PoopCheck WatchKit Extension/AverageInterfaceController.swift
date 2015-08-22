//
//  AverageInterfaceController.swift
//  PoopCheck
//
//  Created by Matheus Frozzi Alberton on 19/05/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import WatchKit
import Foundation
import Parse

class AverageInterfaceController: WKInterfaceController {

    @IBOutlet weak var averageLabel: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
//        var request = ["request": "getAverage"]
//        
//        WKInterfaceController.openParentApplication(request, reply: { (replyFromParent, error) -> Void in
//            if(error != nil) {
//                println("there was an error receiving a reply")
//            } else {
//                let average : String = (replyFromParent["reply"] as? String)!
//                self.averageLabel.setText(average)
//                self.averageLabel.setHidden(false)
//            }
//        })
        var poopClass = PoopManager()
        
        poopClass.getPoops({ (myArray, error) -> () in
            if(error == nil) {
                var sum = 0.0
                sum =  Double(myArray!.count) / Double(self.betweenDays(UserDefaultsManager.getDateRegister!,date2: NSDate()) + 1)

                self.averageLabel.setText(NSString(format: "%.1f", sum) as String)
                self.averageLabel.setHidden(false)
            }
        })

    }

    func betweenDays(date1:NSDate, date2:NSDate) -> Int {
        let startDate:NSDate = date1
        let endDate:NSDate = date2
        
        let cal = NSCalendar.currentCalendar()
        let unit:NSCalendarUnit = .CalendarUnitDay
        let components = cal.components(unit, fromDate: startDate, toDate: endDate, options: nil)
        
        return components.day
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
