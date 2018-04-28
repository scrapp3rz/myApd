//
//  Category.swift
//  MyDelightApp
//
//  Created by vincent portier on 03/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//


import Foundation
import FirebaseDatabase

class Category {
    private var _ref: DatabaseReference!
    private var _id: String!
    private var _categoryName: String!
    private var _imageURL: String!
    
    var ref: DatabaseReference { return _ref }
    var id: String { return _id }
    var categoryName: String { return _categoryName }
    var imageURL: String { return _imageURL }
    
    init(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: AnyObject] else { return }
        self._ref = snapshot.ref
        self._id = snapshot.key
        self._categoryName = dict["categoryName"] as? String ?? ""
        self._imageURL = dict["imageURL"] as? String ?? ""
        
        
    }
    
    
    
}
