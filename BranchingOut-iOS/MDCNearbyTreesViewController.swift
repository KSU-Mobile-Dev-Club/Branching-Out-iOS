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
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Temporary array, delete when titles are available
    let tempArray: [String] = ["John Cena", "John Cena", "John Cena", "John Cena", "John Cena", "John Cena", "John Cena", "John Cena", "John Cena"]
    
    // Finish when parse server is available
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // TODO: add link to a TreeDetailViewController
    }
    
    // Creates each cell for the TreesTableView
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // dequeue prototype cell
        let treeCell = tableView.dequeueReusableCellWithIdentifier("nearbyTreeCell")!
        
        // set the tree title
        let treeTitle =  tempArray[indexPath.row]
        treeCell.textLabel?.text = treeTitle
        
        // set the tree image
        let treeImage = UIImage(named: "tempPicture")
        treeCell.imageView?.image = treeImage
        
        // set the tree distance
        let nearbyTreeDistance = 5.5
        treeCell.detailTextLabel?.text = "\(nearbyTreeDistance) miles away"
        
//        let treeCell: NearbyTreesTableViewCell = tableView.dequeueReusableCellWithIdentifier("MDCnearbyTreeCell")! as! NearbyTreesTableViewCell
//        treeCell.treeImage?.text = "This tree is located on the west side of campus....."
//        treeCell.treeDescriptionLabel?.image = UIImage(named: "tempPicture")
//        
//        treeCell.treeDistanceLabel?.text = "0.0 miles away"
//        treeCell.treeTitleLabel?.text = "Nearby Plants"
        return treeCell
    }
    
    // number of rows for the tableView, should be specified by the number of trees to display in the K-State area
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempArray.count
    }
}
