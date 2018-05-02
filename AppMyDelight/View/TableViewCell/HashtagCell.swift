//
//  HashtagCell.swift
//  AppMyDelight
//
//  Created by vincent portier on 02/05/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

let HASHTAG_CELL = "HashtagCell"





class HashtagCell: UITableViewCell {

    
    @IBOutlet weak var Text_Hashtag: UILabel!
    
    var hashtag: Hashtag!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setup(hashtag: Hashtag) {
        self.hashtag = hashtag
        var string2: String = "\n"
        if self.hashtag.posts.count <= 1 {
            string2 += String(self.hashtag.posts.count) + " " + " mention"
        } else {
            string2 += String(self.hashtag.posts.count) + " " + " mentions"
        }
        Text_Hashtag.attributedText(string1: self.hashtag.name, string2: string2)
    }
    
    
    
    
}
