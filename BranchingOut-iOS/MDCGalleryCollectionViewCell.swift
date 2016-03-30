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
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView(frame: frame)
        self.contentView.addSubview(imageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell() {
        
        let image = UIImage(named: imageName)
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.image = image
        imageView.clipsToBounds = true
        
        
    }
    
}