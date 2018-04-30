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
    @IBOutlet weak var TextView: UITextView!
    @IBOutlet weak var Segmented: UISegmentedControl!
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func Button_Switched_On(_ sender: Any) {
    }
    
    @IBAction func Segment_Choosen(_ sender: Any) {
    }
    
    
    
    
    
    
    
    
    
}
