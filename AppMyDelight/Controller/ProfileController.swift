//
//  ProfileController.swift
//  AppMyDelight
//
//  Created by vincent portier on 21/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit


class ProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    
    var user: User?
    var posts = [Post]()
    var postComplet = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibPost = UINib(nibName: POST_CELL, bundle: nil)
        let nibSquareImage = UINib(nibName: SQUARE_IMAGE_CELL, bundle: nil)
        let reusableView = UINib(nibName: PROFILE_HEADER, bundle: nil)
        collectionView?.delegate = self
        collectionView?.register(PostCell.self, forCellWithReuseIdentifier: POST_CELL)
        collectionView?.register(nibSquareImage, forCellWithReuseIdentifier: SQUARE_IMAGE_CELL)
        collectionView?.register(reusableView, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: PROFILE_HEADER)
        
        downloadPosts()

    }

    func downloadPosts() {
        var idToParse: String
            if user != nil {
            title = user!.username
                idToParse = user!.id
            } else {
                title = ME.username
                idToParse = ME.id
        }
        BDD().getPost(user: idToParse) { (post) -> (Void) in
            if post != nil {
                if let postExist = self.posts.index(where: {$0.id == post!.id}) {
                    print("Ce poste existe déjà")
                    self.posts[postExist] = post!
                } else {
                    self.posts.append(post!)
                }
                self.sortAndReload()
            }
        }
        
    }
    
    func sortAndReload() {
        self.posts = self.posts.sorted(by: {$0.date > $1.date})
        self.collectionView?.reloadData()
        
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if postComplet {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: POST_CELL, for: indexPath) as! PostCell
            cell.setup(fil: nil, profile: self, post: posts[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SQUARE_IMAGE_CELL, for: indexPath) as! SquareImageCell
            cell.ImageView.download(imageUrl: posts[indexPath.row].imageUrl)
            return cell
        }

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if postComplet {
            let largeur = collectionView.frame.width
            let texteCompleted = posts[indexPath.row].text + "\n" + posts[indexPath.row].date.xTimeAgo()
            let heightOfText = texteCompleted.rect(largeur: largeur - 20).height
            let hauteur = 150 + largeur + heightOfText
            return CGSize(width: largeur, height: hauteur)
        } else {
            let taille = collectionView.frame.width / 4
            return CGSize(width: taille, height: taille)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let description = user?.description ?? ME.description
        let heightOfDescription = description.rect(largeur: collectionView.frame.width - 40).height
        let height = 320 + heightOfDescription
        return CGSize(width: collectionView.frame.width, height: height)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: PROFILE_HEADER, for: indexPath) as! ProfileHeader
        header.setup(controller: self, user: user ?? ME)
        
        return header
    }
}
















































