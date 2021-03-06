//
//  ProfileHeader.swift
//  AppMyDelight
//
//  Created by vincent portier on 30/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

let PROFILE_HEADER = "ProfileHeader"



class ProfileHeader: UICollectionReusableView {

    
    @IBOutlet weak var Image_Fond: UIImageView!
    @IBOutlet weak var Profile_Image: roundedImage!
    @IBOutlet weak var Followers_Label: UILabel!
    @IBOutlet weak var Following_Label: UILabel!
    @IBOutlet weak var Username_Label: UILabel!
    @IBOutlet weak var Button_Follow_Or_Change: MydelButton!
    @IBOutlet weak var TextView: TextViewWithHashtag!
    @IBOutlet weak var Segmented: UISegmentedControl!
    
    var user: User!
    var controller: ProfileController?
    
    
    func setup(controller: ProfileController, user: User) {
        self.controller = controller
        self.user = user
        Followers_Label.attributedText(string1: String(user.followers.count), string2: "\n Abonnés")
        Following_Label.attributedText(string1: String(user.following.count), string2: "\n Abonnements")
        Username_Label.attributedText(string1: user.username, string2: "\n" + user.forname + " " + user.lastname)
        TextView.setText(text: user.description, date: nil)
        Image_Fond.download(imageUrl: user.imageUrl)
        Profile_Image.download(imageUrl: user.imageUrl)
        
        if user.id == ME.id {
            Button_Follow_Or_Change.setTitle("Modifier", for: .normal)
        } else if user.followers.contains(ME.id) {
            Button_Follow_Or_Change.setTitle("Ne plus suivre", for: .normal)
        } else {
            Button_Follow_Or_Change.setTitle("Suivre", for: .normal)
        }
        
    }
    

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func Button_Switched_On(_ sender: Any) {
        
        if Button_Follow_Or_Change.titleLabel?.text == "Modifier" {
            let newController = ModificationController()
            controller?.navigationController?.pushViewController(newController, animated: true)
        } else {
            var follow: Bool!
            if Button_Follow_Or_Change.titleLabel?.text == "Suivre" {
                follow = true
            } else if Button_Follow_Or_Change.titleLabel?.text == "Ne plus suivre" {
                follow = false
            }
            BDD().addLike(user: self.user, follow: follow, completion:  { (user) -> (Void) in
                if user != nil {
                    self.controller?.user = user!
                    self.controller?.collectionView?.reloadData()
                }
            })
        }
        
    }
    
    @IBAction func Segment_Choosen(_ sender: Any) {
        if Segmented.selectedSegmentIndex == 0 {
            controller?.postComplet = true
            } else {
            controller?.postComplet = false
        }
        controller?.collectionView?.reloadData()
    }
    
    
    
    
    
    
    
    
    
}
