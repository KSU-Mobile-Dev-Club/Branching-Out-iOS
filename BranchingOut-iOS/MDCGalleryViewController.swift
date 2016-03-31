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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        setupCollectionView()
        
        // Load the images
        loadGallery()
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
        return imageArray.count
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
        cell.imageName = imageArray[indexPath.row] as! String
        cell.updateCell()
        
        return cell
    }
    
    // MARK: Collectionview delegates
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        selectedRow = indexPath.row
//        let dest = self.storyboard?.instantiateViewControllerWithIdentifier("popupVC") as! MDCPopupViewController
//        dest.imagePath = imageArray[selectedRow] as! String
        let popup: STPopupController = STPopupController.init(rootViewController: MDCPopupViewController())
        popup.containerView.layer.cornerRadius = 5
        popup.presentInViewController(self)

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



}
