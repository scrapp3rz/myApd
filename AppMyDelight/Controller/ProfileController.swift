//
//  ProfileController.swift
//  AppMyDelight
//
//  Created by vincent portier on 21/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit


class ProfileController: UICollectionViewController {

    
    var user: User?
    var posts = [Post]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibPost = UINib(nibName: POST_CELL, bundle: nil)
        let nibSquareImage = UINib(nibName: SQUARE_IMAGE_CELL, bundle: nil)
        collectionView?.register(nibPost, forCellWithReuseIdentifier: POST_CELL)
        collectionView?.register(nibSquareImage, forCellWithReuseIdentifier: SQUARE_IMAGE_CELL)
        
        
        // Do any additional setup after loading the view.
        if user != nil {
            title = user!.username
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

  

}
