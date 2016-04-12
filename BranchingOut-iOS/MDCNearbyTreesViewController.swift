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
        // TODO: add link to a TreeDetailViewController
    }
    
    // Creates each cell for the TreesTableView
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // dequeue prototype cell
        let treeCell = tableView.dequeueReusableCellWithIdentifier("nearbyTreeCell")!
        
        // set the tree title
        let tree =  treeArray[indexPath.row] as MDCTree
        treeCell.textLabel?.text = tree.commonName
        
        // set the tree image
        //let treeImage = UIImage(named: "tempPicture")
        let treeImage = tree.image
        treeCell.imageView?.image = treeImage
        
        // set the tree distance
        let nearbyTreeDistance = 1.5
        treeCell.detailTextLabel?.text = "\(nearbyTreeDistance) miles away"
        
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
        //myTree.image = UIImage(named: "img1.jpg")
        
        // set the picture
        let userPicture = parseObject["photo"] as? String
        
        let url = NSURL(string: userPicture!)
        let data = NSData(contentsOfURL:url!)
        if (data != nil) {
            myTree.image = UIImage(data:data!)
        }
        
        return myTree
    }
    
    // number of rows for the tableView, should be specified by the number of trees to display in the K-State area
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return treeArray.count
    }
}
