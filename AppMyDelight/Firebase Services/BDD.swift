//
//  BDD.swift
//  AppMyDelight
//
//  Created by vincent portier on 19/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth



class BDD {
    
    func getUser(id: String, completion: UserCompletion?) {
        Ref().specificUser(id: id).observe(.value) { (snapshot) in
            if snapshot.exists(), let _ = snapshot.value as? [String: AnyObject] {
                completion?(User(snapshot: snapshot))
            } else {
                completion?(nil)
            }
        }
    }
    
    
    func getAllUsers(completion: UserCompletion?) {
        Ref().rootUser.observe(.childAdded) { (snapshot) in
            completion?(User(snapshot: snapshot))
        }
    }
    
    func usernameExists(username: String, completion: SuccessCompletion?) {
        Ref().rootUser.queryOrdered(byChild: "username").queryEqual(toValue: username).observeSingleEvent(of: .value) { (snapshot) in
            if !snapshot.exists() {
                completion?(true, "")
            } else {
                completion?(false, "nom déjà pris")
            }
        }
    }
    
    func updateUser(dict:  [String: AnyObject], completion: UserCompletion?) {
        guard let id = Auth.auth().currentUser?.uid else { return }
        Ref().specificUser(id: id).updateChildValues(dict) { (error, ref) in
            if error == nil {
                self.getUser(id: id, completion: { (user) -> (Void) in
                    completion?(user)
                })
            }
        }
        
    }
    
    func createPost(dict: [String: AnyObject]) {
        Ref().myPostsBDD.childByAutoId().updateChildValues(dict) { (error, ref) in
            guard error == nil, let postId = ref.description().components(separatedBy: "/").last else { return }
            guard let string = dict["text"] as? String else { return }
            let words = string.components(separatedBy: " ")
            for word in words {
                if word.hasPrefix("#") {
                    self.addHashtag(postId: postId, word: word)
                }
            }
        }
    }
    
    func addHashtag(postId: String, word: String) {
        Ref().specificHashtag(hashtag: word.codage()).updateChildValues([postId: ME.id])
        
    }
   
    func getHashtags(completion: HashtagCompletion?) {
        Ref().hashtagRoot.observe(.childAdded) { (snapshot) in
            if let dict = snapshot.value as? [String: String] {
                let nameDecoded = snapshot.key.decodage()
                let newHashtag = Hashtag(name: nameDecoded, posts: dict)
                completion?(newHashtag)
            }
        }
    }
    
    
    
    func getPost(user: String, completion: PostCompletion?) {
        getUser(id: user) { (util) -> (Void) in
            if util != nil {
                Ref().postSpecificUser(id: user).observe(.childAdded, with: { (snapshot) in
                    completion?(self.convertPost(user: util!, snapshot: snapshot))
                })
            }
        }
    }
    
    func convertPost(user: User, snapshot: DataSnapshot) -> Post? {
        let postId = snapshot.key
        if let dict = snapshot.value as? [String: AnyObject] {
            return Post(ref: snapshot.ref, id: postId, user: user, comments: [], dict: dict)
        } else {
            return nil
        }
    }
    
    
    func getPostsFromHashtag(dict: [String: String], completion: @escaping PostCompletion) {
        for (key, value) in dict {
            getUser(id: value, completion: { (utilisateur) -> (Void) in
                if let user = utilisateur {
                    Ref().specificPost(key: key, value: value).observe(.value, with: { (snapshot) in
                        completion(self.convertPost(user: utilisateur!, snapshot: snapshot))
                    })
                } else {
                    completion(nil)
                }
            })
            
        }
    }
    
    
    func updatePost(postId: String, userId: String,  dict: [String: AnyObject]) {
        Ref().specificPost(key: postId, value: userId).updateChildValues(dict)
        
    }
    
    
    
    
    
    
}






































