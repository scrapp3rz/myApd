//
//  YoutubeVideoCell.swift
//  AppMyDelight
//
//  Created by vincent portier on 09/05/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//



import UIKit

let YOUTUBEVIDEO_CELL = "YoutubeVideoCell"

class YoutubeVideoCell: UITableViewCell {

    @IBOutlet weak var Video_Miniature: UIImageView!
    @IBOutlet weak var Name_Picht_Label: UILabel!
    
    var ytVid: YtVideo!
    var controller: ytVideoController?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(ytVid: YtVideo, controller: ytVideoController) {
        self.ytVid = ytVid
        self.controller = controller
        Video_Miniature.download(imageUrl: nil)
        
        
    }
    
    
}

 
 
