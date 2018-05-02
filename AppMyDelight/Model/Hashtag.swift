//
//  Hashtag.swift
//  AppMyDelight
//
//  Created by vincent portier on 02/05/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import Foundation

class Hashtag {
    
    private var _name: String!
    private var _posts: [String: String]!
    
    var name: String { return _name}
    var posts: [String: String] { return _posts}
    
    init(name: String, posts: [String: String]) {
        self._name = name
        self._posts = posts
    }
    
}
