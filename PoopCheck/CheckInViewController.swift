//
//  CheckInViewController.swift
//  PoopCheck
//
//  Created by Matheus Frozzi Alberton on 22/04/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit
import Parse

class CheckInViewController: UIViewController {
    @IBOutlet weak var poopButton: UIButton!
    @IBOutlet weak var poopToday: UILabel!
    @IBOutlet weak var didPoop: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        poopButton.layer.cornerRadius = poopButton.frame.size.width / 2;
        poopButton.clipsToBounds = true;

        if UserDefaultsManager.getDateRegister == nil {
            UserDefaultsManager.getDateRegister = NSDate()
        }
        
        self.loadPoops()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func savePoop(sender: AnyObject) {
        var poopClass = PoopManager()

        poopClass.newPoop() { (error) -> () in
            if(error == nil) {
                self.didPoop.hidden = false
                var timer = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
                self.loadPoops()
            } else {
                self.poopToday.text = "Something is wrong, try again"
            }
        }
    }

    func update() {
        self.didPoop.hidden = true
    }

    func loadPoops() {
        let poopClass = PoopManager()
        
        poopClass.getPoopsForDay(NSDate(), callback: { (countsPoop, error) -> () in
            if(error == nil) {
                var string: String?
                if countsPoop == 1 {
                    string = NSLocalizedString("PoopCount", comment: "") + String(countsPoop!) + NSLocalizedString("Time", comment: "")
                } else {
                    string = NSLocalizedString("PoopCount", comment: "") + String(countsPoop!) + NSLocalizedString("Times", comment: "")
                }
                self.poopToday.text = string
            } else {
                self.poopToday.text = "Something is wrong, try again"
            }
        })
    }
}