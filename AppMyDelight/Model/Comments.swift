//
//  Comments.swift
//  AppMyDelight
//
//  Created by vincent portier on 24/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Comments {
    
    private var _ref: DatabaseReference!
    private var _id: String!
    private var _user: User!
    private var _text: String!
    private var _date: Double!
    
    var ref: DatabaseReference { return _ref}
    var id: String { return _id}
    var user: User { return _user}
    var text: String { return _text }
    var date: Double { return _date}
    
    init(ref: DatabaseReference, id: String, user: User, dict: [String: AnyObject]) {
        self._ref = ref
        self._user = user
        self._id = id
        self._text = dict["text"] as? String ?? ""
        self._date = dict["date"] as? Double ?? 0
    }
    
    
}
