//
//  ModificationController.swift
//  AppMyDelight
//
//  Created by vincent portier on 01/05/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

class ModificationController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var Width_Constraint: NSLayoutConstraint!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var Image_Fond: UIImageView!
    @IBOutlet weak var Profile_Image: roundedImage!
    @IBOutlet weak var Username_TextField: UITextField!
    @IBOutlet weak var Error_Username: UILabel!
    @IBOutlet weak var Forname_TextField: UITextField!
    @IBOutlet weak var LastName_TextField: UITextField!
    @IBOutlet weak var Description_TextView: UITextView!
    @IBOutlet weak var Validation_Button: MydelButton!
  //  @IBOutlet weak var Top_Constraint: NSLayoutConstraint!
    @IBOutlet weak var Deconnection_Button: UIButton!
    
    
    var canCreateUsername = false
    var picker: UIImagePickerController?
    var heightOfScroll: CGFloat?
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Width_Constraint.constant = view.frame.width
        heightOfScroll = Deconnection_Button.frame.maxY + 60
        ScrollView.contentSize = CGSize(width: view.frame.width, height: heightOfScroll!)
        ScrollView.layoutIfNeeded()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker = UIImagePickerController()
        picker?.allowsEditing = true
        picker?.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardIn), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardOut), name: Notification.Name.UIKeyboardWillHide, object: nil)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cleanKeyboard)))
        Image_Fond.download(imageUrl: ME.imageUrl)
        Profile_Image.download(imageUrl: ME.imageUrl)
        Profile_Image.isUserInteractionEnabled = true
        Profile_Image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(takePhoto)))
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
    
    @objc func takePhoto() {
        ErrorDisplay().camera(controller: self, picker: picker!)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var myImage: UIImage?
        if let imageChanged = info[UIImagePickerControllerEditedImage] as? UIImage {
            myImage = imageChanged
        } else if let imageOriginale = info[UIImagePickerControllerEditedImage] as? UIImage {
            myImage = imageOriginale
        }
        self.picker?.dismiss(animated: true, completion: nil)
        guard myImage != nil, let data = UIImageJPEGRepresentation(myImage!, 0.3) else { return }
        view.createActivityIndicator()
        Stockage().addPostImage(reference: Ref().myProfileImage, data: data) { (success, urlString) -> (Void) in
            self.view.removeActivityIndicator()
            guard let result = success, result == true, urlString != nil else { return }
            BDD().updateUser(dict: (["imageUrl": urlString!] as AnyObject) as! [String : AnyObject], completion: { (user) -> (Void) in
                if user != nil {
                    ME = user!
                    self.Image_Fond.download(imageUrl: ME.imageUrl)
                    self.Profile_Image.download(imageUrl: ME.imageUrl)
                }
            })
        }
    }

    @objc func keyboardIn(notification: Notification) {
        if let heightOfKeyboard = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height, heightOfScroll != nil {
            UIView.animate(withDuration: 0.3, animations: {
                self.ScrollView.contentSize = CGSize(width: self.view.frame.width, height: self.heightOfScroll! + heightOfKeyboard)
            })
        }
    }
    
    @objc func keyboardOut(notification: Notification) {
        if heightOfScroll != nil {
            UIView.animate(withDuration: 0.3) {
                self.ScrollView.contentSize = CGSize(width: self.view.frame.width, height: self.heightOfScroll!)
            }
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
        ErrorDisplay().deconnection(controller: self)
    }
    
    
    

}



































