//
//  Notifs.swift
//  AppMyDelight
//
//  Created by vincent portier on 07/05/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Notifs {
    
    private var _ref: DatabaseReference!
    private var _id: String!
    private var _user: User!
    private var _post: Post?
    private var _date: Double!
    private var _text: String!
    private var _view: Bool!
    
    var ref: DatabaseReference { return _ref}
    var id: String { return _id}
    var user: User { return _user }
    var post: Post? { return _post }
    var date: Double { return _date }
    var text: String { return _text }
    var view: Bool { return _view}
    
    init(ref: DatabaseReference, id: String, user: User, post: Post?, date: Double, text: String, view: Bool) {
        self._ref = ref
        self._id = id
        self._user = user
        self._post = post
        self._date = date
        self._text = text
        self._view = view
    }
    
    func modifUser(user: User) {
        self._user = user
    }
    
}
