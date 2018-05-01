//
//  ModificationController.swift
//  AppMyDelight
//
//  Created by vincent portier on 01/05/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

class ModificationController: UIViewController {

    
    @IBOutlet weak var Image_Fond: UIImageView!
    @IBOutlet weak var Profile_Image: roundedImage!
    @IBOutlet weak var Username_TextField: UITextField!
    @IBOutlet weak var Error_Username: UILabel!
    @IBOutlet weak var Forname_TextField: UITextField!
    @IBOutlet weak var LastName_TextField: UITextField!
    @IBOutlet weak var Description_TextView: UITextView!
    @IBOutlet weak var Validation_Button: MydelButton!
    
    @IBOutlet weak var Top_Constraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardIn), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardOut), name: Notification.Name.UIKeyboardWillHide, object: nil)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cleanKeyboard)))
        Image_Fond.download(imageUrl: ME.imageUrl)
        Profile_Image.download(imageUrl: ME.imageUrl)
        Username_TextField.text = ME.username
        if ME.forname == "" {
            Forname_TextField.placeholder = "Votre prénom"
        } else {
            Forname_TextField.text = ME.forname
        }

        if ME.lastname == "" {
            LastName_TextField.placeholder = "Votre nom"
        } else {
            LastName_TextField.text = ME.lastname
        }
        Description_TextView.text = ME.description
    }
/*
    func animate(constante: CGFloat) {
        UIView.animate(withDuration: 0.35) {
            self.contrainteDuBas.constant = constante
        }
    }
  */
    @objc func keyboardIn(notification: Notification) {
        if let heightOfKeyboard = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            UIView.animate(withDuration: 0.3, animations: {
                self.Top_Constraint.constant -= heightOfKeyboard / 2
            })
        }
    }
    
    @objc func keyboardOut(notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.Top_Constraint.constant = 10
        }
    }
    
    @objc func cleanKeyboard() {
        view.endEditing(true)
    }
    


   
    @IBAction func Validation_Action(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func Deconnexion_Action(_ sender: Any) {
    }
    
    
    

}
