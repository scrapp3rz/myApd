//
//  TextViewComment.swift
//  AppMyDelight
//
//  Created by vincent portier on 04/05/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

class TextViewComment: UITextView {

    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        layer.cornerRadius = 5
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 1
        backgroundColor = UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1)
    }

}
