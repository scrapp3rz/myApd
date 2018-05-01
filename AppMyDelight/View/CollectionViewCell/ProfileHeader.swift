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
        Followers_Label.attributedText = attributedText(string1: String(user.followers.count), string2: "\n Abonnés")
        Following_Label.attributedText = attributedText(string1: String(user.following.count), string2: "\n Abonnements")
        Username_Label.attributedText = attributedText(string1: user.username, string2: "\n" + user.forname + " " + user.lastname)
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
    
    func attributedText(string1: String, string2: String) -> NSMutableAttributedString {
        let mutable = NSMutableAttributedString(string: string1, attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.black])
        mutable.append(NSAttributedString(string: string2, attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.darkGray]))
        return mutable
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func Button_Switched_On(_ sender: Any) {
        
        if Button_Follow_Or_Change.titleLabel?.text == "Modifier" {
            let newController = ModificationController()
            controller?.navigationController?.pushViewController(newController, animated: true)
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
