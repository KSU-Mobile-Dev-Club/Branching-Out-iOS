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
    
    let tempArray: [String] = ["John Cena", "John Cena", "John Cena", "John Cena", "John Cena", "John Cena", "John Cena", "John Cena", "John Cena"]
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // TODO: add link to a TreeDetailViewController
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let treeCell = tableView.dequeueReusableCellWithIdentifier("nearbyTreeCell")!
        let treeText =  tempArray[indexPath.row]
        treeCell.textLabel?.text = treeText
        return treeCell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempArray.count
    }
}
