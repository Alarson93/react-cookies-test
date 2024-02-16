//
//  ViewController.swift
//  BasicWebView
//
//  Created by Alex Larson on 2/15/24.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let link = URL(string:"http://192.168.1.199:3000")!
        let request = URLRequest(url: link)
        webView.load(request)
        webView.isInspectable = true
    }


}

