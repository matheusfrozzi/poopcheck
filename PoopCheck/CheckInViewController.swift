//
//  CheckInViewController.swift
//  PoopCheck
//
//  Created by Matheus Frozzi Alberton on 22/04/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit
import MapKit
import Parse

class CheckInViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 1000

    @IBOutlet weak var poopButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        poopButton.layer.cornerRadius = poopButton.frame.size.width / 2;
        poopButton.clipsToBounds = true;

        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
            if error == nil {
                let location = CLLocationCoordinate2D(
                    latitude: geoPoint!.latitude,
                    longitude: geoPoint!.longitude
                )

                self.centerMapOnLocation(location)

                let annotation = MKPointAnnotation()
                annotation.coordinate = location
                annotation.title = "I'm pooping here"
                annotation.subtitle = "Bathroom"

                self.mapView.addAnnotation(annotation)
            }
        }
        
        if UserDefaultsManager.getDateRegister == nil {
            println("welcome to the first time")
            UserDefaultsManager.getDateRegister = NSDate()
        }

//        var user = UserManager()
//        user.getDateRegister()
    }

    override func viewDidAppear(animated: Bool) {
//        var currentUser = PFUser.currentUser()
//
//        if currentUser == nil {
//            self.performSegueWithIdentifier("loginModal", sender: self)
//            let user = UserManager()
//            user.register()
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func savePoop(sender: AnyObject) {
//        var currentUser = PFUser.currentUser()
//
//        if currentUser == nil {
//            //            self.performSegueWithIdentifier("loginModal", sender: self)
//            let user = UserManager()
//            user.register()
//        }

        var poopClass = PoopManager()
        poopClass.newPoop("123") { (error) -> () in
            if(error == nil) {
                println("Pooped with success")
            } else {
                println("whats")
            }
        }
    }
    
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let span = MKCoordinateSpanMake(0.001, 0.001)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: true)
    }
    
    @IBAction func backLogout(sender: UIStoryboardSegue) {
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
extension CheckInViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if let annotation = annotation as? PinManager {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                //                view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
            }
            
            view.image = UIImage(named:"toilet-icon")
            
            //            view.pinColor = annotation.pinColor()
            
            return view
        }
        return nil
    }
}
