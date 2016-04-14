//
//  MDCVGalleryiewController.swift
//  BranchingOut-iOS
//
//  Created by Kevin Manase on 3/30/16.
//  Copyright © 2016 MDC. All rights reserved.
//

import UIKit

private let reuseIdentifier = "GalleryCell"
var imageArray = []

class MDCGalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet var myCollectionView: UICollectionView!
    let originalFrame = CGSize(width: 160, height: 200)
    var biggerFrame = CGSize(width: 300, height: 500)
    var selectedRow = 0
    var popupController:CNPPopupController = CNPPopupController()
    var treeArray: [MDCTree]! = []
    let queryLimit = 10
    var selectedTree: MDCTree!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        setupCollectionView()
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.05 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            self.loadTreeDataForCollectionView(self.myCollectionView)
        })
       
    }
    
    override func viewDidDisappear(animated: Bool) {
        DLImageLoader.sharedInstance().cancelAllOperations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let insets = UIEdgeInsetsMake(20, 20, 10, 20)
        return insets
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return treeArray.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var retval: CGSize = self.view.frame.size
        retval.width = myCollectionView.frame.size.height
        let thumbs = CGSize(width: 160, height: 200)
        return thumbs
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: MDCGalleryCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MDCGalleryCollectionViewCell
        
        let tree = treeArray[indexPath.row] 

        cell.imageName = tree.commonName
        cell.imageURL = tree.imageURL
        cell.updateCell()
        
        return cell
    }
    
    // MARK: Collectionview delegates
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.selectedTree = treeArray[indexPath.row]
        self.performSegueWithIdentifier("showDetail", sender: self.selectedTree)
    }
    
    
    
    // MARK: Shenanigans
    func setupCollectionView() {
        myCollectionView.backgroundColor = UIColor.whiteColor()
        myCollectionView.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    // MARK: Load data from Parse
    func loadTreeDataForCollectionView(collectionView: UICollectionView!) {
        var trees: [MDCTree]! = []
        let query  = PFQuery(className: "trees")
        query.findObjectsInBackgroundWithBlock { (object: [PFObject]?, error: NSError?) -> Void in
            for item: PFObject in object! {
                trees?.append(self.makeTreeObjects(item))
            }
            self.treeArray = trees
            collectionView.reloadData()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let tree = treeArray[indexPath.row] as MDCTree
        DLImageLoader.sharedInstance().cancelOperation(tree.imageURL)
    }
    
    func makeTreeObjects(parseObject: PFObject) -> MDCTree {
        let myTree = MDCTree()
        myTree.commonName = parseObject["common"] as? String
        myTree.scientificName = parseObject["scientific"] as? String
        myTree.treeID = parseObject["treeId"] as? String
        myTree.objectID = parseObject.objectId
        myTree.wikipedia = parseObject["wiki"] as? String
        myTree.imageURL = parseObject["photo"] as? String
        let tempLocation = parseObject["cord"] as? PFGeoPoint
        let latitude: CLLocationDegrees = tempLocation!.latitude
        let longitude: CLLocationDegrees = tempLocation!.longitude
        let aLocation: CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        myTree.location = aLocation
        
        return myTree
    }
    
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
    
    
}
