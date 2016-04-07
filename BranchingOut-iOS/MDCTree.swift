//
//  MDCTree.swift
//  BranchingOut-iOS
//
//  Created by Kevin Manase on 4/6/16.
//  Copyright © 2016 MDC. All rights reserved.
//

import UIKit

class MDCTree {

    var objectID: String?
    var treeID: String?
    var commonName: String?
    var scientificName: String?
    var coordinationPoint: String?
    var wikipedia: String?
    
    init () {
        
    }
    
    init(name: String!) {
        self.commonName = name
    }

//    func loadTrees() -> [PFObject] {
//        var trees: [PFObject]?
//        let query  = PFQuery(className: "trees")
//        do {
//            trees = try query.findObjects()
//        } catch {
//            trees = []
//        }
//        
//       return trees!
//    }
    
    
}
