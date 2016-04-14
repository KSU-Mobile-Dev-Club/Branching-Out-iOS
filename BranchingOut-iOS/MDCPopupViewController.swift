//
//  MDCPopupViewController.swift
//  BranchingOut-iOS
//
//  Created by Kevin Manase on 3/31/16.
//  Copyright © 2016 MDC. All rights reserved.
//

import UIKit

class MDCPopupViewController: UIViewController, UITabBarControllerDelegate {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    var imagePath: String!
    var treeObject: MDCTree!
    @IBOutlet var scientificName: UILabel!
    static var location: CLLocation!
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
        
        self.descriptionLabel.text = treeObject.commonName
        self.scientificName.text = treeObject.scientificName
        DLImageLoader.sharedInstance().imageFromUrl(treeObject.imageURL, imageView: imageView)
        
        self.tabBarController?.delegate = self
                
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func showOnMapButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        let tabBar: UITabBarController = UIApplication.sharedApplication().keyWindow?.rootViewController as! UITabBarController
        tabBar.selectedIndex = 3
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.destinationViewController.isKindOfClass(MDCWebViewController)) {
            let vc: MDCWebViewController = segue.destinationViewController as! MDCWebViewController
            vc.wikiURL = treeObject.wikipedia
        }
    }
    

}
