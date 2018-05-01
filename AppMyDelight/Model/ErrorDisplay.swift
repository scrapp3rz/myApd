//
//  ErrorDisplay.swift
//  AppMyDelight
//
//  Created by vincent portier on 19/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit
import FirebaseAuth


class ErrorDisplay {
    
    func basicError(controller: UIViewController, message: String) {
        let errorDisplay = UIAlertController(title: "erreur", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
        errorDisplay.addAction(ok)
        controller.present(errorDisplay, animated: true, completion: nil)
        
    }
    
    
    func camera(controller: UIViewController, picker: UIImagePickerController) {
        let alert = UIAlertController(title: "Choisir une photo", message: nil, preferredStyle: .alert)
        let camera = UIAlertAction(title: "Appareil photo", style: .default) { (action) in
            picker.sourceType = .camera
            controller.present(picker, animated: true, completion: nil)
        }
        let library = UIAlertAction(title: "Librairie", style: .default) { (action) in
            picker.sourceType = .photoLibrary
            controller.present(picker, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        alert.addAction(camera)
        alert.addAction(library)
        alert.addAction(cancel)
        controller.present(alert, animated: true, completion: nil)
    }
    
    func deconnection(controller: UIViewController) {
        let alerte = UIAlertController(title: "Voulez-vous vous déconnecter?", message: nil, preferredStyle: .alert)
        let answerYes = UIAlertAction(title: "Je me déconnecte", style: .default) { (action) in
            do {
                try Auth.auth().signOut()
            } catch {
                print(error.localizedDescription)
            }
            controller.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }
        let answerNo = UIAlertAction(title: "Je reste connecté", style: .cancel, handler: nil)
        alerte.addAction(answerYes)
        alerte.addAction(answerNo)
        controller.present(alerte, animated: true, completion: nil)
    }
    
}
