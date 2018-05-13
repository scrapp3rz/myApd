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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func createCell(_ ytVid: YtVideo) {
        self.ytVid = ytVid
        telechargerImage()
        let attributed = NSMutableAttributedString(string: self.ytVid.shortPitch, attributes: [.font: UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.black])
        let secondeLigne = NSAttributedString(string: "\n" + self.ytVid.recipeName, attributes: [.font: UIFont.italicSystemFont(ofSize: 16), .foregroundColor: UIColor.darkGray])
        attributed.append(secondeLigne)
        Name_Picht_Label.attributedText = attributed
    }
    
    func telechargerImage() {
        Video_Miniature.image = #imageLiteral(resourceName: "play-button")
        if let url = URL(string: self.ytVid.miniatureUrl) {
            let session = URLSession.shared
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if let imageData = data, let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.Video_Miniature.image = image
                    }
                }
            })
            task.resume()
        }
    }
    
    /*
    func setup(ytVid: YtVideo, controller: ytVideoController) {
        self.ytVid = ytVid
        self.controller = controller
        Video_Miniature.download(imageUrl: nil)
        
        
        
    }
    */
    
}

 
 
