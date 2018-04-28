//
//  User.swift
//  AppMyDelight
//
//  Created by vincent portier on 19/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit
import FirebaseDatabase


class User {
    private var _ref: DatabaseReference!
    private var _id: String!
    private var _username: String!
    private var _forname: String!
    private var _lastname: String!
    private var _description: String!
    private var _imageUrl: String!
    private var _cookingLevel: String!
    private var _followers: [String]!
    private var _following: [String]!
    
    var ref: DatabaseReference { return _ref }
    var id: String { return _id }
    var username: String { return _username }
    var forname: String { return _forname }
    var lastname: String { return _lastname }
    var description: String { return _description }
    var imageUrl: String { return _imageUrl }
    var cookingLevel: String { return _cookingLevel }
    var followers: [String] { return _followers }
    var following: [String] { return _following }
    
    init(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: AnyObject] else { return  }
        self._ref = snapshot.ref
        self._id = snapshot.key
        self._username = dict["username"] as? String ?? ""
        self._forname = dict["forname"] as? String ?? ""
        self._lastname = dict["lastname"] as? String ?? ""
        self._description = dict["description"] as? String ?? ""
        self._imageUrl = dict["imageURL"] as? String ?? ""
        self._cookingLevel = dict["cookingLevel"] as? String ?? ""
        self._followers = dict["followers"] as? [String] ?? []
        self._following = dict["following"] as? [String] ?? []
        
        
        
    }
    
    
    
    
    
    
}

