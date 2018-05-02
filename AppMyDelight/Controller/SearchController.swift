//
//  SearchController.swift
//  AppMyDelight
//
//  Created by vincent portier on 21/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var Segment: UISegmentedControl!
    
    @IBOutlet weak var TableView: UITableView!
    
    
    var users = [User]()
    var hashtags = [Hashtag]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        let userNib = UINib(nibName: USER_CELL, bundle: nil)
        TableView.register(userNib, forCellReuseIdentifier: USER_CELL)
        let hashNib = UINib(nibName: HASHTAG_CELL, bundle: nil)
        TableView.register(hashNib, forCellReuseIdentifier: HASHTAG_CELL)

        getHashtagFromBDD()
        getUserFromBDD()
    }

    func getUserFromBDD() {
        BDD().getAllUsers { (util) -> (Void) in
            if let user = util {
                self.users.append(user)
                self.TableView.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Segment.selectedSegmentIndex == 0 {
            return users.count
        } else {
            return hashtags.count
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if Segment.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: USER_CELL) as! UserCell
            cell.setup(user: users[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: HASHTAG_CELL) as! HashtagCell
            cell.setup(hashtag: hashtags[indexPath.row])
            return cell
        }
    }

    func getHashtagFromBDD() {
        BDD().getHashtags { (hash) -> (Void) in
            if let hashtag = hash {
                self.hashtags.append(hashtag)
                self.TableView.reloadData()
                print(hashtag.name)
            }
        }
    }
    

    @IBAction func Segment_Choosen(_ sender: Any) {
            TableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if Segment.selectedSegmentIndex == 0 {
            return 80
        } else {
            return 50
        }
    }
    
    
}
