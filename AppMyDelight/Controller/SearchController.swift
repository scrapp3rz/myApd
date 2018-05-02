//
//  SearchController.swift
//  AppMyDelight
//
//  Created by vincent portier on 21/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    
    @IBOutlet weak var Segment: UISegmentedControl!
    
    @IBOutlet weak var Search_Bar: UISearchBar!
    @IBOutlet weak var TableView: UITableView!
    
    
    var users = [User]()
    var hashtags = [Hashtag]()
    var onSearch = false
    var usersFiltered = [User]()
    var hashtagsFiltered = [Hashtag]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        Search_Bar.delegate = self
        let userNib = UINib(nibName: USER_CELL, bundle: nil)
        TableView.register(userNib, forCellReuseIdentifier: USER_CELL)
        let hashNib = UINib(nibName: HASHTAG_CELL, bundle: nil)
        TableView.register(hashNib, forCellReuseIdentifier: HASHTAG_CELL)
        TableView.tableFooterView = UIView()
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
            if onSearch {
                return usersFiltered.count
            } else {
                return users.count
            }
        } else {
            if onSearch {
                return hashtagsFiltered.count
            } else {
            return hashtags.count
            }
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if Segment.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: USER_CELL) as! UserCell
            if onSearch {
                cell.setup(user: usersFiltered[indexPath.row])
            } else {
                cell.setup(user: users[indexPath.row])
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: HASHTAG_CELL) as! HashtagCell
            if onSearch {
                cell.setup(hashtag: hashtagsFiltered[indexPath.row])
            } else {
            cell.setup(hashtag: hashtags[indexPath.row])
            }
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        if Segment.selectedSegmentIndex == 0 {
            let controller = ProfileController(collectionViewLayout: layout)
            if onSearch {
                controller.user = usersFiltered[indexPath.row]
            } else {
                controller.user = users[indexPath.row]
            }
            navigationController?.pushViewController(controller, animated: true)
        } else {
            let controller = FilController(collectionViewLayout: layout)
            if onSearch {
                controller.hashtag = hashtagsFiltered[indexPath.row]
            } else {
                controller.hashtag = hashtags[indexPath.row]
            }
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if Search_Bar.text == nil || Search_Bar.text == "" {
            onSearch = false
            view.endEditing(true)
        } else {
            onSearch = true
            let lowerTypo = Search_Bar.text?.lowercased()
            if Segment.selectedSegmentIndex == 0 {
                usersFiltered = users.filter{
                    return $0.username.lowercased().range(of: lowerTypo!) != nil
                        || $0.forname.lowercased().range(of: lowerTypo!) != nil
                        || $0.lastname.lowercased().range(of: lowerTypo!) != nil
                }
            } else {
                hashtagsFiltered = hashtags.filter{
                    return $0.name.lowercased().range(of: lowerTypo!) != nil
                }
            }
        }
        TableView.reloadData()
    }
    
    
}
























