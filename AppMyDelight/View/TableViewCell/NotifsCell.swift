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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(notifs: Notifs) {
        self.notifs = notifs
        Profile_Image.download(imageUrl: self.notifs.user.imageUrl)
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
            
        }
        var string2 = "\n"
        switch self.notifs.text {
            case " a aimé votre post": string2 += self.notifs.text
            case " a commencé à vous suivre": string2 += self.notifs.text
            default: string2 += " a commenté : " + self.notifs.text
        }
        Notif_Description.attributedText(string1: self.notifs.user.username, string2: string2)
    }
    
    
}
