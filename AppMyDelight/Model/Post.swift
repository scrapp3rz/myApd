//
//  Post.swift
//  AppMyDelight
//
//  Created by vincent portier on 24/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase


class Post {
    
    private var _ref: DatabaseReference!
    private var _id: String!
    private var _user: User!
    private var _imageUrl: String!
    private var _text: String!
    private var _date: Double!
    private var _likes: [String]!
    private var _comments: [Comments]!
    
    
    var ref: DatabaseReference { return _ref }
    var id: String { return _id }
    var user: User { return _user }
    var imageUrl: String { return _imageUrl }
    var text: String { return _text }
    var date: Double { return _date }
    var likes: [String] { return _likes }
    var comments: [Comments] {return _comments }
    
    
    
    init(ref: DatabaseReference, id: String, user: User, comments: [Comments], dict: [String: AnyObject]) {
        self._ref = ref
        self._id = id
        self._user = user
        self._comments = comments
        self._imageUrl = dict["imageUrl"] as? String ?? ""
        self._text = dict["text"] as? String ?? ""
        self._date = dict["date"] as? Double ?? 0
        self._likes = dict["likes"] as? NSArray as? [String] ?? []
        comms()
    }
    
    
    func comms() {
        BDD().getComment(ref: self._ref) { (comments) -> (Void) in
            if comments != nil {
                self._comments.append(comments)
            }
        }
    }
    
    
    
}
