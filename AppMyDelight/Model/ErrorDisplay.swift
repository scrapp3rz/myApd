//
//  ErrorDisplay.swift
//  AppMyDelight
//
//  Created by vincent portier on 19/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit


class ErrorDisplay {
    
    func basicError(controller: UIViewController, message: String) {
        let errorDisplay = UIAlertController(title: "erreur", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
        errorDisplay.addAction(ok)
        controller.present(errorDisplay, animated: true, completion: nil)
        
    }
    
    
}
