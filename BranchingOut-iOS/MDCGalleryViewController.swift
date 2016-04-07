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
    var treeArray: [MDCTree]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        setupCollectionView()
        
//        // Load the images
//        loadGallery()
        
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }
        
        self.treeArray = loadTreeDataForCollectionView(myCollectionView)
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
        
        // Configure the cell
//        cell.imageName = imageArray[indexPath.row] as! String
//        cell.updateCell()
//        
        // Parse
        cell.imageName = treeArray[indexPath.row].commonName
        cell.parseTest()
        
        return cell
    }
    
    // MARK: Collectionview delegates
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.showPopupWithStyle(CNPPopupStyle.Centered, indexPath: indexPath)
    }
    
    
    
    // MARK: Shenanigans
    func setupCollectionView() {
        myCollectionView.backgroundColor = UIColor.whiteColor()
        myCollectionView.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    
    
    
    // MARK: Prep gallery
    func loadGallery() {
        imageArray = ["img1.jpg","img2.jpg","img3.jpg", "img4.jpg", "img2.jpg","img3.jpg", "img4.jpg", "img1.jpg"]
                
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.destinationViewController.isKindOfClass(MDCPopupViewController)) {
            let vc = segue.destinationViewController as! MDCPopupViewController
            let path = imageArray[selectedRow] as? String
            vc.imagePath = path
        }
    }
    
    func showPopupWithStyle(popupStyle: CNPPopupStyle, indexPath: NSIndexPath) {
        
        let imagePath = imageArray[indexPath.row] as! String
        let imageView = UIImageView.init(image: UIImage.init(named: imagePath))
        imageView.frame = CGRectMake(0, 0, 200, 300)
        imageView.center = self.view.center

        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        paragraphStyle.alignment = NSTextAlignment.Center
        
        let title = NSAttributedString(string: imagePath, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(24), NSParagraphStyleAttributeName: paragraphStyle])
        
        let button = CNPPopupButton.init(frame: CGRectMake(0, 0, 200, 60))
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(18)
        button.setTitle("Dismiss", forState: UIControlState.Normal)
        
        button.backgroundColor = UIColor.init(colorLiteralRed: 0.46, green: 0.8, blue: 1.0, alpha: 1.0)
        
        button.layer.cornerRadius = 4;
        button.selectionHandler = { (CNPPopupButton button) -> Void in
            self.popupController.dismissPopupControllerAnimated(true)
        }
        
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0;
        titleLabel.attributedText = title
        

        self.popupController = CNPPopupController(contents:[titleLabel, imageView, button])
        self.popupController.theme = CNPPopupTheme.defaultTheme()
        self.popupController.theme.popupStyle = popupStyle
        self.popupController.presentPopupControllerAnimated(true)
    }
    
    // MARK: Load data from Parse
    func loadTreeDataForCollectionView(collectionView: UICollectionView!) -> [MDCTree] {
        var trees: [MDCTree]! = []
        let query  = PFQuery(className: "trees")
        query.limit = 5
        query.findObjectsInBackgroundWithBlock { (object: [PFObject]?, error: NSError?) -> Void in
            for item: PFObject in object! {
                trees?.append(self.makeTreeObjects(item))
            }
            collectionView.reloadData()
        }
        
        return trees
    }
    
    func makeTreeObjects(parseObject: PFObject) -> MDCTree {
        let myTree = MDCTree()
        myTree.commonName = parseObject["common"] as? String
        myTree.scientificName = parseObject["scientificName"] as? String
        myTree.treeID = parseObject["treeId"] as? String
        myTree.objectID = parseObject["objectId"] as? String
        
        return myTree
    }



}
