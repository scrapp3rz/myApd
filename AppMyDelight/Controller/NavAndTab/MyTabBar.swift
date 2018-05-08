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
    
        observeNotifs()
        
  }
    
    func observeNotifs() {
        NOTIFS = [Notifs]()
        BDD().getNotifs { (notifs) -> (Void) in
            if notifs != nil {
                if let index = NOTIFS.index(where: {$0.id == notifs!.id}) {
                    NOTIFS[index] = notifs!
                } else {
                    NOTIFS.append(notifs!)
                }
                NotificationCenter.default.post(name: Notification.Name("Notifs"), object: nil)
                self.addBadgeNotif()
            }
        }
    }
    
    func addBadgeNotif() {
        guard let items = self.tabBar.items, items.count == 5 else { return }
        var notYetWatched = [Notifs]()
        for n in NOTIFS {
            if !n.view {
                notYetWatched.append(n)
            }
        }
        if notYetWatched.count > 0 {
            items[3].badgeValue = String(notYetWatched.count)
        } else {
            items[3].badgeValue = nil
        }
    }
    
    
    
    func add(controller: UIViewController, image: UIImage, title: String) -> UINavigationController {
        let nav = MyNav(rootViewController: controller)
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
        return nav
        
    }

    
    
    
}
