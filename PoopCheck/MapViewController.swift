//
//  MapViewController.swift
//  PoopCheck
//
//  Created by Matheus Frozzi Alberton on 27/04/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit
import MapKit
import Parse

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var poops = []
    var anotations = [PinManager]()

    override func viewDidLoad() {
        super.viewDidLoad()

        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
            if error == nil {
                let location = CLLocationCoordinate2D(
                    latitude: geoPoint!.latitude,
                    longitude: geoPoint!.longitude
                )

                self.centerMapOnLocation(location)
                self.loadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let span = MKCoordinateSpanMake(0.3, 0.3)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: false)
    }

    func loadData() {
        var currentUser = PFUser.currentUser()
        var poopClass = PoopManager()
        
        poopClass.getPoops(currentUser!.objectId!, callback: { (myArray, error) -> () in
            if(error == nil) {
                self.poops = myArray!
                self.pinObjects()

                self.mapView.addAnnotations(self.anotations)
            }
        })
    }

    func pinObjects() {
        for(var i = 0; i < poops.count; i++) {
            var poopClass = PoopManager(dictionary: self.poops[i] as! PFObject)
            
            let location = CLLocationCoordinate2D(
                latitude: poopClass.location.latitude,
                longitude: poopClass.location.longitude
            )

            let pin = PinManager(title: "Poop", locationName: "Poop", discipline: "Bathroom", coordinate: location)
            anotations.append(pin)
        }
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
extension MapViewController: MKMapViewDelegate {
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
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
//        let location = view.annotation as! PinManager
//        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
//        location.mapItem().openInMapsWithLaunchOptions(launchOptions)
    }
}