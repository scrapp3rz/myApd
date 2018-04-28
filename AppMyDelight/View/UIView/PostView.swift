//
//  PostView.swift
//  AppMyDelight
//
//  Created by vincent portier on 24/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit


class PostView: UIView {

    
    
    @IBOutlet weak var Profile_Image: roundedImage!
    @IBOutlet weak var Username_Label: UILabel!
    @IBOutlet weak var Post_Image: UIImageView!
    @IBOutlet weak var Number_Of_Likes: UILabel!
    @IBOutlet weak var Button_Like: UIButton!
    @IBOutlet weak var Number_Of_Comments: UILabel!
    @IBOutlet weak var Button_Comments: UIButton!
    @IBOutlet weak var TextView: UITextView!
    
    
    
    var view: UIView!
    var post: Post!
    var filController: FilController?
    var profileController: ProfileController?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        view = runXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view = runXib()
    }
    
    func setup(post: Post, filController: FilController?, profileController: ProfileController?) {
        self.post = post
        self.filController = filController
        self.profileController = profileController
        
        // dl des images :
        Profile_Image.download(imageUrl: self.post.user.imageUrl)
        Post_Image.download(imageUrl: self.post.imageUrl)
        
        // ajout Username label
        Username_Label.attributedText = usernameAndName()
        
        //ajout likes et comments
        Number_Of_Likes.text = String(self.post.likes.count)
        Number_Of_Comments.text = String(self.post.comments.count)
        
        
        
    }
    
    func usernameAndName() ->NSMutableAttributedString {
        let mutable = NSMutableAttributedString(string: self.post.user.username, attributes: [.foregroundColor: UIColor.darkGray, .font: UIFont.boldSystemFont(ofSize: 16)])
        let nameAndFornameString =  "\n" + self.post.user.forname + " " + self.post.user.lastname
        mutable.append(NSAttributedString(string: nameAndFornameString, attributes: [.foregroundColor: UIColor.darkGray, .font: UIFont.boldSystemFont(ofSize: 14)]))
        return mutable
    }
    
    @IBAction func Button_Like_Action(_ sender: Any) {
    }
    
    @IBAction func Button_Comments_Action(_ sender: Any) {
    }
    
    
    
}