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
    
    override func init(frame: CGRect) {
        imageView = UIImageView(frame: frame)
        self.contentView.addSubview(imageView)
    }
    
    func updateCell() {
        let sourcePath = NSBundle.mainBundle().resourcePath?.stringByAppendingString("Assets")
        let filename = NSString(format: "%@/%@", sourcePath!,imageName)
        
        let image = UIImage(contentsOfFile: filename as String)
        
    }
    
}

/*
-(void)updateCell {
NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Assets"];
NSString *filename = [NSString stringWithFormat:@"%@/%@", sourcePath, self.imageName];

UIImage *image = [UIImage imageWithContentsOfFile:filename];

[self.imageView setContentMode:UIViewContentModeScaleAspectFit];
[self.imageView setImage:image];
}
*/