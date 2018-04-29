//
//  ModelExtension.swift
//  AppMyDelight
//
//  Created by vincent portier on 24/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import Foundation
import UIKit



extension String {
    
    func codage() -> String {
        return addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? self
    }
    
    func decodage() -> String {
        return removingPercentEncoding ?? self
    }
    
    func rect(largeur: CGFloat) -> CGRect {
        let size = CGSize(width: largeur, height: .greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: self).boundingRect(with: size, options: options, attributes: [.font: UIFont.systemFont(ofSize: 16)], context: nil)
        
        
    }
    
    
    
}
