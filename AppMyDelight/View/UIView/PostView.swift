//
//  PostView.swift
//  AppMyDelight
//
//  Created by vincent portier on 24/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit
import SDWebImage



class PostView: UIView {

    @IBOutlet weak var Posted_Image: UIImageView!
    @IBOutlet weak var Profile_Image: roundedImage!
    @IBOutlet weak var Username_Label: UILabel!
  //  @IBOutlet weak var Post_Image: UIImageView!
    @IBOutlet weak var Number_Of_Likes: UILabel!
    @IBOutlet weak var Button_Like: UIButton!
    @IBOutlet weak var Number_Of_Comments: UILabel!
    @IBOutlet weak var Button_Comments: UIButton!
    @IBOutlet weak var TextView: TextViewWithHashtag!
    
    
    var view: UIView!
    var post: Post!
    var filController: FilController?
    var profileController: ProfileController?
    var postUnicController: PostUnicController?
    var imageViewHeart: UIImageView?
    
    
    
    @IBAction func Button_Like_Action(_ sender: Any) {
        var mylikes = self.post.likes
        if Button_Like.imageView?.image == #imageLiteral(resourceName: "coeur_vide") {
            mylikes.append(ME.id)
        } else {
            if let index = mylikes.index(of: ME.id) {
                mylikes.remove(at: index)
            }
        }
        addLikeAndNotif(myLikes: mylikes)
    }
    
    @IBAction func Button_Comments_Action(_ sender: Any) {
        
        let controller = CommentController()
        controller.comments = self.post.comments
        controller.post = self.post
        if filController != nil {
            filController?.navigationController?.pushViewController(controller, animated: true)
            } else if profileController != nil {
            profileController?.navigationController?.pushViewController(controller, animated: true)
            } else if postUnicController != nil {
            postUnicController?.navigationController?.pushViewController(controller, animated: true)
        }
        
    }
    
    
    
    

    
    func addLikeAndNotif(myLikes: [String]) {
        BDD().updatePost(postId: self.post.id, userId: self.post.user.id, dict: ["likes": myLikes as AnyObject])
        BDD().getPostsFromHashtag(dict: [self.post.id: self.post.user.id]) { (post) -> (Void) in
            if post != nil {
                self.setup(post: post!, filController: self.filController, profileController: self.profileController, postUnicController: self.postUnicController)
            }
        }
        if myLikes.contains(ME.id) && self.post.user.id != ME.id {
            let dict: [String: AnyObject] = [
                "text" : " A aimé votre post" as AnyObject,
                "date" : Date().timeIntervalSince1970 as Double as AnyObject,
                "user" : ME.id as AnyObject,
                "post" : self.post.id as AnyObject,
                "view" : false as AnyObject
            ]
            BDD().sendNotification(id: self.post.user.id, dict: dict)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        view = runXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view = runXib()
    }
    
    func setup(post: Post, filController: FilController?, profileController: ProfileController?, postUnicController: PostUnicController?) {
        self.post = post
        self.filController = filController
        self.profileController = profileController
        self.postUnicController = postUnicController
        
        // dl des images :
        Profile_Image.download(imageUrl: self.post.user.imageUrl)
        Posted_Image.download(imageUrl: self.post.imageUrl)
        
        
        // ajout Username label
        Username_Label.attributedText = usernameAndName()
        
        //ajout likes et comments
        Number_Of_Likes.text = String(self.post.likes.count)
        Number_Of_Comments.text = String(self.post.comments.count)
        observeNewComments()
        
        // ajout du Like
        if self.post.likes.contains(ME.id) {
            Button_Like.setImage(#imageLiteral(resourceName: "coeur_plein"), for: .normal)
        } else {
            Button_Like.setImage(#imageLiteral(resourceName: "coeur_vide"), for: .normal)
        }
        
        // utilisation du doubleTap
        Posted_Image.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        tap.numberOfTapsRequired = 2
        Posted_Image.addGestureRecognizer(tap)
        
        // setup du customtextview avec ## clickable
        TextView.setText(text: self.post.text, date: self.post.date)
        
        Profile_Image.isUserInteractionEnabled = true
        Username_Label.isUserInteractionEnabled = true
     //   let tapProfil = UITapGestureRecognizer(target: self, action: #selector(sendToProfile))
        Profile_Image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendToProfile)))
        Username_Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendToProfile)))
        
    }
    
    
    func observeNewComments() {
        var comms = [Comments]()
        BDD().getComment(ref: self.post.ref) { (comments) -> (Void) in
            if let comm = comments {
                if let index = comms.index(where: {$0.id == comm.id}) {
                    comms[index] = comm
                } else {
                    comms.append(comm)
                }
                self.Number_Of_Comments.text = String(self.post.comments.count)
            }
        }
    }

        

    

    
    @objc func sendToProfile() {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let controller = ProfileController(collectionViewLayout: layout)
        controller.user = self.post.user
        if filController != nil {
            filController?.navigationController?.pushViewController(controller, animated: true)
        } else if profileController != nil {
            profileController?.navigationController?.pushViewController(controller, animated: true)
        } else if postUnicController != nil {
            postUnicController?.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @objc func doubleTap() {
        
        var myLikes = self.post.likes
        if !myLikes.contains(ME.id) {
            myLikes.append(ME.id)
        }
        addLikeAndNotif(myLikes: myLikes)
        
        if imageViewHeart == nil {
            imageViewHeart = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width / 2, height: frame.width / 2))
            imageViewHeart?.image = #imageLiteral(resourceName: "coeur_double_tap")
            imageViewHeart?.center = Posted_Image.center
            Posted_Image.addSubview(imageViewHeart!)
            UIView.animate(withDuration: 0.5, animations: {
                self.imageViewHeart?.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }, completion: { (success) in
                UIView.animate(withDuration: 0.5, animations: {
                    self.imageViewHeart?.transform = CGAffineTransform.identity
                }, completion: {( success) in
                        self.imageViewHeart?.removeFromSuperview()
                    self.imageViewHeart = nil
                })
            })
        }
    }
    func usernameAndName() ->NSMutableAttributedString {
        let mutable = NSMutableAttributedString(string: self.post.user.username, attributes: [.foregroundColor: UIColor.darkGray, .font: UIFont.boldSystemFont(ofSize: 16)])
        let nameAndFornameString =  "\n" + self.post.user.forname + " " + self.post.user.lastname
        mutable.append(NSAttributedString(string: nameAndFornameString, attributes: [.foregroundColor: UIColor.darkGray, .font: UIFont.boldSystemFont(ofSize: 14)]))
        return mutable
    }
        
}
