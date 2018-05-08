//
//  YtVideo.swift
//  AppMyDelight
//
//  Created by vincent portier on 08/05/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import Foundation

class YtVideo {
    
    private var _shortPitch: String
    private var _recipeName: String
    private var _code: String
    private var _baseUrlVideo = "https://www.youtube.com/embed/"
    private var _baseUrlMiniature = "http://i.ytimg.com/vi/"
    private var _finUrlMiniature = "/maxresdefault.jpg"
    
    var shortPitch: String {
        return _shortPitch
    }
    
    var recipeName: String {
        return _recipeName
    }
    
    var videoUrl: String {
        return _baseUrlVideo + _code
    }
    
    var miniatureUrl: String {
        return _baseUrlMiniature + _code + _finUrlMiniature
    }
    
    init(shortPitch: String, recipeName: String, code: String) {
        self._shortPitch = shortPitch
        self._recipeName = recipeName
        self._code = code
    }
    
}

