//
//  MyTabBar.swift
//  AppMyDelight
//
//  Created by vincent portier on 21/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

class MyTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        

        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let fil = FilController(collectionViewLayout: layout)
        let notif = NotifController(style: .plain)
        let profile = ProfileController(collectionViewLayout: layout)
        
        
    viewControllers = [
        
        add(controller: fil, image: #imageLiteral(resourceName: "tab_accueil"), title: "accueil"),
        add(controller: SearchController(), image: #imageLiteral(resourceName: "Search"), title: "Rechercher"),
   //     add(controller: VideoController(), image: #imageLiteral(resourceName: "Vidéos"), title: "Vidéos"),
        add(controller: PhotoController(), image: #imageLiteral(resourceName: "tab_photo"), title: ""),
        add(controller: notif, image: #imageLiteral(resourceName: "tab_notif"), title: "Notifications"),
        add(controller: profile, image: #imageLiteral(resourceName: "profil"), title: "profil")
        
    ]
    
  }
    
    func add(controller: UIViewController, image: UIImage, title: String) -> UINavigationController {
        let nav = MyNav(rootViewController: controller)
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
        return nav
        
        
        
    }

}
