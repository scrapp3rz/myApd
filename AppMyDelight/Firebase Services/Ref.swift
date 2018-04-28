//
//  Ref.swift
//  AppMyDelight
//
//  Created by vincent portier on 19/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class Ref {
    
    let bdd = Database.database().reference()
    let stockage = Storage.storage().reference()
    
    // DataBase
    
    var rootUser: DatabaseReference { return bdd.child("user")}
    var postRoot: DatabaseReference { return bdd.child("posts") }
    var myPostsBDD: DatabaseReference { return postRoot.child(ME.id) }
    var hashtagRoot: DatabaseReference { return bdd.child("hashtag")}


    func specificUser(id: String) -> DatabaseReference {
        return rootUser.child(id)
    }

    func specificHashtag(hashtag: String) -> DatabaseReference {
        return hashtagRoot.child(hashtag)
    }
    
    func postSpecificUser(id: String) -> DatabaseReference {
        return postRoot.child(id)
    }
    
    // Stockage
    var rootPostImage: StorageReference { return stockage.child("posts")}
    var myPostImages: StorageReference { return rootPostImage.child(ME.id) }
    
}
