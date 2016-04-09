//
//  MDCMapViewController.swift
//  BranchingOut-iOS
//
//  Created by Kevin Manase on 4/7/16.
//  Copyright © 2016 MDC. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MDCMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var mapView: OCMapView!
    let locationManager = CLLocationManager()
    var treeLocations: [PFObject]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        self.mapView.clusterSize = 0.2
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MAR: - Location delefate methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpanMake(0.07, 0.07)) // the smaller the bigger zoom
        self.mapView.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
        self.addTreesNearby(location!)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Errors: " + error.localizedDescription)
    }
    
    func findTreesNearLocation(location: CLLocation, completion:(locations: [PFObject]) -> Void) {
        let geopoint = PFGeoPoint(location: location)
        var objectLocations: [PFObject]! = []
        PFQuery(className: "trees").whereKey("cord", nearGeoPoint: geopoint, withinMiles: 1.0)
            .findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
                for location: PFObject in results! {
                objectLocations.append(location)
                }
            completion(locations: objectLocations)
        }
    }
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        self.mapView.doClustering()
        self.updateOverlays()
    }
    
    func mapView(mapView: MKMapView, didAddAnnotationViews views: [MKAnnotationView]) {
        self.updateOverlays()
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView: MKAnnotationView!
        
        if (annotation.isKindOfClass(OCMapViewSampleHelpAnnotation)) {
            let singleAnnotation: OCMapViewSampleHelpAnnotation = annotation as! OCMapViewSampleHelpAnnotation
            annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("singleAnnotationView")
            if ((annotationView == nil)) {
                annotationView = MKAnnotationView(annotation: singleAnnotation, reuseIdentifier: "singleAnnotationView")
                annotationView.canShowCallout = true
                annotationView.centerOffset = CGPointMake(0, 0)
            }
            singleAnnotation.title = singleAnnotation.groupTag
            annotationView.image = UIImage(named: "tree_pin")
        }
        
        return annotationView
    }
    
    func addTreesNearby(treeLocation: CLLocation) {
        let annotationsToAdd: NSMutableSet = NSMutableSet()
        findTreesNearLocation(treeLocation) { (locations) -> Void in
            for treeObject: PFObject in locations {
                let descLocation = treeObject["cord"] as! PFGeoPoint
                let latitude: CLLocationDegrees = descLocation.latitude
                let longitude: CLLocationDegrees = descLocation.longitude
                let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

                let treeName = treeObject["common"] as! String
                let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                let annotation: OCMapViewSampleHelpAnnotation = OCMapViewSampleHelpAnnotation(coordinate: center)
                annotationsToAdd.addObject(annotation)
                annotation.groupTag = treeName
            }
            
            self.mapView.addAnnotations(annotationsToAdd.allObjects as! [MKAnnotation])
        }
        
    }
    
    // I get errors here
    
    func updateOverlays() {
        self.mapView.removeOverlays(self.mapView.overlays)
        let annotationArray : [MKAnnotation]! = self.mapView.displayedAnnotations as! [MKAnnotation]!
        
        for annotation: MKAnnotation in annotationArray {
            if (annotation.isKindOfClass(MKUserLocation)){
                //this is user location pin which is not a OCMapViewSampleHelpAnnotation
                
            }
            
            if (annotation.isKindOfClass(OCMapViewSampleHelpAnnotation)) {
                // static circle size of cluster
                var clusterRadius: CLLocationDistance = self.mapView.region.span.longitudeDelta * self.mapView.clusterSize * 111000 / 2.0
                clusterRadius = clusterRadius * cos(annotation.coordinate.latitude * M_PI / 180.0)
                
                let circle: MKCircle = MKCircle(centerCoordinate: annotation.coordinate, radius: clusterRadius)
                circle.title = "background"
                self.mapView.addOverlay(circle)
                
                let circleLine: MKCircle = MKCircle(centerCoordinate: annotation.coordinate, radius: clusterRadius)
                circleLine.title = "line"
                self.mapView.addOverlay(circleLine)
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
