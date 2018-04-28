//
//  FilController.swift
//  AppMyDelight
//
//  Created by vincent portier on 21/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit


class FilController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var posts = [Post]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(PostCell.self, forCellWithReuseIdentifier: POST_CELL)
        collectionView?.delegate = self
        getAllThePosts()

    }

    func getAllThePosts() {
        var usersToParse = ME.following
        usersToParse.append(ME.id)
        for user in usersToParse {
            BDD().getPost(user: user, completion: { (post) -> (Void) in
                if post != nil {
                    print("Post bien ajouté")
                    self.posts.append(post!)
                    self.collectionView?.reloadData()
                }
            })
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: POST_CELL, for: indexPath) as! PostCell
        cell.setup(fil: self, profile: nil, post: posts[indexPath.row])
    
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let largeur = collectionView.frame.width
        var hauteur = 150 + largeur
        return CGSize(width: largeur, height: hauteur)
    }
    

}
