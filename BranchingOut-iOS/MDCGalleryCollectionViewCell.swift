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

    
    func updateCell() {
        
        var image = UIImage(named: imageName)
        let imageData = UIImageJPEGRepresentation(image!, 0.1)
        image = UIImage(data: imageData!)
        imageLabel.text = imageName
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.image = image
        imageView.clipsToBounds = true
    }
    
    func parseTest() {
        imageLabel.text = imageName
    }
}
