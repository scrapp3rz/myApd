//
//  UsernameView.swift
//  AppMyDelight
//
//  Created by vincent portier on 20/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

class UsernameView: UIView {

    
    @IBOutlet weak var Username_Text_Field: UITextField!
    @IBOutlet weak var Error_Label: UILabel!
    
    
    @IBAction func Valid_Button_Action(_ sender: Any) {
        if Username_Text_Field.text != nil, canCreateUsername {
            BDD().updateUser(dict: ["username": Username_Text_Field.text! as AnyObject],
                completion: { (user) -> (Void) in
                if user != nil {
                    ME = user!
                    self.connexionController?.gotoApp()
                }
            })
        }
    }
    @IBAction func Back_Button(_ sender: Any) {
        connexionController?.transition(to: (connexionController?.connexionView)!, transition: .transitionFlipFromLeft)
    }
    
    var view: UIView!
    var connexionController: ConnexionController?
    var canCreateUsername  = false
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        view = runXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view = runXib()
    }

    func addController(controller: ConnexionController) {
        self.connexionController = controller
        Username_Text_Field.addTarget(self, action: #selector(textUpdated), for: .editingChanged)
    }
    
    
    @objc func textUpdated(_ textField: UITextField) {
        guard let newUsername = textField.text else { return }
        if newUsername == "" {
        canCreateUsername = false
            Error_Label.text = "Le nom d'utilisateur ne peut pas être vide"
        } else if newUsername.contains(" "){
            canCreateUsername = false
            Error_Label.text = "Le nom d'utilisateur ne peut pas comporter d'espaces"
        } else if newUsername.count >= 20 {
            canCreateUsername = false
            Error_Label.text = "Nom d'utilisateur trop long"
        } else {
            BDD().usernameExists(username: newUsername, completion: { (success, error) -> (Void) in
                guard success != nil, error != nil else { return }
                self.canCreateUsername = success!
                self.Error_Label.text = error!
            })
        }
    }


}
