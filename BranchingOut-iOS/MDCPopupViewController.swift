//
//  MDCPopupViewController.swift
//  BranchingOut-iOS
//
//  Created by Kevin Manase on 3/31/16.
//  Copyright © 2016 MDC. All rights reserved.
//

import UIKit

class MDCPopupViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    var imagePath: String!
//
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        
//    }

//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Hello"
        self.descriptionLabel.text = "This is pretty stupid"
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}
