//
//  CommentController.swift
//  AppMyDelight
//
//  Created by vincent portier on 03/05/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

class CommentController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: COMMENTS_CELL) as! CommentsCell
        cell.setup(comments: comments[indexPath.row])
        return cell
    }
    

    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var Send_Button: MydelButton!
    @IBOutlet weak var TextView: TextViewComment!
    @IBOutlet weak var Text_Zone: UIView!
    @IBOutlet weak var Bottom_Constraint: NSLayoutConstraint!
    @IBOutlet weak var Height_Text_Zone: NSLayoutConstraint!
    
    var comments = [Comments]()
    var post: Post!
    var originalConstraint: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        originalConstraint = Bottom_Constraint.constant
        TableView.delegate = self
        TableView.dataSource = self
        TableView.tableFooterView = UIView()
        TextView.delegate = self
        let comNib = UINib(nibName: COMMENTS_CELL, bundle: nil)
        TableView.register(comNib, forCellReuseIdentifier: COMMENTS_CELL)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardIn), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardOut), name: Notification.Name.UIKeyboardWillHide, object: nil)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideMyKeyboard)))

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    func textViewDidChange(_ textView: UITextView) {
        var top: CGFloat!
        let height = TextView.text.rect(largeur: TextView.frame.width, font: UIFont.systemFont(ofSize: 17)).height
        if height < 44 {
            top = 60
        } else {
            top = 16 + height
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.Height_Text_Zone.constant = top
        })
    }
    
    
    func animate(constante: CGFloat) {
        UIView.animate(withDuration: 0.35) {
            self.Bottom_Constraint.constant = constante
        }
    }
    
    
    @objc func keyboardIn(notification: Notification) {
        if let heightOfKeyboard = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            animate(constante: -heightOfKeyboard)
        }
    }
    
    @objc func keyboardOut(notification: Notification) {
        animate(constante: originalConstraint)
    }
    
    @objc func hideMyKeyboard() {
        view.endEditing(true)
    }
    



    
    

    @IBAction func Send_Button_Action(_ sender: Any) {
        let dict = [
            "date": Date().timeIntervalSince1970 as AnyObject,
            "text": TextView.text as AnyObject,
            "user": ME.id as AnyObject
        ]
        
        TextView.text = ""
        hideMyKeyboard()
        BDD().sendComment(ref: post.ref, dict: dict as [String: AnyObject])
        
    }
    
    
    
}


























