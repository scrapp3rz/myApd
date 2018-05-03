//
//  CommentController.swift
//  AppMyDelight
//
//  Created by vincent portier on 03/05/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

class CommentController: UIViewController {

    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var Send_Button: MydelButton!
    @IBOutlet weak var TextView: UITextView!
    @IBOutlet weak var Text_Zone: UIView!
    @IBOutlet weak var Bottom_Constraint: NSLayoutConstraint!
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func Send_Button_Action(_ sender: Any) {
        
    }
    
    
    
}
