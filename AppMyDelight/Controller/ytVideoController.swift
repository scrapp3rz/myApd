//
//  ytVideoController.swift
//  AppMyDelight
//
//  Created by vincent portier on 08/05/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

class ytVideoController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var TableView: UITableView!
    
    
    var ytVideos = [YtVideo]()
    
    let identifiantCell = "YoutubeVideoCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        let nib = UINib(nibName: YOUTUBEVIDEO_CELL, bundle: nil)
        TableView.register(nib, forCellReuseIdentifier: YOUTUBEVIDEO_CELL)
        NotificationCenter.default.addObserver(self, selector: #selector(addYtVideo), name: nil, object: nil)
        
        
        addYtVideo()
        title = "Recettes en vidéo"
        
        TableView.reloadData()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ytVideos.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ytVideo = ytVideos[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifiantCell) as? YoutubeVideoCell {
            cell.createCell(ytVideo)
            return cell
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = VideoController()
        controller.ytVideos = ytVideos[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
 
 
    @objc func addYtVideo() {
    //    ytVideos = [YtVideo]()
        

        let TarteNutella = YtVideo(shortPitch: "Etoile feuilletée au Nutella", recipeName: "Tarte Nutella et pâte feuilletée", code: "oy1bLDkUcag")
        ytVideos.append(TarteNutella)
        let TarteNutella1 = YtVideo(shortPitch: "Blinis express et faciles", recipeName: "Les blinis en 10' chrono", code: "Z_8iNx0f3TA")
        ytVideos.append(TarteNutella1)
        let TarteNutella2 = YtVideo(shortPitch: "Quatre-Quart traditionnel", recipeName: "4 ingrédients, une recette!", code: "NJjJtSXNAFk")
        ytVideos.append(TarteNutella2)
        let TarteNutella3 = YtVideo(shortPitch: "Fondant chocolat aux courgettes", recipeName: "Recette sans sucre", code: "Pz3h3-EbFX8")
        ytVideos.append(TarteNutella3)
        let TarteNutella4 = YtVideo(shortPitch: "Tortilla de patata traditionnelle", recipeName: "Toute l'Espagne en un tapas", code: "DT3SvdiN3SA")
        ytVideos.append(TarteNutella4)
        let TarteNutella5 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella5", code: "oy1bLDkUcag")
        ytVideos.append(TarteNutella5)
        let TarteNutella6 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella6", code: "oy1bLDkUcag")
        ytVideos.append(TarteNutella6)
        let TarteNutella7 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella7", code: "oy1bLDkUcag")
        ytVideos.append(TarteNutella7)
        let TarteNutella8 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella8", code: "oy1bLDkUcag")
        ytVideos.append(TarteNutella8)
        let TarteNutella9 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella9", code: "oy1bLDkUcag")
        ytVideos.append(TarteNutella9)
        let TarteNutella10 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella10", code: "oy1bLDkUcag")
        ytVideos.append(TarteNutella10)
        let TarteNutella11 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella11", code: "oy1bLDkUcag")
        ytVideos.append(TarteNutella11)
        let TarteNutella12 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella12", code: "oy1bLDkUcag")
        ytVideos.append(TarteNutella12)
        let TarteNutella13 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella13", code: "oy1bLDkUcag")
        ytVideos.append(TarteNutella13)
        let TarteNutella14 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella14", code: "oy1bLDkUcag")
        ytVideos.append(TarteNutella14)
        let TarteNutella15 = YtVideo(shortPitch: "Tarte Nutella et pâte feuilletée", recipeName: "Etoile feuilletée au Nutella15", code: "oy1bLDkUcag")
        ytVideos.append(TarteNutella15)
        
        
    //    TableView.reloadData()
        
    }
    
    
    
    
    
    
    
}
 
 

