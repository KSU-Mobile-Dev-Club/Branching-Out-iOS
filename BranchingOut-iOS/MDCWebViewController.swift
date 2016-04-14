//
//  MDCWebViewController.swift
//  BranchingOut-iOS
//
//  Created by Kevin Manase on 4/13/16.
//  Copyright © 2016 MDC. All rights reserved.
//

import UIKit

class MDCWebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet var webView: UIWebView!
    var wikiURL: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        let address = NSURL(string: wikiURL)
        let requestObject = NSURLRequest(URL: address!)
        webView.loadRequest(requestObject)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissViewButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
