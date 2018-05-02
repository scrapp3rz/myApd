//
//  UserCell.swift
//  AppMyDelight
//
//  Created by vincent portier on 02/05/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

let USER_CELL = "UserCell"

class UserCell: UITableViewCell {

    @IBOutlet weak var Profile_Image: roundedImage!
    @IBOutlet weak var Presentation_Label: UILabel!
    
    var user: User!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setup(user: User) {
        self.user = user
        Profile_Image.download(imageUrl: self.user.imageUrl)
        let string2 = "\n" + self.user.forname + " " + self.user.lastname
        Presentation_Label.attributedText(string1: self.user.username, string2: string2)
        
    }
    
    
}
