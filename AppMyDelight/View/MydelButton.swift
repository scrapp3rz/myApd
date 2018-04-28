//
//  MydelButton.swift
//  AppMyDelight
//
//  Created by vincent portier on 19/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

class MydelButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        layer.cornerRadius = 5
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        backgroundColor = .white
        tintColor = .darkGray
        
    }
    
    
}
