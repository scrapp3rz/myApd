//
//  Ingredient.swift
//  MyDelightApp
//
//  Created by vincent portier on 03/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//


import Foundation
import FirebaseDatabase

class Ingredient {
    private var _ref: DatabaseReference!
    private var _id: String!
    private var _ingredientName: String!
    private var _measure: String!
    
    
    var ref: DatabaseReference { return _ref }
    var id: String { return _id }
    var ingredientName: String { return _ingredientName }
    var measure: String { return _measure }

    
    init(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: AnyObject] else { return }
        self._ref = snapshot.ref
        self._id = snapshot.key
        self._ingredientName = dict["ingredientName"] as? String ?? ""
        self._measure = dict["measure"] as? String ?? ""
    }
    
    
    
}



