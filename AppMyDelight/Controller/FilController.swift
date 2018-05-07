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
    var hashtag: Hashtag?
    var usersArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.register(PostCell.self, forCellWithReuseIdentifier: POST_CELL)
        collectionView?.delegate = self
        if hashtag != nil {
            getHash()
            title = hashtag!.name
        } else {
            getAllThePosts()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        if hashtag == nil {
            var array = ME.following
            array.append(ME.id)
            if array != usersArray {
                posts = [Post]()
                collectionView?.reloadData()
                getAllThePosts()
            }
        }
    }
    
    
    func sortAndReload() {
        self.posts = self.posts.sorted(by: {$0.date > $1.date})
        self.collectionView?.reloadData()
        
    }
    
    
    func getHash() {
        BDD().getPostsFromHashtag(dict: hashtag!.posts) { (post) -> (Void) in
            if post != nil {
                self.checkIfPostExist(post: post!)
            }
        }
    }
    
    
    
    
    func getAllThePosts() {
        var usersToParse = ME.following
        usersToParse.append(ME.id)
        usersArray = usersToParse
        for user in usersToParse {
            BDD().getPost(user: user, completion: { (post) -> (Void) in
                if post != nil {
                    self.checkIfPostExist(post: post!)
                    }
                })
            }
    }

    func checkIfPostExist(post: Post) {
        if let index = self.posts.index(where: {$0.id == post.id}) {
            self.posts[index] = post
        } else {
            self.posts.append(post)
        }
        self.sortAndReload()
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: POST_CELL, for: indexPath) as! PostCell
        cell.setup(fil: self, profile: nil, post: posts[indexPath.row])
    
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let post = posts[indexPath.row]
        let largeur = collectionView.frame.width
        var hauteur = 150 + largeur
        let texte = post.text + "\n" + post.date.xTimeAgo()
        hauteur += texte.rect(largeur: collectionView.frame.width, font: UIFont.systemFont(ofSize: 18)).height
        return CGSize(width: largeur, height: hauteur)
    }
    

}
