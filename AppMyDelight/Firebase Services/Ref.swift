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
    
    var rootUser: DatabaseReference { return bdd.child("user") }
    var postRoot: DatabaseReference { return bdd.child("posts") }
    var myPostsBDD: DatabaseReference { return postRoot.child(ME.id) }
    var hashtagRoot: DatabaseReference { return bdd.child("hashtag") }
    var notifsRoot: DatabaseReference { return bdd.child("notification") }
    var myNotifs: DatabaseReference { return notifsRoot.child(ME.id) }
    
    func notifUser(id: String) -> DatabaseReference {
        return notifsRoot.child(id)
    }


    func specificUser(id: String) -> DatabaseReference {
        return rootUser.child(id)
    }

    func specificHashtag(hashtag: String) -> DatabaseReference {
        return hashtagRoot.child(hashtag)
    }
    
    func specificPost(key: String, value: String) -> DatabaseReference {
        return postSpecificUser(id: value).child(key)
    }
    
    
    func postSpecificUser(id: String) -> DatabaseReference {
        return postRoot.child(id)
    }
    
    func commentSinceRef(ref: DatabaseReference) -> DatabaseReference {
        return ref.child("Comments")
    }
    
    
    // Stockage
    var rootPostImage: StorageReference { return stockage.child("posts") }
    var myPostImages: StorageReference { return rootPostImage.child(ME.id) }
    var rootProfileImage: StorageReference { return stockage.child("profile") }
    var myProfileImage: StorageReference { return rootProfileImage.child(ME.id) }
    
}
