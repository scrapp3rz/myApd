//
//  ConnexionController.swift
//  AppMyDelight
//
//  Created by vincent portier on 19/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit
import  FirebaseAuth

class ConnexionController: UIViewController {

    var logoView: LogoView!
    var currentView: UIView!
    var connexionView: ConnexionView!
    var myMail: String?
    var myPassword: String?
    var usernameView: UsernameView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboard()
        view.backgroundColor = .white
        logoView = LogoView(frame: view.bounds)
        connexionView = ConnexionView(frame: view.bounds)
        connexionView.addController(controller: self)
        usernameView = UsernameView(frame: view.bounds)
        usernameView.addController(controller: self)
        view.addSubview(logoView)
        currentView = logoView
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let id = Auth.auth().currentUser?.uid {
            checkUser(id: id)
        } else {
            transition(to: connexionView, transition: .transitionFlipFromRight)
        }
    }


    
    
    func validateConnexion(mailAdress: String?, password: String?) {
        myMail = mailAdress
        myPassword = password
        if let mail = myMail, mail != "" {
            if let mdp = password, myPassword != "" {
                // verif Firebase
                Auth.auth().signIn(withEmail: mail, password: mdp, completion: { (user, error) in
                    if let erreur = error {
                        let nsErreur = erreur as NSError
                        if nsErreur.code == 17011 {
                            Auth.auth().createUser(withEmail: mail, password: mdp, completion: { (user, error) in
                                if let erreur = error {
                                    ErrorDisplay().basicError(controller: self, message: erreur.localizedDescription)
                                }
                                if user != nil {
                                    self.transition(to: self.usernameView, transition: .transitionFlipFromRight)
                                }
                            })
                        } else {
                        ErrorDisplay().basicError(controller: self, message: erreur.localizedDescription)
                    }
                }
                    if let id = user?.user.uid {
                        self.checkUser(id: id)
                    }
                })
            } else {
                ErrorDisplay().basicError(controller: self, message: "Le mot de passe ne peut pas être vide")
            }
        } else {
            ErrorDisplay().basicError(controller: self, message: "L'adresse mail ne peut pas être vide")
        }
    }
    
    
    func transition(to: UIView, transition: UIViewAnimationOptions) {
        UIView.transition(from: currentView, to: to, duration: 0.7, options: transition) { (success) in
            self.currentView = to
        }
    }
    
    func checkUser(id: String) {
        BDD().getUser(id: id) { (user) -> (Void) in
            if user != nil {
                ME = user!
                self.gotoApp()
            } else {
                self.transition(to: self.usernameView, transition: .transitionFlipFromRight)
            }
        }
    }
    
    
    func gotoApp() {
        if self.viewIfLoaded?.window != nil {
            let tab = MyTabBar()
            self.present(tab, animated: true, completion: nil)
        }
    }

    
    
    
}
