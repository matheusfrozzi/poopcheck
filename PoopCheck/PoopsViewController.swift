//
//  PoopsViewController.swift
//  PoopCheck
//
//  Created by Matheus Frozzi Alberton on 23/04/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit
import Parse

class PoopsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var poops = []

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateTableView() {
        self.tableView.reloadData()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poops.count
    }
    func tableView(tableView: UITableView, numberOfSectionsInTableView section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Poops") as! PoopTableViewCell

        var poopClass = PoopManager(dictionary: self.poops[indexPath.row] as! PFObject)
        cell.date.text = poopClass.date
        cell.hour.text = poopClass.hour

        return cell
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    func loadData() {
        var poopClass = PoopManager()

        poopClass.getPoops({ (myArray, error) -> () in
            if(error == nil) {
                self.poops = myArray!
                self.updateTableView()
            }
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
