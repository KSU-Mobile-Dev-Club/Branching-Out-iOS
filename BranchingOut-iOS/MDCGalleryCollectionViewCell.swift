//
//  MDCGalleryCollectionViewCell.swift
//  BranchingOut-iOS
//
//  Created by Kevin Manase on 3/10/16.
//  Copyright © 2016 MDC. All rights reserved.
//

import UIKit

class MDCGalleryCollectionViewCell: UICollectionViewCell {
    var imageName: String!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageLabel: UILabel!
    var imageURL: String!
    
    func updateCell() {
        
        imageLabel.text = imageName
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        DLImageLoader.sharedInstance().imageFromUrl(imageURL) { (error, image) -> () in
            if (error == nil) {
                // if we have no any errors
                self.imageView?.image = image
            } else {
                // if we got an error when load an image
            }
        }
    }
    
}
