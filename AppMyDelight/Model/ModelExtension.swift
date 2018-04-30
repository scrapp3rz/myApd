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
        return NSString(string: self).boundingRect(with: size, options: options, attributes: [.font: UIFont.systemFont(ofSize: 17)], context: nil)
        
        
    }
    
    
    
}


extension Double  {
    
    func xTimeAgo() -> String {
        let currentTime = Date()
        let timeOfDouble = Date(timeIntervalSince1970: self)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day, .hour, .minute], from: timeOfDouble, to: currentTime)
        if let mois = components.month, mois > 0 {
            return "Il y a " + String(mois) + " mois"
        } else {
            if let jours = components.day, jours > 0 {
                if jours == 1 {
                    return "Hier"
                } else {
                    return "Il y a " + String(jours) + " jours"
                }
            } else {
                if let heures = components.hour, heures > 0 {
                    if heures == 1 {
                        return "Il y a 1 heure"
                    } else {
                        return "Il y a " + String(heures) + " heures"
                    }
                } else {
                    if let minutes = components.minute, minutes > 0 {
                        if minutes == 1 {
                            return "Il y a une minute"
                        } else {
                            return "Il y a " + String(minutes) + " minutes"
                        }
                    } else {
                        return "A l'instant"
                    }
                }
            }
        }
    }
}
