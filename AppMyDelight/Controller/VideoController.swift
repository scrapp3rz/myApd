//
//  VideoController.swift
//  AppMyDelight
//
//  Created by vincent portier on 12/05/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit
import WebKit


class VideoController: UIViewController {

    
    @IBOutlet weak var WebView: WKWebView!
    
    var ytVideos: YtVideo?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if ytVideos != nil {
            chargerVideo(ytVideo: ytVideos!)
        }
    }

    func chargerVideo(ytVideo: YtVideo) {
        if let url = URL(string: (ytVideos?.videoUrl)!) {
            let requete = URLRequest(url: url)
            WebView.load(requete)
            
        }
    }


}
