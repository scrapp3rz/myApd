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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

    


   
    @IBAction func Validation_Action(_ sender: Any) {
    }
    
    @IBAction func Deconnexion_Action(_ sender: Any) {
    }
    
    
    

}
