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
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var retval: CGSize = self.view.frame.size
        retval.width = myCollectionView.frame.size.height
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
        self.myCollectionView.registerClass(MDCGalleryCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        myCollectionView.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    
    
    
    // MARK: Prep gallery
    func loadGallery() {
        imageArray = ["img1.jpg","img2.jpg","img3.jpg","img4.jpg","img1.jpg","img2.jpg","img3.jpg","img4.jpg"]
    }



}
