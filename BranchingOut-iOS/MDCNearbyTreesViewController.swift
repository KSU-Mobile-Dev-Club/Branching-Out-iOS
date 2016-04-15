//
//  MDCNearbyTreesViewController.swift
//  BranchingOut-iOS
//
//  Created by Reagan Wood on 3/10/16.
//  Copyright © 2016 MDC. All rights reserved.
//

import Foundation
import UIKit

class MDCNearbyTreesViewController: UITableViewController{
    
    var treeArray: [MDCTree]!  = []
    var selectedTree: MDCTree!
    var currentLocation: PFGeoPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTreeDataForTableView(self.tableView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Finish when parse server is available
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.selectedTree = treeArray[indexPath.row]
        self.performSegueWithIdentifier("showDetail", sender: self.selectedTree)
        
    }
    
    // provide info necessary for segue to MDCPopupViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (sender?.isKindOfClass(MDCTree) == true) {
            let vc: MDCPopupViewController = segue.destinationViewController as! MDCPopupViewController
            vc.treeObject = selectedTree
        } else if (sender?.isKindOfClass(MDCPopupViewController) == true) {
            // ASHLEY
            let vc = segue.destinationViewController as! MDCMapViewController
            vc.myLocation = selectedTree.location
        }
    }
    
    // Creates each cell for the TreesTableView
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // dequeue prototype cell
        let treeCell = tableView.dequeueReusableCellWithIdentifier("nearbyTreeCell")!
        
        // set the tree title
        let tree =  treeArray[indexPath.row] as MDCTree
        treeCell.textLabel?.text = tree.commonName
        
        // set the tree image
        let treeImage = UIImage(named: "tempPicture")
//        let treeImage = tree.image
        treeCell.imageView?.image = treeImage
        treeCell.imageView?.contentMode = .ScaleAspectFill
        
        
        // set the tree distance
        let nearbyTreeDistance = 1.5
        treeCell.detailTextLabel?.text = "\(nearbyTreeDistance) miles away"
        
   //     DLImageLoader.sharedInstance().imageFromUrl(tree.imageURL, imageView: treeCell.imageView)
        
        DLImageLoader.sharedInstance().imageFromUrl(tree.imageURL) { (error, image) -> () in
            if (error == nil) {
                // if we have no any errors
                treeCell.imageView?.image = image
            } else {
                // if we got an error when load an image
            }
        }
        
//        let treeCell: NearbyTreesTableViewCell = tableView.dequeueReusableCellWithIdentifier("MDCnearbyTreeCell")! as! NearbyTreesTableViewCell
//        treeCell.treeImage?.text = "This tree is located on the west side of campus....."
//        treeCell.treeDescriptionLabel?.image = UIImage(named: "tempPicture")
//        
//        treeCell.treeDistanceLabel?.text = "0.0 miles away"
//        treeCell.treeTitleLabel?.text = "Nearby Plants"
        return treeCell
    }
    
    func loadTreeDataForTableView(atableView: UITableView!) {
        var trees: [MDCTree]! = []
        let query  = PFQuery(className: "trees")
        var myLocation: PFGeoPoint?
        PFGeoPoint.geoPointForCurrentLocationInBackground { (location: PFGeoPoint?, erro: NSError?) in
            myLocation = location
        }
        
        query.whereKey("cord", nearGeoPoint: myLocation!, withinMiles: 2)
        query.orderByAscending("cord")
        query.findObjectsInBackgroundWithBlock { (object: [PFObject]?, error: NSError?) -> Void in
            for item: PFObject in object! {
                trees?.append(self.makeTreeObjects(item))
            }
            self.treeArray = trees
            atableView.reloadData()
        }
    }
    
    func makeTreeObjects(parseObject: PFObject) -> MDCTree {
        let myTree = MDCTree()
        myTree.commonName = parseObject["common"] as? String
        myTree.scientificName = parseObject["scientific"] as? String
        myTree.treeID = parseObject["treeId"] as? String
        myTree.objectID = parseObject.objectId
        myTree.wikipedia = parseObject["wiki"] as? String
        myTree.imageURL = parseObject["photo"] as? String
        return myTree
    }
    
    // number of rows for the tableView, should be specified by the number of trees to display in the K-State area
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return treeArray.count
    }
}
