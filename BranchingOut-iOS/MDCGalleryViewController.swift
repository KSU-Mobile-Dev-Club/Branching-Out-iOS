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

class MDCVGalleryiewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet var myCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
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
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        //        var retval: CGSize = self.view.frame.size
        //        retval.height = collectionView.frame.size.height
        var retval = CGSize(width: 200.0, height: 200.0)
        return retval
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: MDCGalleryCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MDCGalleryCollectionViewCell
        
        // Configure the cell
        cell.imageName = imageArray[indexPath.row] as! String
        cell.updateCell()
        
        return cell
    }
    
    // MARK: Shenanigans
    func setupCollectionView() {
        self.collectionView!.registerClass(MDCGalleryCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Vertical
        flowLayout.estimatedItemSize = CGSize(width: 200.0, height: 200.0)
        flowLayout.minimumInteritemSpacing = 10.0
        flowLayout.minimumLineSpacing = 10.0
        self.collectionView!.pagingEnabled = true
        self.collectionView!.collectionViewLayout = flowLayout
    }
    
    
    
    // MARK: Prep gallery
    func loadGallery() {
        imageArray = ["img1.jpg","img2.jpg","img3.jpg","img4.jpg"]
    }



}
