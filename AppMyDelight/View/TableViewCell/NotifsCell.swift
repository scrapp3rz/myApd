//
//  NotifsCell.swift
//  AppMyDelight
//
//  Created by vincent portier on 08/05/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit
let NOTIFS_CELL = "NotifsCell"

class NotifsCell: UITableViewCell {

    
    @IBOutlet weak var Profile_Image: roundedImage!
    @IBOutlet weak var Posted_Image: UIImageView!
    @IBOutlet weak var Notif_Description: UILabel!
    @IBOutlet weak var Follow_Button: MydelButton!
    
    var notifs: Notifs!
    var controller: NotifController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(notifs: Notifs, controller: NotifController) {
        self.notifs = notifs
        self.controller = controller
        Profile_Image.download(imageUrl: self.notifs.user.imageUrl)
        Profile_Image.isUserInteractionEnabled = true
        Profile_Image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToProfile)))
        if self.notifs.post == nil {
            Posted_Image.isHidden = true
            Follow_Button.isHidden = false
            if ME.following.contains(self.notifs.user.id) {
                Follow_Button.setTitle("Ne plus suivre", for: .normal)
                } else {
                    Follow_Button.setTitle("suivre", for: .normal)
            }
        } else {
            Posted_Image.isHidden = false
            Follow_Button.isHidden = true
            Posted_Image.download(imageUrl: self.notifs.post!.imageUrl)
            Posted_Image.isUserInteractionEnabled = true
            Posted_Image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToPost)))
        }
        var string2 = "\n" + self.notifs.date.xTimeAgo() + "\n"
        switch self.notifs.text {
            case " a aimé votre post": string2 += self.notifs.text
            case " a commencé à vous suivre": string2 += self.notifs.text
            default: string2 += /* " a commenté : "  + */ self.notifs.text
        }
        Notif_Description.attributedText(string1: self.notifs.user.username, string2: string2)
    }
    
    @objc func goToPost() {
        let postController = PostUnicController()
        if let post = self.notifs.post {
            postController.post = self.notifs.post
            controller?.navigationController?.pushViewController(postController, animated: true)

        }
    }
    
    @objc func goToProfile() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let profileController = ProfileController(collectionViewLayout: layout)
        profileController.user = self.notifs.user
        controller?.navigationController?.pushViewController(profileController, animated: true)
        
    }
    
    @IBAction func Follow_Button_Action(_ sender: Any) {
        var follow: Bool!
        if Follow_Button.titleLabel?.text == "suivre" {
            follow = true
        } else {
            follow = false
        }
        BDD().addLike(user: self.notifs.user, follow: follow) { (user) -> (Void) in
            if user != nil {
                self.notifs.modifUser(user: user!)
                self.setup(notifs: self.notifs, controller: self.controller!)
            }
        }
    }
    
}

























