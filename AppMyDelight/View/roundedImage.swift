//
//  roundedImage.swift
//  AppMyDelight
//
//  Created by vincent portier on 24/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

class roundedImage: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = frame.width / 2
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        
    }
    
    
    
    
}
