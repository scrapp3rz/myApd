//
//  NotifController.swift
//  AppMyDelight
//
//  Created by vincent portier on 21/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NotifController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: NOTIFS_CELL, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: NOTIFS_CELL)
        NotificationCenter.default.addObserver(self, selector: #selector(addNotifs), name: Notification.Name("Notifs"), object: nil)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { (timer) in
            for n in NOTIFS {
                n.ref.updateChildValues(["view": true as AnyObject])
            }
            NotificationCenter.default.post(name: Notification.Name("View"), object: nil)
        }
    }
    
    @objc func addNotifs(notification: Notification) {
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NOTIFS.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NOTIFS_CELL) as! NotifsCell
        cell.setup(notifs: NOTIFS[indexPath.row], controller: self)
        return cell
    }
    
    
}
