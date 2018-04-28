//
//  FinishPostController.swift
//  AppMyDelight
//
//  Created by vincent portier on 24/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

class FinishPostController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var Profile_Image: roundedImage!
    @IBOutlet weak var Posted_Image: UIImageView!
    @IBOutlet weak var TextView: UITextView!
    
    var image: UIImage!
    var canAdd = true
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboard()
        Posted_Image.image = image
        TextView.delegate = self
        let suivant = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(finishPost))
        navigationItem.rightBarButtonItem = suivant
        
    }
    
    
    @objc func finishPost() {
        if canAdd {
            canAdd = false
            checkTextView()
            // enregistrer image dans le Stockage
            guard let data = UIImageJPEGRepresentation(image, 0.5) else { return }
            view.createActivityIndicator()
            Stockage().addPostImage(data: data) { (success, string) -> (Void) in
                // qui le convertit en URLString
                self.canAdd = true
                self.view.removeActivityIndicator()
                if let reussi = success, reussi == true, string != nil {
                    let dict: [String: AnyObject] = [
                        "imageURL": string! as AnyObject,
                        "id": ME.id as AnyObject,
                        "text": self.TextView.text as AnyObject,
                        "date": Date().timeIntervalSince1970 as AnyObject
                    ]
                    //  et finir par ajouter le post sur la bdd avec URLString
                    BDD().createPost(dict: dict)
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
            
        }
        
    }
        
        
    func checkTextView() {
        if TextView.text == "Commentaires..." {
            TextView.text = ""
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        checkTextView()
    }
 
}
