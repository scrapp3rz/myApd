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
    
    
    var canCreateUsername = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardIn), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardOut), name: Notification.Name.UIKeyboardWillHide, object: nil)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cleanKeyboard)))
        Image_Fond.download(imageUrl: ME.imageUrl)
        Profile_Image.download(imageUrl: ME.imageUrl)
        Username_TextField.text = ME.username
        Username_TextField.addTarget(self, action: #selector(textUpdated(_:)), for: .editingChanged)
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
                self.Top_Constraint.constant -= heightOfKeyboard / 1.5
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
    
    @objc func textUpdated(_ textField: UITextField) {
        guard let newUsername = textField.text else { return }
        if newUsername == "" {
            canCreateUsername = false
            Error_Username.text = "Le nom d'utilisateur ne peut pas être vide"
        } else if newUsername.contains(" "){
            canCreateUsername = false
            Error_Username.text = "Le nom d'utilisateur ne peut pas comporter d'espaces"
        } else if newUsername.count >= 20 {
            canCreateUsername = false
            Error_Username.text = "Nom d'utilisateur trop long"
        } else {
            BDD().usernameExists(username: newUsername, completion: { (success, error) -> (Void) in
                guard success != nil, error != nil else { return }
                self.canCreateUsername = success!
                self.Error_Username.text = error!
            })
        }
    }


   
    @IBAction func Validation_Action(_ sender: Any) {
        view.endEditing(true)
        var dict = [String: AnyObject]()
        if Forname_TextField.text != nil {
        dict["prenom"] = Forname_TextField.text! as AnyObject
        }
        if LastName_TextField.text != nil {
            dict["nom"] = LastName_TextField.text! as AnyObject
        }
        if Username_TextField.text != nil, canCreateUsername == true {
            dict["username"] = Username_TextField.text! as AnyObject
        }
        if Description_TextView.text != "" {
            dict["description"] = Description_TextView.text as AnyObject
        }
        
        BDD().updateUser(dict: dict) { (user) -> (Void) in
            if user != nil {
                ME = user!
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func Deconnexion_Action(_ sender: Any) {
    }
    
    
    

}



































