//
//  PostViewController.swift
//  The Mac Weekly
//
//  Created by Library Checkout User on 2/5/18.
//  Copyright © 2018 The Mac Weekly. All rights reserved.
//

import UIKit
import WebKit

class PostViewController: UIViewController, WKNavigationDelegate {
    
    var post: Post?
    
    @IBOutlet weak var postWebView: WKWebView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postAuthorLabel: UILabel!

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.frame.size.height = postWebView.scrollView.contentSize.height
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let post = post else {
            fatalError("Requires Post")
        }
        postTitleLabel.text = post.title
        postAuthorLabel.text = post.author != nil ? "By \(post.author!.name)" : nil
        postWebView.loadHTMLString(post.body, baseURL: nil)
        postWebView.scrollView.isScrollEnabled = false
        postWebView.navigationDelegate = self
//        postWebView.scrollView.observe
//        let constraint = NSLayoutConstraint.init(item: postWebView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: postWebView.scrollView.contentSize.height)
        //postWebView.superview?.addConstraint(constraint)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Actions
    @IBAction func showFromPostTable(sender: UIStoryboardSegue) {
        
    }

}
