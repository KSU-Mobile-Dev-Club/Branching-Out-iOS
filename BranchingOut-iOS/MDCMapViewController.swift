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
    var myLocation: CLLocation!
    
    var location: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
        
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        self.mapView.clusteringEnabled = false
        
        myLocation = location
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MAR: - Location delegate methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = myLocation != nil ? myLocation : locations.last
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
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView: MKAnnotationView!
        
        // If not then get a group of trees
        
        if (annotation.isKindOfClass(OCSingleAnnotation)) {
            let singleAnnotation: OCSingleAnnotation = annotation as! OCSingleAnnotation
            annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("singleAnnotationView")
            if ((annotationView == nil)) {
                annotationView = MKAnnotationView(annotation: singleAnnotation, reuseIdentifier: "singleAnnotationView")
                annotationView.canShowCallout = true
                annotationView.centerOffset = CGPointMake(0, 0)
            }
            singleAnnotation.title = singleAnnotation.groupTag
            annotationView.image = UIImage(named: "tree_pin")
        } else if (annotation.isKindOfClass(OCAnnotation)){
            
            let clusterAnnotation: OCAnnotation = annotation as! OCAnnotation
            annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("ClusterView")
            if ((annotationView == nil)) {
                annotationView = MKAnnotationView(annotation: clusterAnnotation, reuseIdentifier: "ClusterView")
                annotationView.canShowCallout = true
                annotationView.centerOffset = CGPointMake(0, -20)
            }
            clusterAnnotation.title = "Tree Groups"
            clusterAnnotation.subtitle = "Contains \(clusterAnnotation.annotationsInCluster().count) trees"
            annotationView.image = UIImage(named: "forest")
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
                let scientific = treeObject["scientific"] as! String
                let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                let annotation: OCSingleAnnotation = OCSingleAnnotation(coordinate: center)
                annotationsToAdd.addObject(annotation)
                annotation.groupTag = treeName
                annotation.title = treeName
                annotation.subtitle = scientific
            }
            
            self.mapView.addAnnotations(annotationsToAdd.allObjects as! [OCSingleAnnotation])
        }
        
    }

}
