//
//  PostUnicController.swift
//  AppMyDelight
//
//  Created by vincent portier on 06/05/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

class PostUnicController: UIViewController {

    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var PostView: PostView!
    
    @IBOutlet weak var Height_Constraint: NSLayoutConstraint!
    @IBOutlet weak var Width_Constraint: NSLayoutConstraint!
    
    var post: Post!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let largeur = view.frame.width
        let texte = self.post.text + "\n" + self.post.date.xTimeAgo()
        let textHeight = texte.rect(largeur: largeur - 20, font: UIFont.systemFont(ofSize: 17)).height
        let totalHeight = 150 + largeur + textHeight
        
        Width_Constraint.constant = largeur
        Height_Constraint.constant = totalHeight
        
        PostView.setup(post: self.post, filController: nil, profileController: nil, postUnicController: self)
        
    }



}
