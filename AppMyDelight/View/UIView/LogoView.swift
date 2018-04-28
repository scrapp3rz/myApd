//
//  LogoView.swift
//  AppMyDelight
//
//  Created by vincent portier on 19/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

class LogoView: UIView {


    var logoImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        logoImageView.image = #imageLiteral(resourceName: "startView")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.clipsToBounds = true
        addSubview(logoImageView)
    }
    
    
    
}
