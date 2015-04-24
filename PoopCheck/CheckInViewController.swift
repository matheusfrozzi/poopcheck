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

    override func viewDidLoad() {
        super.viewDidLoad()

        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
            if error == nil {
                let location = CLLocationCoordinate2D(
                    latitude: geoPoint!.latitude,
                    longitude: geoPoint!.longitude
                )

                let span = MKCoordinateSpanMake(0.01, 0.01)
                let region = MKCoordinateRegion(center: location, span: span)
                self.mapView.setRegion(region, animated: true)

                let annotation = MKPointAnnotation()
                annotation.coordinate = location
                annotation.title = "I'm pooping here"
                annotation.subtitle = "Bathroom"

                self.mapView.addAnnotation(annotation)
            }
        }
    }

    func mapView(mapView: MKMapView!,
        viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
            
            if annotation is MKUserLocation {
                //return nil so map view draws "blue dot" for standard user location
                return nil
            }
            
            let reuseId = "pin"
            
            var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//                pinView!.canShowCallout = true
//                pinView!.animatesDrop = true
//                pinView!.pinColor = .Purple
                var image = UIImage(named:"toilet-icon")
                pinView!.image = image
            }
            else {
                pinView!.annotation = annotation
            }
            
            return pinView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    @IBAction func savePoop(sender: AnyObject) {
        var poopClass = PoopManager()
        poopClass.newPoop { (error) -> () in
            if(error == nil) {
                println("Pooped with success")
            }
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
extension CheckInViewController: MKMapViewDelegate {
}
