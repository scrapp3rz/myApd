//
//  CommentsCell.swift
//  AppMyDelight
//
//  Created by vincent portier on 05/05/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

let COMMENTS_CELL = "CommentsCell"


class CommentsCell: UITableViewCell {

    
    @IBOutlet weak var Profile_Image: roundedImage!
    
    @IBOutlet weak var Name_Label: UILabel!
    
    @IBOutlet weak var Comments_Label: UILabel!
    
    var comments: Comments!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func setup(comments: Comments) {
        self.comments = comments
        
    }
}
