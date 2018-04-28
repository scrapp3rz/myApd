//
//  PostCell.swift
//  AppMyDelight
//
//  Created by vincent portier on 24/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

let POST_CELL = "PostCell"


class PostCell: UICollectionViewCell {
    
    var filcontroller: FilController?
    var profileController: ProfileController?
    var post: Post!
    var postView: PostView?
    
    
    func setup(fil: FilController?, profile: ProfileController?, post: Post) {
        self.filcontroller = fil
        self.profileController = profile
        self.post = post
        if postView == nil {
            postView = PostView(frame: bounds)
            addSubview(postView!)
        }
        postView?.setup(post: self.post, filController: self.filcontroller, profileController: self.profileController)
    
    }
    
    
    
}
