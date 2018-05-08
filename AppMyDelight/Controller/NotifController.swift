//
//  NotifController.swift
//  AppMyDelight
//
//  Created by vincent portier on 21/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

class NotifController: UITableViewController {
    
    var notifs = [Notifs]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: NOTIFS_CELL, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: NOTIFS_CELL)
        

        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifs.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NOTIFS_CELL) as! NotifsCell
        cell.setup(notifs: notifs[indexPath.row])
        return cell
    }
    
    
}
