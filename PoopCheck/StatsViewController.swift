//
//  StatsViewController.swift
//  PoopCheck
//
//  Created by Matheus Frozzi Alberton on 06/05/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit
import Parse

class StatsViewController: UIViewController {

    @IBOutlet weak var average: UILabel!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var maxLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(animated: Bool) {
        loadAverage()
        graphDisplay()
    }

    func graphDisplay() {
        self.loadGraphPoints()

        let cal = NSCalendar.currentCalendar()
        var date = cal.startOfDayForDate(NSDate())
        
        var days = [Int]()
        
        for i in reverse(1...7) {
            let day = cal.component(.CalendarUnitDay, fromDate: date)
            days.append(day)
            
            date = cal.dateByAddingUnit(.CalendarUnitDay, value: -1, toDate: date, options: nil)!
            
            if let labelView = graphView.viewWithTag(i) as? UILabel {
                labelView.text = NSString(format: "%d", day) as String
            }
        }
    }

    func loadAverage() {
        var poopClass = PoopManager()
        
        poopClass.getPoops({ (myArray, error) -> () in
            println(myArray!.count)
            if(error == nil && myArray!.count != 0) {
                var sum = 0.0
                sum =  Double(myArray!.count) / Double(self.betweenDays(UserDefaultsManager.getDateRegister!,date2: NSDate()) + 1)
                
                let nf = NSNumberFormatter()
                nf.numberStyle = .DecimalStyle
 
                self.average.text = NSString(format: "%.1f", sum) as String 
                self.average.hidden = false
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
    
    func loadGraphPoints() {
        var poopClass = PoopManager()

        poopClass.getPoopsForGraph({ (poopPoints, error) -> () in
            if(poopPoints!.count == 0) {
                println("CERTA RESPOSTA")
            } else {
                self.graphView.graphPoints = poopPoints!
                self.maxLabel.text = "\(maxElement(self.graphView.graphPoints))"
                self.graphView.setNeedsDisplay()
                self.graphView.hidden = false
            }
        })
    }
}
