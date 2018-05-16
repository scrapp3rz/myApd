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
        
        NotificationCenter.default.addObserver(self, selector: #selector(notifsViewed), name: Notification.Name("View"), object: nil)
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        

        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let fil = FilController(collectionViewLayout: layout)
        let notif = NotifController(style: .plain)
        let profile = ProfileController(collectionViewLayout: layout)
   //     let video = YouTubeVideoController(style: .plain)
        
        
    viewControllers = [
        
        
        add(controller: fil, image: #imageLiteral(resourceName: "tab_accueil"), title: "accueil"),
        add(controller: ytVideoController(), image: #imageLiteral(resourceName: "play-button"), title: "Vidéos"),
        add(controller: SearchController(), image: #imageLiteral(resourceName: "Search"), title: "Rechercher"),
    //    add(controller: TableauVideoController(), image: #imageLiteral(resourceName: "play-button"), title: "Vidéos"),
        add(controller: notif, image: #imageLiteral(resourceName: "tab_notif"), title: "Notifications"),
        add(controller: PhotoController(), image: #imageLiteral(resourceName: "tab_photo"), title: ""),
        add(controller: profile, image: #imageLiteral(resourceName: "profil"), title: "profil")
        
    ]
    
        observeNotifs()
        
  }
    
    
    @objc func notifsViewed(notification: Notification) {
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
                NOTIFS = NOTIFS.sorted(by: {$0.date > $1.date})
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
