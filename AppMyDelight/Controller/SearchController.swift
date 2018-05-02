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
        getHashtagFromBDD()
        getUserFromBDD()

    }

    func getUserFromBDD() {
        BDD().getAllUsers { (util) -> (Void) in
            if let user = util {
                self.users.append(user)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func getHashtagFromBDD() {
        BDD().getHashtags { (hash) -> (Void) in
            if let hashtag = hash {
                self.hashtags.append(hashtag)
                print(hashtag.name)
            }
        }
    }
    

    @IBAction func Segment_Choosen(_ sender: Any) {
    }
}
