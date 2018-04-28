//
//  Recipe.swift
//  MyDelightApp
//
//  Created by vincent portier on 03/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Recipe {
    private var _ref: DatabaseReference!
    private var _id: String!
    private var _recipeName: String!
    private var _instructions: String!
    private var _forXPeople: String!
    private var _prepTime: String!
    private var _cookTime: String!
    private var _temperature: String!
    private var _ingredient: [String]!
    
    
    var ref: DatabaseReference { return _ref }
    var id: String { return _id }
    var recipeName: String { return _recipeName }
    var instructions: String { return _instructions }
    var forXPeople: String { return _forXPeople }
    var prepTime: String { return _prepTime }
    var cookTime: String { return _cookTime }
    var temperature: String { return _temperature }
    var ingredient: [String] { return _ingredient }
    
    init(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: AnyObject] else { return }
        self._ref = snapshot.ref
        self._id = snapshot.key
        self._recipeName = dict["recipeName"] as? String ?? ""
        self._instructions = dict["instructions"] as? String ?? ""
        self._forXPeople = dict["forXPeople"] as? String ?? ""
        self._prepTime = dict["prepTime"] as? String ?? ""
        self._cookTime = dict["cookTime"] as? String ?? ""
        self._temperature = dict["temperature"] as? String ?? ""
        self._ingredient = dict["ingredient"] as? [String] ?? [""]
        
        
        
        
        
    }
    
    
    
    
    
    
}




